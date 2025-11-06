Title: Pompey Pirates vaccine
Slug: pompey
Name: Pompey Pirates vaccine
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Pompey Pirates vaccine
image: {filename}../../../gallery/vaccines/pompey.png
Tags: Vaccine


## Basic Information

- *Author*: Pompey Pirates
- *Type*: bootsector
- *Size*: 232 bytes
- *Resident*: no
- *Self-replicating*: no
- *Can clean memory*: partial (clear `RESVECTOR`, `RESVALID` and call TOS 1.0-1.04 reset)
- *Special features*:  None

### Description

The Pompey Pirates vaccine is probably one of the first vaccine, pretty rudimentary it only detects valid reset vector. And as most viruses clear the reset vector after usage, it is safe to say that this vaccine won't detect many viruses. The vaccine could be installed using Pompey Pirates' Floppy Virus Killer 2.0 and 3.0.


Here are the screenshots of the vaccine at boot, after a hard reboot and when the Ghost virus is already in memory (and so undetected):

<img src="{attach}pompey_photo_0.png" width="45%"/>&nbsp;<img src="{attach}pompey_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:red">No</span>     |
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
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

Interesting as one of the first vaccine but overall pretty useless and gives a false sense of safety.

A not so good 1/10

You can download Floppy Virus Killer which can install the Pompey Pirates vaccine at [demozoo](https://demozoo.org/productions/130449/)

