Title: Vaccin Gillus
Slug: vaccingillus
Name: Vaccin Gillus
Date: 2025-11-04 16:12
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Vaccin Gillus...
image: {filename}../../../gallery/vaccines/vaccingillus.png
Tags: Vaccine


## Basic Information

- *Author*: Gillus Sauvaire
- *Type*: bootsector
- *Size*: 462 bytes
- *Resident*: yes
- *Self-replicating*: yes
- *Can clean memory*: No
- *Special features*: None

### Description

If Vaccin-gillus wqas advertised as a vaccine, even if famous French ST magazine, that's in fact nothing less than a virus.... It has absolutely no detection capabilities and reused many parts of the famous Ghost virus only changing the symptoms and adding a buggy raster effect at load. As a good old nasty virus, it replicates on any bootsector and stay resident.
It is to noticed that the author added a checksum in the code to avoid "ripping" and simple message modification that would crash the bootsector.

<img src="{attach}vaccingillus_photo_0.png" width="45%"/>


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

This vaccine ... is at realy a disguised virus, pretty shameful from somebody known in the community (especially known for providing a lot of game cheats) and who has his "vaccine" advertised in a major ST magazine in an article on viruses and how to avoid them.

A very shameful 0/10 (as a vaccine, even as a virus)

