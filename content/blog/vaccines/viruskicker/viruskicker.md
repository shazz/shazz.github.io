Title: Virus Kicker
Slug: viruskicker
Name: Virus Kicker
Date: 2025-11-03 16:12
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Virus Kicker 2, 3 and 4 vaccines...
image: {filename}../../../gallery/vaccines/viruskicker.png
Tags: Vaccine


## Basic Information

- *Author*: Jedi / Sector One / The Heavy Killers (version 2 and 3), Shazz / MJJ prod (improvements for version 3)
- *Type*: bootsector
- *Subtype*: ?
- *Size*: 490 bytes
- *Resident*: no
 - *Memory resistant*: no
- *Self-replicating*: no
- *Can clean memory*: yes
- *Special features*: 
    - Can copy itself on other disks
    - Can set a persistent name for a disk (stored in the vaccine itself)
    - Switch 50/60 Hz monitor frequency (version 2 only)

### Description

The Virus Kicker 2 was first published in STMAGICIEL, a special edition of ST Magazine the 23rd of July 1991 as a assembly and GFA basic listings.
The version 4 is an optimized version done by Shazz / MJJ Prod, adding new detection capabilities.


<img src="{attach}vk_photo_2.png" width="45%"/>&nbsp;<img src="{attach}vk_photo_3.png" width="45%"/>


## Detection capabilities

| Threat                          | Result version 2 and 3                  | Result version 4                      |
|---------------------------------|:---------------------------------------:|:-------------------------------------:|
| Check memory boundary           | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
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
| Flopwr Trap calls               | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| Rwabs Trap calls                | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>       | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>       | <span style="color:red">No</span>     |

## Conclusion

Even if the versions 2 and 3 were doing a good job, the extensive check on vectors in the version 3 is providing a pretty good memory check each time the vaccine is loaded. So it won't detact dormant viruses (not yet loaded) as this is not a resident vaccine but will prevent any memory infection to spread.

A pretty solid 8/10.

## Appendixes

### Older versions

<img src="{attach}vk_photo_0.png" width="45%"/>&nbsp;<img src="{attach}vk_photo_1.png" width="45%"/>


### Variants

Jedi reused the version 3 code to make the Fantasy Killer version

<img src="{attach}fantasykiller_photo_0.png" width="45%"/>&nbsp;<img src="{attach}fantasykiller_photo_1.png" width="45%"/>

And also the Dune Killer v1.2 version

<img src="{attach}dunekiller12_photo_0.png" width="45%"/>&nbsp;<img src="{attach}dunekiller12_photo_1.png" width="45%"/>

###  Listing

You can download the scan of the original MAGICIEL page [here](https://archive.org/details/st-magazine-hs1/page/n7/mode/2up) on the Internet Archive.