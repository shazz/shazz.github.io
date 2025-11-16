Title: K.E.D. Protector 1.5
Slug: ked
Name: K.E.D. Protector 1.5
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the K.E.D. Protector 1.5 vaccine
image: {filename}../../../gallery/vaccines/ked.png
Tags: Vaccine


## Basic Information

- *Author*: Unknown
- *Type*: bootsector
- *Subtype*: Resident guardian
- *Size*: 424 bytes
- *Resident*: yes
- *Self-replicating*: yes
- *Can clean memory*: partial
- *Special features*: 
    - can upgrade itself if the version increased

### Description

The K.E.D. Protector acts as a friendly virus, it installs itself in memory, is reset resistant and attaches to the `HDV_BPB` vector. Then, if it reads a floppy with the Ghost virus or a non executable bootsector, it will replace it by itself while inverting the backcolor (for ghost) or flashing (for non executable bootsector) for a few seconds.

At boot if it needs to clean the memory, it will patch PHYSTOP to avoid any hidden sections.
If Ghost is already in memory, it will crash and be replaced by the vaccine.

<center>
<img src="{attach}ked_photo_0.png" width="30%"/>&nbsp;<img src="{attach}ked_photo_1.png" width="30%"/>&nbsp;<img src="{attach}ked_photo_2.png" width="30%"/>
</center>

## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:green">Yes</span>     |
| Undocumented resident program   | <span style="color:red">No</span>     |
| Valid reset vector              | <span style="color:red">No</span>     |        
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
| Detect virus footprints         | <span style="color:red">Yes</span> (Ghost) |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

K.E.D is one of the rare vaccine which really acts as a counter-virus, it has all the features of a virus except it has no destructive capabilities (to some extent, it could replaces a non-executable bootsector which has some information.. or is even possible executable or deactivated) but as it only target the Ghost virus, that's rather limited, it could do so much more.

An interesting 6/10

