Title: Odie vaccine
Slug: odie
Name: Odie vaccine
Date: 2025-11-08 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the odie vaccine
image: {filename}../../../gallery/vaccines/odie.png
Tags: Vaccine


## Basic Information

- *Author*: Unknown (SSR?) 
- *Type*: bootsector
- *Subtype*: Resident guardian
- *Size*: 480 bytes
- *Resident*: yes
- *Memory resistant*: no 
- *Self-replicating*: yes 
- *Can clean memory*: no
- *Special features*: 
    - Display Odie (from Garfield cartoon) logo at boot
    - If an inserted floppy is executable (and not Odie), the screen will flash red

### Description

The Odie vaccine is a resident vaccine attaching itself to `HDV_BPB` (but not reset-resistent) and only warns the user if the read floppy is executable. It does not make any additional checks. As a lot of Atari ST bootsectors are executable (or just contain a vaccine), that won't help that much.

<img src="{attach}odie_photo_0.png" width="45%"/>&nbsp;<img src="{attach}odie_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:red">No</span>     |
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
| Other threat detection          | <span style="color:green">Yes</span> (executable bootsector) |

## Conclusion

A vaccine which is pretty useless but it is always nice to see Odie while booting!

A design-award 2/10.

