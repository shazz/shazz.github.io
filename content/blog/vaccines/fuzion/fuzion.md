Title: Fuzion Fullscreen
Slug: fuzion
Name: Fuzion Fullscreen
Date: 2025-11-06 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Fuzion Fullscreen vaccine.
image: {filename}../../../gallery/vaccines/fuzion.png
Tags: Vaccine


## Basic Information

- *Author*: Fuzion? ST Connexion? Doubtful....
- *Type*: bootsector
- *Size*: ? bytes
- *Resident*: no
 - *Memory resistant*: no
- *Self-replicating*: no
- *Can clean memory*: yes
- *Special features*: 
    - A bug prevents the main effect to show up: Fuzion logos in fullscreen and bad exit whoch freezes the GEM.
    - In the bootsector, there is an uused string: 'CODE BY FUZION & ST CNX'

### Description

The Fuzion Fullscreen vaccine is a pretty buggy vaccine, looks unfinished / debugged. In terms of "vaccination" it only looks for valid Reset Vector and if found will force a reset (in a very similar way to the Jedi / Sector One Viruskicker).

Here are the screenshots of the vaccine at boot, after a hard reboot and when the Ghost virus is already in memory (and so undetected):


<img src="{attach}fuzion_photo_2.png" width="45%"/>&nbsp;<img src="{attach}fuzion_photo_3.png" width="45%"/>


When fixing the bug in the bootsector (when detecting the screen resolution), here is what people should see:

<img src="{attach}fuzion_photo_0.png" width="45%"/>&nbsp;<img src="{attach}fuzion_photo_1.png" width="45%"/>


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
| Check if boot is executable     | <span style="color:red">No</span>     | 
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

Definitively not a great vacccine but the attempt to display a fullscreen effect in a bootsector is an interesting (and somewhat useless) challenge. Unfortunately it is pretty buggy.

A "can be better next time" 3/10

