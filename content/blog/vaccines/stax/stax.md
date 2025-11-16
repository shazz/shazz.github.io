Title: STAX Boot Saver
Slug: stax
Name: STAX Boot Saver
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the STAX Boot Saver
image: {filename}../../../gallery/vaccines/stax.png
Tags: Vaccine


## Basic Information

- *Author*: Matt of STAX
- *Type*: bootsector
- *Subtype*: Memory checker
- *Size*: 266 bytes
- *Resident*: no
- *Self-replicating*: no
- *Can clean memory*: no
- *Special features*: 
    - None

### Description

The STAX Boot Saver is only checking if the low byte of the reset vector is 0 to decide is there is a virus or not in memory. That's fairly limited and won't detect many viruses.

<img src="{attach}stax_photo_3.png" width="45%"/>&nbsp;<img src="{attach}stax_photo_4.png" width="45%"/>


## Detection capabilities
| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:red">No</span>     |
| Valid reset vector              | <span style="color:orange">Partial</span>|        
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

### Other versions

<img src="{attach}stax_photo_0.png" width="45%"/>&nbsp;<img src="{attach}stax_photo_1.png" width="45%"/>

### Installer

<img src="{attach}stax_photo_2.png" width="45%"/>

## Conclusion

Unfortunately, there is more work in the installer than on the vaccine itself which is doing a poor job.

A not great 1/10

