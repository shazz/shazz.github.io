Title: Killer's Antivirus v3.0
Slug: killers
Name: Killer's Antivirus v3.0
Date: 2025-11-09 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Killer's Antivirus v3.0
image: {filename}../../../gallery/vaccines/killers.png
Tags: Vaccine


## Basic Information

- *Author*: Killer's from Euroswap (guessed)
- *Type*: bootsector
- *Subtype*: Memory checker
- *Size*: 464 bytes
- *Resident*: no
- *Memory resistant*: no 
- *Self-replicating*: no
- *Can clean memory*: yes
- *Special features*: 
    - Can set 512K and 1048K emulation
    - 50/60Hz switch

### Description

The Killer's Antivirus v3.0 is a classic boot menu vaccine (somewhat similar to Viruskicker), it checks for reset vectors and undocumented resident programs. As optional features, it can emulate Atari 520ST and 1040ST by modifying `PHYSTOP`, `MEMTOP` and `VRAM_PTR` accordingly, and also switch the monitor frequency between 50 and 60Hz.

It can clear the ST memory partially by clearing `RESVALID`, `MEMVALID`, `MEMVAL2`, `MEMVAL3` (to force a TOS partial memory clear), then call the reset vector. Note that it will reset the `RESVEC` to a boggy address (but not valid).

<img src="{attach}killers_photo_0.png" width="45%"/>&nbsp;<img src="{attach}killers_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:orange">Partial</span>     |
| Undocumented resident program   | <span style="color:green">Yes</span>     |
| Valid reset vector              | <span style="color:green">Yes</span>     |        
| Non-ROM HDV BPB Vector          | <span style="color:red">No</span>     |
| Non-ROM HDV RW Vector           | <span style="color:red">No</span>     |
| Non-ROM HDV BOOT Vector         | <span style="color:red">No</span>     |
| Non-ROM HDV INIT Vector         | <span style="color:red">No</span>     |
| Non-ROM HDV MEDIACH Vector      | <span style="color:red">No</span>     |
| Non-ROM Trap Gemdos Vector      | <span style="color:red">No</span>     |
| Non-ROM Trap Bios Vector        | <span style="color:red">No</span>     | 
| Non-ROM Trap Xbios Vector       | <span style="color:red">No</span>     |
| Non-ROM Trap Unused Vector      | <span style="color:red">No</span>     |
| Flopwr Trap calls               | <span style="color:red">No</span>     | 
| Check if boot is executable     | <span style="color:red">No</span>     | 
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

A good boot memory checker, usefull for crackers thanks to his 520ST emulation

A deserved 7/10.

