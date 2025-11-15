Title: The Tripple H Killer
Slug: trippleh
Name: The Tripple H Killer
Date: 2025-11-15 15:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the The Tripple H Killer
image: {filename}../../../gallery/vaccines/trippleh.png
Tags: Vaccine


## Basic Information

- *Author*: The Master from Tripple H
- *Type*: bootsector
- *Subtype*: Memory checker and resident guardian
- *Size*: 388 bytes
- *Resident*: Yes
- *Self-replicating*: No
- *Can clean memory*: Partial (clears `RESVALID`, `RESVECTOR`, `HDV_BPB`, `HDV_RW` and locks the system to force a reset)
- *Special features*: 
    - Changes colors and plays a sound when when an executable bootsector is read (using `HDV_BPB`)

### Description

The Tripple H Killer v1.10 vaccine is shipped with the Ultimate Virus Checker, also by The Master. It is a very decent vaccine which combines a memory checker (reset vector, undocument resident program, non-TOS `HDV_BPB`, `HDV_RW`, `HDV_BOOT`, Gemdos, Xbos and Bios vectors) at boot and a resident guardian to check for executable disks and new valid reset vector (and remove it).


<img src="{attach}trippleh_photo_0.png" width="45%"/>&nbsp;<img src="{attach}trippleh_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:green">Yes</span>  |
| Valid reset vector              | <span style="color:green">Yes</span>  |          
| Non-ROM HDV BPB Vector          | <span style="color:green">Yes</span>  |
| Non-ROM HDV RW Vector           | <span style="color:green">Yes</span>  |
| Non-ROM HDV BOOT Vector         | <span style="color:green">Yes</span>  |
| Non-ROM HDV INIT Vector         | <span style="color:red">No</span>     |
| Non-ROM HDV MEDIACH Vector      | <span style="color:red">No</span>     |
| Non-ROM Trap Gemdos Vector      | <span style="color:green">Yes</span>  |
| Non-ROM Trap Bios Vector        | <span style="color:green">Yes</span>  | 
| Non-ROM Trap Xbios Vector       | <span style="color:green">Yes</span>  |
| Non-ROM Trap Unused Vector      | <span style="color:red">No</span>     |
| Flopwr Trap calls               | <span style="color:red">No</span>     | 
| Check if boot is executable     | <span style="color:green">Yes</span>  | 
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

### Older versions

Version 1.0 which checks less vectors but overall pretty similar.

<img src="{attach}trippleh_photo_2.png" width="45%"/>&nbsp;<img src="{attach}trippleh_photo_3.png" width="45%"/>

## Conclusion

The Tripple H Killer is a really good hybrid vaccine which acts as a very good memory checker at boot and also provide some resident capabilities.

A well deserved 9/10.

