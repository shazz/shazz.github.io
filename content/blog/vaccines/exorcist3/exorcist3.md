Title: Exorcist 3 vaccine
Slug: exorcist3
Name: Exorcist 3 vaccine
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Exorcist 3 vaccine
image: {filename}../../../gallery/vaccines/exorcist3.png
Tags: Vaccine


## Basic Information

- *Author*: IKI of ESC
- *Type*: bootsector
- *Size*: 478 bytes
- *Resident*: yes 
- *Memory resistant*: yes
- *Self-replicating*: yes
- *Can clean memory*: no
- *Special features*: 
    - Use Screen dump to duplicate itself
    - Code is obfuscated, message encoded

### Description

The Exorcist 3 vaccine is shipped with the Exorcist 3 antivirus. This vaccine code is pretty complex for some unknown reasons, registers are obfuscated, boot message encoded. Probably to avoid ripping. The vaccine installs itself as an undocument resident program while looking and deleting any other resident program (and flash the screen to warn the user) and copies itself at `0x140` where many viruses can be also be found.
It clears the reset vector and install itself as a reset vector. It also attaches itself to `HDV_BPB` to catch executable bootsectors.

So installing itself will probabably disable most resident viruses besides the fact it doesn't have a true check and clean routine.

As a result, by implementing the most common viruses practices (`HDV_BPB`, `RESVECTOR`, location at 0x140 and undocumented resident program), the vaccine will probably replaces most of the existing viruses.

Then, as a resident program when the GEM is loaded, it will flash the border in red if the current bootsector is executable (except itself).

Note that requesting a hard copy of the screen will trigger the vaccine replication!

<img src="{attach}exorcist3_photo_0.png" width="45%"/>&nbsp;<img src="{attach}exorcist3_photo_1.png" width="45%"/>

## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:green">Yes</span>     |
| Valid reset vector              | <span style="color:orange">Partial</span> (doesn't check but replace by itself)   |        
| Non-ROM HDV BPB Vector          | <span style="color:orange">Partial</span> (as it will attach itself to `HDV_BPB`)    |
| Non-ROM HDV RW Vector           | <span style="color:orange">Partial</span>     |
| Non-ROM HDV BOOT Vector         | <span style="color:red">No</span>     |
| Non-ROM HDV INIT Vector         | <span style="color:red">No</span>     |
| Non-ROM HDV MEDIACH Vector      | <span style="color:red">No</span>     |
| Non-ROM Trap Gemdos Vector      | <span style="color:red">No</span>     |
| Non-ROM Trap Bios Vector        | <span style="color:red">No</span>     | 
| Non-ROM Trap Xbios Vector       | <span style="color:red">No</span>     |
| Non-ROM Trap Unused Vector      | <span style="color:red">No</span>     |
| Flopwr Trap calls               | <span style="color:red">No</span>     | 
| Check if boot is executable     | <span style="color:green">Yes</span>  | 
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Other versions

Another version of the Exorcist 3 vaccine exist, called Exorcist 3 "PRO", the code is moslty identical and so the features, the boot message is different, probably to show the licensing of the antivirus software.

<img src="{attach}exorcist3_photo_2.png" width="45%"/>

## Conclusion

The Exorcist 3 vaccine is a good mix between vaccines focusing on memory check at boot while being also a resident vaccine but with very limited detection capablities.

A refreshing 7/10.

