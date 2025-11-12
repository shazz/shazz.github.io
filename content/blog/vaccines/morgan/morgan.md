Title: No Virus v1.08
Slug: morgan
Name: No Virus v1.08
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the No Virus v1.08
image: {filename}../../../gallery/vaccines/morgan.png
Tags: Vaccine


## Basic Information

- *Author*: Morgan Roussel aka Morgan / Explorers (then Dune and Fantasy) in 1992
- *Type*: bootsector
- *Subtype*: ?
- *Size*: 480 bytes
- *Resident*: no
 - *Memory resistant*: no 
- *Self-replicating*: yes
- *Can clean memory*: Partially, resets `MEMVALID` and `RESVALID` then call the TOS reset vector
- *Special features*: 
    - Message is not-encoded
    - Menu to name and duplicate the vaccine

### Description

The No Virus v1.08 is somewhat very similar to the Viruskicker (And its variant called the Dune Virus Killer 1.2 and Fantasy Killer) but with some key (buggy) differences:

 - The messages are encoded (and re-encoded if the bootsector is written to a new disk)
 - The messages are slightly bigger and repeated so less space for vaccination
 - It uses the ACIA to read the keyboard and it requires to keep the key pressed on reset (when it works)
 - It a resident program is found, the vaccine directly resets

<img src="{attach}morgan_photo_0.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:green">Yes</span>  |
| Valid reset vector              | <span style="color:reen">Yes</span>   |        
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

It is hard to know when this vaccine was created, before / after reusing Jedi's viruskicker, but the fact is.. it is very buggy.

An average 4/10

