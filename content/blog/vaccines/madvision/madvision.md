Title: Mad Vision Hate Viruses
Slug: madvision
Name: Mad Vision Hate Viruses
Date: 2025-11-04 18:24
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Mad Vision Hate Viruses vaccine...
image: {filename}../../../gallery/vaccines/madvision.png
Tags: Vaccine


## Basic Information

- *Author*: Mad Vision in September 1990
- *Type*: bootsector
- *Size*: ? bytes
- *Resident*: no
- *Self-replicating*: no
- *Can clean memory*: no
- *Special features*: 
    - detects Kobold 2, Ghost and valid reset vector
    - may detect `HDV_BPB` vector set outside ROM (not working on every TOS)
    - bypasses `HDV_BPB` starting with $6072606a (bra $bca; bra $bce ???)

### Description

The Mad'Vision Hate Viruses is mostly identical to Adrenalin UK VIRUS FREE BOOTBLOCK Version 1.1 written by MOOKIE and both reuse Ghost and Kobold 2 footprints used in Adrenalin UK Virus Protector I.

Contrary to its claim in the installer, this vaccine doesn't fully work on STE as it uses SYSBASE to detect non-ROM `HDV BPB` vector.

<img src="{attach}madvision_photo_0.png" width="45%"/>&nbsp;<img src="{attach}madvision_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:orange">Partial</span> (only for Kobold 2 and Ghost)  |
| Valid reset vector              | <span style="color:green">Yes</span>  |        
| Non-ROM HDV BPB Vector          | <span style="color:orange">Partial</span> (Not working on all TOS) |
| Non-ROM HDV RW Vector           | <span style="color:red">No</span>     |
| Non-ROM HDV BOOT Vector         | <span style="color:red">No</span>     |
| Non-ROM HDV INIT Vector         | <span style="color:red">No</span>     |
| Non-ROM HDV MEDIACH Vector      | <span style="color:red">No</span>     |
| Non-ROM Trap Gemdos Vector      | <span style="color:red">No</span>     |
| Non-ROM Trap Bios Vector        | <span style="color:red">No</span>     | 
| Non-ROM Trap Xbios Vector       | <span style="color:red">No</span>     |
| Non-ROM Trap Unused Vector      | <span style="color:red">No</span>     |
| Flopwr Trap calls               | <span style="color:red">No</span>     | 
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:green">Yes</span> (Kobold 2, Ghost) |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

This vaccine is pretty is looking specifically for Ghost and Kobold 2, valid reset vectors and in some case non-ROM `HDV_BPB` vectors. But looks a litte unfinished as no cleaning routine is provided 

An average 5/10.

### Older versions of the vaccines

<img src="{attach}madvision_photo_3.png" width="45%"/>&nbsp;<img src="{attach}madvision_photo_2.png" width="45%"/>


You can download the installer from (demozoo)[https://demozoo.org/productions/95976/]