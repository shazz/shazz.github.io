Title: Stealth tricks use by viruses
Slug: StealthTricks
Date: 2024-09-08 21:30
Location: San Francisco / US
Category: Atari ST
Lang: en
Author: shazz

Along the time, virus creators had to find technical solutions to have their viruses undetected if they wanted them to spread. Here is a list of common tricks I found in viruses to avoid detection.

### Messing with the standard bootsector format

#### The bootsector branch

The Atari Specification requires the first word of the bootsector, if executable, to be a branch to the bootcode located at 0x1E. So most of the executable bootsectors start with `0x601C` (`BRA.S $1E`). And it was probably an obvious check done by the first generation of virus detectors, antiviruses and virus killers.

Then some viruses started to diverge from the specification, it could be by branching to a later byte of the bootcode like `0x601A`, `0x6020`. These are still branches.

Some virus creators found our that in fact, the branch instruction could occur after the first word, within the `OEM reserved` section and that basically the first word did not matter in this case.

Personally I have no clue why it works, but it works! Looking at the TOS source code, that's not obvious:

```asm
dmaboot:
/* --- boot from DMA device */
dmadone:
	    moveq	  #0,d7     /* d7 = device (ASCI0) */

#if TOSVERSION >= 0x106
		move.l    _hz_200.l,-(a7)
#endif

confdone:
		suba.l    a4,a4
dmadev:
        bsr.s     _dmaread             /* read first sector of this device */
        bne.s     nextdev
        move.l    _dskbufp(a4),a0      /* buf = _dskbufp */
        move.w    #256-1,d1            /* 256 word checksum over the boot sector */
        moveq.l   #0,d0
dmacrc:
        add.w     (a0)+,d0
        dbf       d1,dmacrc
        cmp.w     #$1234,d0            /* checksum == 0x1234? */
        bne.s     nextdev              
        /* execute this valid boot sector */
        move.l    _dskbufp(a4),a0      /* buf = _dskbufp */
        jsr       (a0)                   /* execute boot sector */
nextdev:
        add.b     #$20,d7
        bne.s     confdone
#if TOSVERSION >= 0x106
		addq.l     #4,a7
#endif
        rts
```

As you can see the TOS does a simple `JSR (a0)` on the disk buffer so my understanding is that the the "not a branch" bytes should at least being legal instructions (like $0000 0000 which translates to ORI.B #$0, D0) that won't crash. So not random bytes but useless bytes.

#### The word checksum

As specified and implemented, normally to be executable, bootsectors word checksum should be equal to `0x1234` but with some tricks, it is possible to bypass this rule


### Static Code analysis

First generation of antivirus relied on statistical bootsector comparison. Meaning antiviruses had libraries of bootsectors (virus but also games, demos, virus killers) and they were comparing actual bootsectors with their library to find the best match.

I works well IF the virus is already in the library else, the only feedback an antivirus was giving to the user was if the bootsector was executable or not, which doesn't say much.

So Antivirus creators added basic static code analysis which his basically looking for typical instructions and set of instructions messing with some key registers and especially vectors (`hdv_bpb` and `hdv_rw` are probably the most frequent ones used by viruses) and TRAP calls. And based on the number of "virus" patterns found, the antivirus were able to give a risk indicator.

As an answer to this new method of detection, viruses creators started to obfuscate the code to get the pattern recognition useless. Multiple "tricks" can be found to obfuscate the code:
 
 - avoid immediate values when read/writing typical registers and use CPU data registers.
 - used auto-modified code to change the fake immediate values into the real values. [Toubab Virus]
 - replace TRAP calls by calls to existing vectors (`rwabs` for example) [BHP Virus]
 - use indirect and relative addressing types to hide the register address [Toubab Virus]
 - ...

And in the latest generation of Atari ST viruses, it started to be common to see virus fully "encrypted" (usually using a key located in the bootsector and the `EOR` operation, or sometimes a simple shift using `SUB` or `ADD`) [Macumba 3.3 Virus]

#### Bypassing the virus killers boot check

Most ST users were relying on Virus Killers: special bootsectors written by antiviruses usually to "protect and immunize" floppies. Those bootsectors were most of the time, at boot only, checking the memory and warning the user in case of some virus presence or in most case of abnormal memory configuration (vectors, resident programs,...). But as said this check was only performed at boot.

So some virus are using some delay capabilities, typically the will wait some time after every boot to set the `hdv_bpb` vector for example, to avoid being detected. [Tiny Virus]

Some other viruses were targeting Virus Killers bootsectors directly and replace themselves by the virus. [Toubab Virus]


### Social engineering

Or sometimes the easiest solution to hide is to let people (And antivirus) that, as a virus, you are something else.
It was common to see virus reusing parts of virus killers (Especially the message) to have enough matching bytes to be recognized as a non-virus bootsector.

And when it was not to fool the antivirus, it could be to fool the user and avoid suspicion (and virus testing), so some viruses were mimicking the classic virus killers functionalities: colorful boot message claiming there is no virus in memory typically.




