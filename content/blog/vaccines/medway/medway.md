Title: Medway Boys Protector IV
Slug: medway
Name: Medway Boys Protector IV
Date: 2025-11-03 16:12
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Medway Boys Protector IV vaccine...
image: {filename}../../../gallery/vaccines/medway.png
Tags: Vaccine


## Basic Information

- *Author*: Trojan and Wurzel from the Medway Boys
- *Type*: bootsector
- *Subtype*: Memory checker
- *Size*: 480 bytes
- *Resident*: no
 - *Memory resistant*: no
- *Self-replicating*: no
- *Can clean memory*: partial (resets `RESVALID`, `RESVECTOR`) then calls TOS reset vector
- *Special features*: 
    - Deactivate Ghost loader

### Description

The Medway Boys Protector IV was probably one of the most used vaccine on ST, Trojan and Wurzel relased multiple versions of this vaccine and the last one, version IV, was modified by the BBC.


<img src="{attach}medway_photo_3.png" width="45%"/>&nbsp;<img src="{attach}medway_photo_4.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:green">Yes</span>|
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
| Other threat detection          | <span style="color:green">Yes</span> (disables Ghost loader)  |

## Conclusion

This vaccine doesn't do much after all, focusing on resident programs and the reset vector.

A disppointing 4/10.

### Older versions

<img src="{attach}medway_photo_0.png" width="19%"/>&nbsp;<img src="{attach}medway_photo_1.png" width="19%"/>&nbsp;<img src="{attach}medway_photo_5.png" width="19%"/>&nbsp;<img src="{attach}medway_photo_7.png" width="19%"/>&nbsp;<img src="{attach}medway_photo_8.png" width="19%"/>


###  Appendix

The installer is downloadable here: [demozoo](https://demozoo.org/productions/81668/)