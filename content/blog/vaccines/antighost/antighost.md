Title: TDT Anti Ghost 4.0
Slug: antighost
Name: TDT Anti Ghost 4.0
Date: 2025-11-04 16:15
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the TDT Anti Ghost 4.0 vaccine...
image: {filename}../../../gallery/vaccines/antighost.png
Tags: Vaccine


## Basic Information

- *Author*: Altair
- *Type*: bootsector
- *Subtype*: ?
- *Size*: 452 bytes
- *Resident*: yes (0x140)
- *Self-replicating*: yes (on ghost virus and not exectuable bootsectors only)
- *Can clean memory*: yes, clear reset vector then memory from reset to "crash" (Except clear code)
- *Special features*: 
    - Attaches it self to `HDV_BPB` vector to replicate itself on non-executable bootsectors or detected Ghost virus.

### Description

The Anti Ghost vaccine, made by Altair famous for his Atomik Cruncher, is targetting specifically the Ghost virus that it can remove from disk as the vaccine stays in memory hooked to `HDV BPB` vector, but also at boot, will clean the memory for any reset vector set found.

<img src="{attach}antighost_photo_0.png" width="45%"/>&nbsp;<img src="{attach}antighost_photo_1.png" width="45%"/>


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
| Detect virus footprints         | <span style="color:green">Yes</span> (Ghost) |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

A vaccine which a specific target in mind with multiple checks to avoid false positive, which made some sense as the Ghost virus spreaded a lot and which also use virus-like technics to stay resident, detect dormant Ghost viruses and vaccinate them silently.

A good 6/10 as Ghost was really an annoying virus.

