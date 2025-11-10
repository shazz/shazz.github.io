Title: Terminator vaccine
Slug: terminator
Name: Terminator
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Terminator vaccine.
image: {filename}../../../gallery/vaccines/terminator.png
Tags: Vaccine


## Basic Information

- *Author*: Megaguru
- *Type*: bootsector
- *Size*: 480 bytes
- *Resident*: no
 - *Memory resistant*: no 
- *Self-replicating*: no
- *Can clean memory*: Partially: clear `RESVALID`, `REVECTOR`, magic word in resident program if found and call $4.w reset vector
- *Special features*: 
    - Immunize memory if Ghost is loaded at $140

### Description

The Megaguru is a vaccine which, like many others, checks for set reset vectors and undcoumented resident programs. It really looks like a ripped version of the Medway Boys IV vaccine as the code is mostly identical and even unused code was kept. Not very surprising as Megaguru is also know for his virus.

<img src="{attach}terminator_photo_0.png" width="45%"/>&nbsp;<img src="{attach}terminator_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:orange">Partial</span>     |
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
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

As a lame ripped version of the Medway Boys Protector IV, nothing to say except...

It deserved a good 0/10!

