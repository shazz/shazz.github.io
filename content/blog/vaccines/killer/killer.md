Title: Killer Boot 2.08
Slug: killer
Name: Killer Boot 2.08
Date: 2025-11-04 18:24
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Killer Boot 2.08 vaccine...
image: {filename}../../../gallery/vaccines/killer.png
Tags: Vaccine


## Basic Information

- *Author*: E. Collignon
- *Type*: bootsector
- *Subtype*: Memory checker
- *Size*: 444 bytes
- *Resident*: no
 - *Memory resistant*: no
- *Self-replicating*: no
- *Can clean memory*: yes, use a patched bus error vector to clear the memory
- *Special features*: 
    - Messages are encoded
    - If found, check the resident program address is correctly set
    - Look for 2 unknown footprints ('ALEX' and 'MORT') if a resident program is found in memory which will bypass the detection, there are probably "authorized" reset routines?
    - Nice sound at boot

### Description

The Killer Boot is the vaccine provided the The Killer 2.0 antivirus. Other versions named 2.0 and 2.04 exist but aren't that different. It is not clear where those versions come from as I never saw version 2.04 and 2.08 of the Antivirus software.

<img src="{attach}killer_photo_0.png" width="45%"/>&nbsp;<img src="{attach}killer_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
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
| Check if boot is executable     | <span style="color:red">No</span>     | 
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:green">Yes</span> (specific resident program bypass) |

## Conclusion

A vaccine which was pretty common thanks to The Killer antivirus which was distributed by Omikron (which also distributed the famous Omikron Basic with the Atari ST), it doesn't do much but good enough to detect most resident resistant viruses

A good 6/10 as, like the antivirus it comes with, it is nice to use and reliable.

### The antivirus

You can read [here](/the_killer-en.html) the test of The Killer antivirus.