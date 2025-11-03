Title: Anti-Virus Preventor
Slug: adrenaline
Name: Anti-Virus Preventor
Date: 2025-11-03 16:12
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Adrenaline Anti-Virus Preventor vaccine...
image: {filename}../../../gallery/vaccines/adrenaline.png
Tags: Vaccine


## Basic Information

- *Author*: FirSTE & Dr Computer
- *Type*: bootsector
- *Size*: 441 bytes
- *Resident*: yes (0x140)
- *Self-replicating*: yes (on non-executable bootsectors)
- *Can clean memory*: partial, only found resident program
- *Special features*: 
    - Attaches it self to `HDV_BPB` vector to replicate itself but not for chcking for viruses on disk

### Description

The Adrenaline Anti-Virus Preventor 1.8a was written by FirSTE and Laurent Provin aka Dr Computer who is well known for coding the Adrenaline Ripper. 
Despite the fact it can replicate itself as a virus, it was released with an installer program. 
Its detection capabilities are limited as most of the source code is used for its replication and I guess it could be considered by antivruses as a virus as it uses the exact same technics.

Note that a Trojan called Adrenaline Preventor 1.8b exists which shares the same source code but added some additional viral capabilities. This "mutation" was an easy step considering the little differences between a genuine virus and this vaccine and the remaining free space. 


<img src="{attach}adrenaline_photo_0.png" width="45%"/><img src="{attach}adrenaline_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result version 1.8a                   |
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
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Non-ROM Trap Unused Vector      | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

Original as it reuses much of existing viruses basic technics to spread without the user consent (only on non-executable bootsectors fortunately) but its threat detection capabilities are really limited at the end and won't detect/override dormant viruses.

A good 7/10.

###  Appendix

The installer is downloadable here: [demozoo](https://demozoo.org/productions/132449/)