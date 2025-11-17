Title: Fuzion Virus Killer III
Slug: fuzionviruskiller
Name: Fuzion Virus Killer III
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Fuzion Virus Killer III
image: {filename}../../../gallery/vaccines/fuzionviruskiller.png
Tags: Vaccine


## Basic Information

- *Author*: Orion from Fuzion
- *Type*: bootsector
- *Subtype*: Memory checker and resident guardian
- *Size*: 478 bytes
- *Resident*: yes 
- *Self-replicating*: yes
- *Can clean memory*: Partial (clear `RESVALID` and call TOS Reset vector)
- *Special features*: 
    - Replicate automatically if the bootsector contains the undocumented resident program magic word
    - Register access is obfuscated

### Description

The Fuzion Virus Killer III is an interesting hybrid memory checker and resident guardian vaccine, it doesn't do an in-depth memory check but at least check for any reset resistant programs and vectors and can partially clean the memory (but won't trigger a full memory clean). And at the same time, it attaches to `HDV_BPB` to detect any bootsector which contains (in plain text) the undocument resident program magic word and if found, will replicate itself instead while playing a sound.

<img src="{attach}fuzionviruskiller_photo_0.png" width="45%"/>&nbsp;<img src="{attach}fuzionviruskiller_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:green">Yes</span>  |
| Valid reset vector              | <span style="color:green">Yes</span>  |        
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
| Other threat detection          | <span style="color:green">Yes</span> (Replicates on bootsectors which contain 0x12123456) |

### Other versions

This version is probably the first one, note that it is NEG encoded and is not resident in memory.

<img src="{attach}fuzionviruskiller_photo_4.png" width="45%"/>&nbsp;<img src="{attach}fuzionviruskiller_photo_5.png" width="45%"/>


This version, probably the version 2, is similar to version 3 but less sophisticated and different rules for detection.

<img src="{attach}fuzionviruskiller_photo_2.png" width="45%"/>&nbsp;<img src="{attach}fuzionviruskiller_photo_3.png" width="45%"/>


## Conclusion

The Fuzion Virus Killer III is a good hybrid vaccine, not going in depth on both sides but good enough to protect against some early generation viruses (not encoded)

A well deserved 8/10.

