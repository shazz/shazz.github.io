Title: Cyclades vaccine
Slug: santorin
Name: Cyclades vaccine
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Cyclades vaccine
image: {filename}../../../gallery/vaccines/santorin.png
Tags: Vaccine


## Basic Information

- *Author*: Santorin from Cyclades
- *Type*: bootsector
- *Subtype*: ?
- *Size*: 461 bytes
- *Resident*: no
 - *Memory resistant*: no 
- *Self-replicating*: no
- *Can clean memory*: partially, clear `RESVALID` and call Reset vector
- *Special features*: 
    - Code is obfuscated (shifted memory registers, message is XOR encoded, logo is encoded), maybe to avoid being detected or to avoid being ripped?

### Description

The Cyclades vaccine is pretty unique with its huge logo and at then end by checking the Reset Vector, undocumented resident programs and suspicious `HDV_BPB` vectors, it does a good job!

<img src="{attach}santorin_photo_0.png" width="45%"/>&nbsp;<img src="{attach}santorin_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:green">Yes</span>  |
| Valid reset vector              | <span style="color:green">Yes</span>  |        
| Non-ROM HDV BPB Vector          | <span style="color:green">Yes</span>  |
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

One of the most original vaccine from a French ST demo group.

A great 8/10 thanks to its unique design while being efficient!

