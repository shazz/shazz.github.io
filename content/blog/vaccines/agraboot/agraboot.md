Title: Agraboot 2
Slug: agraboot
Name: Agraboot 2
Date: 2025-11-03 16:12
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Agraboot 2 vaccine...
image: {filename}../../../gallery/vaccines/agraboot.png
Tags: Vaccine


## Basic Information

- *Author*: Agrajag
- *Type*: bootsector
- *Subtype*: Memory checker and resident guardian
- *Size*: 441 bytes
- *Resident*: yes
- *Self-replicating*: no
- *Can clean memory*: partial (resets `RESVALID`, resident program header) forcing a TOS incomplete memory clean
- *Special features*: 
    - Flash the screen in black and play a sound if the current bootsector is executable (based on checksum)
    - Flash the screen in red and play a sound if the current bootsector is executable and if `rwabs` or `flopwr` trap calls are found in the bootsector
    - Install itself in the `HDV_BPB` vector to stay resident.

### Description

The Agraboot 2 was written by Michael James aka Agarjag from Adrenalin UK, that's a resident vaccine so, when the GEM is loaded, any disk read (using `getBPB()`) will be checked and the screen will flash if some suspicious patterns are found (typically any code attemting to write on the disk). 


<img src="{attach}agraboot_photo_0.png" width="30%"/>&nbsp;<img src="{attach}agraboot_photo_1.png" width="30%"/>&nbsp;<img src="{attach}agraboot_photo_2.png" width="30%"/>


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
| Flopwr Trap calls               | <span style="color:green">Yes</span>  | 
| Rwabs Trap calls                | <span style="color:green">Yes</span>  | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

The fact it is checking for reset resistant programs, stays resident in memory and detect suspicious trap calls, even if it won't work with encrypted viruses, makes it a pretty powerful vaccine.

A rock solid 8/10.

###  Appendix

The installer is downloadable here: [demozoo](https://demozoo.org/productions/160777/)