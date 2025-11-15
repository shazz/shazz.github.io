Title: Fury Vaccine
Slug: fury
Name: Fury Vaccine
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Fury vaccine
image: {filename}../../../gallery/vaccines/fury.png
Tags: Vaccine


## Basic Information

- *Author*: Fabrice Odéro, a.k.a. Fury of Legacy
- *Type*: bootsector
- *Subtype*: Memory checker
- *Size*: 182 bytes
- *Resident*: no
- *Self-replicating*: no
- *Can clean memory*: no
- *Special features*: 
    - Raster effect if the memory is not clean

### Description

Fury's vaccine looks to be a modification of Dr Satan Memory Virus Protector, the memory check code is identical and so only checks that the `HDV_BPB` vector is in TOS 1.0-1.04 memory range. So pretty limited and won't work with TOS 1.06+.

<img src="{attach}fury_photo_0.png" width="45%"/>&nbsp;<img src="{attach}fury_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:red">No</span>     |
| Valid reset vector              | <span style="color:red">No</span>     |        
| Non-ROM HDV BPB Vector          | <span style="color:green">Yes</span>  |
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

A cheap modification of Dr Satan Memory Virus Protector but doesn't do more.

A dissapointing 2/10

