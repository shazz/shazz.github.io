Title: Dr Satan Memory Protector
Slug: drsatan
Name: Dr Satan Memory Protector
Date: 2025-11-05 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Dr Satan Memory Protector
image: {filename}../../../gallery/vaccines/drsatan.png
Tags: Vaccine


## Basic Information

- *Author*: Dr Satan from the Fallen Angels (Empire)
- *Type*: bootsector
- *Subtype*: Memory checker
- *Size*: 388 bytes
- *Resident*: no 
- *Self-replicating*: no
- *Can clean memory*: no
- *Special features*: 
    - vaccine is XOR encoded

### Description

The Dr Satan vaccine only checks if the `HDV_BPB` vector is located in the TOS 1.0/1.02/1.04 address space (`0x00fc0000`) and if this is the case it will stop the boot and show some red rasters.
As this is an early vaccine, Dr Satan did not know the next versions of the TOS will use different address spaces. So this vaccine will be pretty unefficient to detect all viruses but good enough for the early virus generation.
In case it doesn't detect anything, some nice moving rasters will be shown. 

It was originally shipped with the Copy-Disk 2.0 and the first Fallen Angels' utility disk, both coded by Sr Satan himself and released in early 1989.

<img src="{attach}drsatan_photo_0.png" width="45%"/>&nbsp;<img src="{attach}drsatan_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:red">No</span>     |
| Valid reset vector              | <span style="color:red">No</span>     |        
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

As an early bootsector vaccine, it deserves some respect, so good for the museum but not to be used.

An historical 3/10.

