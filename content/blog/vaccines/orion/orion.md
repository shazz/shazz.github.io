Title: Orion vaccine
Slug: orion
Name: Orion vaccine
Date: 2025-11-07 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Orion vaccine
image: {filename}../../../gallery/vaccines/orion.png
Tags: Vaccine


## Basic Information

- *Author*: Teddy from Orion (Swiss)
- *Type*: bootsector
- *Size*: 480 bytes
- *Resident*: yes (if a virus is found)
- *Self-replicating*: no
- *Can clean memory*: no
- *Special features*: 
    - Starts to scroll the screen if a virus is found and attaches to the reset vector to force a hard reset
    - The code is encoded (not.b) and when decoded exposes some nasty messages to reverse engineers like me :)

### Description

The Orion vaccine looks for undocumented resident programs and valid reset vectors. If found it won't clear the memory but replace the reset vector and show the warning message forever.

<img src="{attach}orion_photo_0.png" width="45%"/>&nbsp;<img src="{attach}orion_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:green">Yes</span> (4MB fix) |
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
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:green">Yes</span> (Ghost patch)    |

## Conclusion

Most (good) vaccines will clean the memory, this one has an orginal strategy, look the screen and warm reset to force the user to switch off the ST. Funny

A 6/10 for its originality

