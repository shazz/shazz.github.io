Title: Overkill Virenschutz
Slug: overkill
Name: Overkill Virenschutz
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Overkill Virenschutz
image: {filename}../../../gallery/vaccines/overkill.png
Tags: Vaccine


## Basic Information

- *Author*: Hilmar Herbel
- *Type*: bootsector
- *Subtype*: Memory checker
- *Size*: 388 bytes
- *Resident*: No 
- *Self-replicating*: No
- *Can clean memory*: Partial (clear `MEMVALID` and call TOS reset to force a memory resets)
- *Special features*: 
    - None

### Description

The Overkill Virenschutz vaccine is shipped with the Overkill antivirus. That's a memory checker at boot looking at valid undocument resident programs (magic word, address and checksum) and valid reset vectors. Despite the fact it is rare for a vaccine to check only for valid resident vectors and programs, it won't detect more than resident programs.

<img src="{attach}overkill_photo_0.png" width="45%"/>&nbsp;<img src="{attach}overkill_photo_1.png" width="45%"/>


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
| Flopwr Trap calls               | <span style="color:red">No</span>     | 
| Check if boot is executable     | <span style="color:red">No</span>     | 
| Rwabs Trap calls                | <span style="color:red">No</span>     | 
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

### Other versions

The Overkill 1.96B antivirus is shipped with this version of the vaccine:

<img src="{attach}overkill_photo_2.png" width="45%"/>&nbsp;<img src="{attach}overkill_photo_3.png" width="45%"/>

## Conclusion

The Overkill Virenschutz does a deep check for resident programs at boot but nothing more. 

An average 5/10.

