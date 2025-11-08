Title: Zuul Protector 1.01
Slug: zuulprotector
Name: Zuul Protector 1.01
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Zuul Protector 1.01 vaccine
image: {filename}../../../gallery/vaccines/zuulprotector.png
Tags: Vaccine


## Basic Information

- *Author*: Tristar from Zuul (not confirmed, doubtful)
- *Type*: bootsector
- *Size*: 342 bytes
- *Resident*: no 
- *Self-replicating*: no
- *Can clean memory*: no
- *Special features*: None

### Description

The Zuul Protector 1.01... doesn't protect of anything, this is just a simple message shown at boot. Pretty useless.

<img src="{attach}zuulprotector_photo_0.png" width="45%"/>

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
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

Hard to call this bootsector a vaccine or worse a protector.

A well deserved 0/10


You can find the unreadable installer on [demozoo](https://demozoo.org/productions/81663/). Note that it doesn't full erase the previous bootsector and create some junk.

