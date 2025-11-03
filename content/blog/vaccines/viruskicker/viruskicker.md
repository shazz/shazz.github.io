Title: Virus Kicker
Slug: viruskicker
Name: Virus Kicker
Date: 2025-11-03 16:12
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Virus Kicker 2 and 3 vaccine...
image: {filename}../../../gallery/vaccines/viruskicker.png
Tags: Vaccine


## Basic Information

- *Author*: Jedi / Sector One / The Heavy Killers (version 2), Shazz / MJJ prod (improvements for version 3)
- *Type*: bootsector
- *Size*: 490 bytes
- *Resident*: no
- *Self-replicating*: no
- *Can clean memory*: yes
- *Special features*: 
    - Can copy itself on other disks
    - Can set a persistent name for a disk (stored in the vaccine itself)
    - Switch 50/60 Hz monitor frequency (version 2 only)

### Description

The Virus Kicker 2 was first published in STMAGICIEL, a special edition of ST Magazine the 23rd of July 1991 as a assembly and GFA basic listings.
The version 3 is an optimized version done by Shazz / MJJ Prod, adding new detection capabilities.


<img src="{attach}vk_photo_0.png" width="45%"/><img src="{attach}vk_photo_1.png" width="45%"/> 


## Detection capabilities

| Threat                          | Result version 2                        | Result version 3                      |
|---------------------------------|:---------------------------------------:|:-------------------------------------:|
| Check memory boundary           | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:green">Yes</span>    | <span style="color:green">Yes</span>  |
| Undocumented resident program   | <span style="color:green">Yes</span>    | <span style="color:green">Yes</span>  |
| Valid reset vector              | <span style="color:red">No</span>       | <span style="color:green">Yes</span>  |            
| Non-ROM HDV BPB Vector          | <span style="color:red">No</span>       | <span style="color:green">Yes</span>  |
| Non-ROM HDV RW Vector           | <span style="color:red">No</span>       | <span style="color:green">Yes</span>  |
| Non-ROM HDV BOOT Vector         | <span style="color:red">No</span>       | <span style="color:green">Yes</span>  |
| Non-ROM HDV INIT Vector         | <span style="color:red">No</span>       | <span style="color:green">Yes</span>  |
| Non-ROM HDV MEDIACH Vector      | <span style="color:red">No</span>       | <span style="color:green">Yes</span>  |
| Non-ROM Trap Gemdos Vector      | <span style="color:red">No</span>       | <span style="color:green">Yes</span>  |
| Non-ROM Trap Bios Vector        | <span style="color:red">No</span>       | <span style="color:green">Yes</span>  |
| Non-ROM Trap Xbios Vector       | <span style="color:red">No</span>       | <span style="color:green">Yes</span>  |
| Non-ROM Trap Unused Vector      | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| Non-ROM Trap Unused Vector      | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>       | <span style="color:red">No</span>     |

##  Appendix

You can download the scan of the original MAGICIEL page [here](https://archive.org/details/st-magazine-hs1/page/n7/mode/2up) on the Internet Archive.