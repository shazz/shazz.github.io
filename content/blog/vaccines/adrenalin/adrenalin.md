Title: Andrenalin Virus Protector I
Slug: adrenalin
Name: Andrenalin Virus Protector I
Date: 2025-11-03 16:12
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Adrenalin Andrenalin Virus Protector I vaccine...
image: {filename}../../../gallery/vaccines/adrenalin.png
Tags: Vaccine


## Basic Information

- *Author*: Adrenalin UK
- *Type*: bootsector
- *Size*: 441 bytes
- *Resident*: no
- *Self-replicating*: no
- *Can clean memory*: partial (MEMVALID, RESVALID, RESVECTOR, MEMVAL2) forcing a TOS incomplete memory clean
- *Special features*: 
    - Detects specifically Kobold 2, Ghost viruses and Automation V1 vaccine.

### Description

The Adrenalin Andrenalin Virus Protector I really looks the famous Medway Boys Virus protector. 
It detects Kobold 2, Ghost and Automation V1 (virus?) looking at the position of the undocumented resident program magic word based on the virus reset vector start address


<img src="{attach}adrenalin_photo_0.png" width="45%"/><img src="{attach}adrenalin_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result version 1.8a                   |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:orange">Partial</span>|
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
| VBL Int / VBL Routine Vector    | <span style="color:red">No</span>     |
| Non-ROM Trap Unused Vector      | <span style="color:red">No</span>     |
| Detect virus footprints         | <span style="color:green">Yes</span> (Kobold 2, Ghost, Automation V1) |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

##  Appendix

The installer is downloadable here: [demozoo](https://demozoo.org/productions/132449/)