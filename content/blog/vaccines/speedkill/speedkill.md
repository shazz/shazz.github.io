Title: Speed Kill 3.0
Slug: speedkill
Name: Speed Kill 3.0
Date: 2025-11-07 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the speedkill vaccine
image: {filename}../../../gallery/vaccines/speedkill.png
Tags: Vaccine


## Basic Information

- *Author*: Morlock from Deus
- *Type*: bootsector
- *Subtype*: Memory checker
- *Size*: 396 bytes
- *Resident*: no
 - *Memory resistant*: no
- *Self-replicating*: no
- *Can clean memory*: no
- *Special features*: None

### Description

The Speed Kill vaccine checks for a valid reset vector and provides a quick warning but doesn't clean anything. And that won't catch most of the viruses.

<img src="{attach}speedkill_photo_0.png" width="45%"/>&nbsp;<img src="{attach}speedkill_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:green">Yes</span>  |
| Valid reset vector              | <span style="color:red">No</span>     |        
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

Despite a somewhat nice raster effect, the Speed Kill vaccine doesn't do much.

A little 2/10

