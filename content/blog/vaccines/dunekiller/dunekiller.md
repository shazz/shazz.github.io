Title: Dune Killer 1.02
Slug: dunekiller
Name: Dune Killer 1.02
Date: 2025-11-03 16:12
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Dune Killer 1.02...
image: {filename}../../../gallery/vaccines/dunekiller.png
Tags: Vaccine


## Basic Information

- *Author*: Alrik from Dune
- *Type*: bootsector
- *Size*: 336 bytes
- *Resident*: yes
- *Self-replicating*: yes
- *Can clean memory*: partial (resets `MEMVALID`, `MEMCTLR`) then calls TOS sysbase but never called due to a bug
- *Special features*: None

### Description

It is hard to tell if the Dune Killer is a vaccine or an intented virus.... for sure it tries to detect if a program is attached to `HDV_BPB` vector (which is typically used by viruses, but not always) and reset the ST in case of... But the code is buggy and this condition will never happen (plus the fact the vaccine set itself prior to the test). And at the same time, it attachs itself to this vector then replicates on any disk inserted.
So at then... it doesn't detect anything and replicates on any disk possibly deleting important bootsectors.

| No virus | Ghost in memory |
|:--------:|:---------------:|
|<img src="{attach}dunekiller_photo_0.png" width="100%"/>|<img src="{attach}dunekiller_photo_0.png" width="100%"/>|


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:red">No</span>     |
| Valid reset vector              | <span style="color:red">No</span>     |        
| Non-ROM HDV BPB Vector          | <span style="color:orange">Partial</span> (doesn't work)  |
| Non-ROM HDV RW Vector           | <span style="color:red">No</span>     |
| Non-ROM HDV BOOT Vector         | <span style="color:red">No</span>     |
| Non-ROM HDV INIT Vector         | <span style="color:red">No</span>     |
| Non-ROM HDV MEDIACH Vector      | <span style="color:red">No</span>     |
| Non-ROM Trap Gemdos Vector      | <span style="color:red">No</span>     |
| Non-ROM Trap Bios Vector        | <span style="color:red">No</span>     | 
| Non-ROM Trap Xbios Vector       | <span style="color:red">No</span>     |
| Non-ROM Trap Unused Vector      | <span style="color:red">No</span>     |
| Flopwr Trap calls               | <span style="color:red">No</span>     | 
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

This vaccine ... is at best a non-intended virus, pretty surprising from somebody from a well known and respected demo crew.

A shameful 0/10 (as a vaccine)


### Download link

The installer is downloadable here: [demozoo](https://demozoo.org/productions/132450/)

### Bugs in the code

```asm
           movea.l $4f2.w, a0          ; BUG! a0 = sysbase, not set yet in some TOS burign bootsector execution
            movea.l $472.w, a1          ; a1 = hdv_bpb
            suba.l a0, a1               ; BUG! suba doesn't affect flags
            bpl.w L88_show_no_virus     ; will never be false!

virus_in_mem:
            lea.l L14E(pc), a1          ; a1 = virus in mem msg
            bsr.w L92_print             ; call L92_print
            bsr.w L9E_get_key           ; call L9E_get_key
            clr.l $420.w                ; clear memvalid
            clr.l $424.w                ; clear memctrl
            movea.l $4f2.w, a0          ; a0 = sysbase
            jmp (a0)                    ; call tos sysbase (kind of reset)
```