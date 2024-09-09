Title: The (nearly) Tiny Virus from Lucky Lady
Slug: NotSoTinyVirus
Date: 2024-09-08 11:24
Location: San Francisco / US
Category: Atari ST, Virus
Lang: en
Author: shazz
status: published
summary: Short version for index and feeds

## Introduction

After the pleasure to document the BHP virus, it was somewhat logical to continue with the Tiny Virus which claims... to be tiny. As I found the BHP virus to be a quite good and small template for virus replication, let's see if the Tiny Virus, released at least 6 years later (in 1994) was doing better.

The scope of this virus is pretty identical, it doesn't trigger any symptoms or implement reset resistant strategies, it focuses on replication and staying alive.

## High level specs

To summarize and before going into the details, here are the main characteristics of the Tiny Virus:

 - **executable bootsector** virus
 - Delay the custom `hdv_bpb` vector to be detected by Virus killers using a VBL-timed routine to replace the original **HDV_BPB vector**
 - replicates itself on A only but on any floppy inserted.
 - is relatively small, 192 bytes (BHP is 166 bytes)
 - it obfuscates (gently) the `rwabs` system call to avoid static code analysis detection.


## The details

The only new feature in this Tiny Virus is this routine to delay the virus installation in the `hdv_bpb` vector. 

Using a VBL routine added to the last slot of the VBL List (to limit the risks to be overwritten), it will wait 5376 VBLs to install its `hdv_bpb` vector. I think this is smart, takes few bytes and may work!

### The Loader

The Bootcode starts at 0x1E, but with an empty long but it seems the TOS doesn't care and jump to the first "executable" instruction. Then as soon as copied in `DISKBUF` and being executed, it will

 - Copy itself in his hidden low RAM (in the user vectors) location: `0x01C0`
 - Set the VBL routine in the last lost of VBL_LIST and enable it using the `VBLSEM` register

```asm
; ----------------------------------------------------------------------------------------------------------
; Empty long at branch address
; ----------------------------------------------------------------------------------------------------------

        DC.L   0
; ----------------------------------------------------------------------------------------------------------
; START
; ----------------------------------------------------------------------------------------------------------

START:
        MOVEA.W   #RAM_LOCATION,A0                  ; A0 = $1C0 (448)
        LEA       START(PC),A1                    
        MOVE.W    #(END-START),D0                   ; for d0 = 188 to 0 (0xBC)
.copy:
        MOVE.B    (A1)+,(A0)+                       ; copy 189 bytes to RAM_LOCATION (1C0)
        DBF       D0,.copy

        MOVE.L    #0,VBLCLOCK_LOW.L                 ; reset VBL counter            
        MOVE.W    #VBL_ROUTINE_ADDR,VBL_LIST+2      ; set VBL_ROUTINE in VBL_LIST routine 7 low nibble (enough as in lower RAM)    move.l #$12e, $4ec.l vs #$252
        MOVE.W    #1,VBLSEM.L                       ; enable VBL routine
        RTS 
```

### The VBL routine

The VBL routine, called at each VBL, will check:

 - Check the current VBL counter (`VBLCLOCK_LOW`) and if it is equals to 5376, it will:
    - Save the current `hdv_bpb` vector.
    - Install the `hdv_bpb` vector .

Note that, when the `VBLCLOCK_LOW` will loop, the old hdv_bpv vector will be deleted... but I guess that's acceptable, every 3 years with no reset :D

```asm
; ----------------------------------------------------------------------------------------------------------
; VBL routine
; Protection mechanism, Used  to set again, in case of, the HDV_BPB vector, every ~100s
; ----------------------------------------------------------------------------------------------------------        
VBL_ROUTINE:                        
        MOVEA.L   #CHECK_DELAY,A1                   ; A1 = CHECK_DELAY (0x1500 = 5376)
        CMPA.L    VBLCLOCK_LOW.L,A1                 ; if VBLCLOCK_LOW == 5376 (around 100s)
        BNE       .not_yet
        MOVE.L    HDV_BPB.L,OLD_HDV_BPB_VECTOR.L    ; Save old HDV_BPB vector to OLD_HDV_BPB_VECTOR (0x140)
        MOVE.L    #HDV_BPB_VECTOR_ADDR,HDV_BPB.L    ; Set new hdv_pbp vector to HDV_BPB_VECTOR (0x1EE)
.not_yet:
        RTS 
```

### The HDV_BPB vector

Now that the virus is installed in memory, and that the VBL routine has set the `hdv_bpb` vector, it will wait any call to BIOS `Getbpb()` which retrieves the `BPB` (Bios Parameter Block) of the floppy disk. 
This vector will:

 - Copy the bootcode from upper RAM to the disk buffer currently read by `Getbpb()`
   - Note the code copies 222 bytes of bootcode which is more of the size of the bootcode itself.
 - Set the bootsector branch
 - Use `Protobt` Xbios TRAP to build an executable bootsector from the disk buffer
 - Use `Rwabs` Bios TRAP to write the bootsector on A:
   - Note that the `Rwabs` TRAP opcode is "obfuscated" (`MOVE.L #$40001,-(sp)`) by merging it with the `mode` parameter to avoid detection.
 - Finally jumps to the original `hdvbpb` vector

## Conclusion

That's it! Is the challenge solved? From my point of view, not really on the fact the virus is that tiny, its replication mechanism is too basic (especially compared to the BHP Virus) and relatively easy to spot by an antivirus even if TRAP calls to `FLOPRD` and `FLOPWR` were avoided and TRAP call to `Rwabs` was a little obfuscated. But the obvious `Protobt` is like a red nose, impossible to miss.

Nevertheless, the delay trick to setup the `hdv_bpb` vector and avoid bootsectors virus killers is very small and ingenious. So... this part, I really appreciated it.

As usual, you can download the full commented, and tested identical to the original virus after assembling with [vasm](http://www.compilers.de/vasm.html) here: [TINY.S]({attach}sources/TINY.S)


## Appendices

### Fun facts

 - In the UVK book, Richard wrote "This was the smallest virus so far, occupying only 34% of a bootsector". I disagree, not the smallest (192 bytes, and a little more than 34%), BHP was smaller (166 bytes, 14% less)
 - At the end of the virus, Lucky Lady signed it with some not-used data: "DC.B 'TINY'"
 - In the OEM bytes, the text "KOBOL" is written, maybe a tribute to the KOBOLD 2 virus?

### Still to do

 - Nothing

## Run the virus!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("TINY") }}