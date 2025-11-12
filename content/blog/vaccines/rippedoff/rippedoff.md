Title: Ripped Off vaccine
Slug: rippedoff
Name: Ripped Off vaccine
Date: 2025-11-06 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the Ripped Off vaccine.
image: {filename}../../../gallery/vaccines/rippedoff.png
Tags: Vaccine


## Basic Information

- *Author*: Ripped Off team
- *Type*: bootsector
- *Subtype*: ?
- *Size*: 330 bytes
- *Resident*: no
 - *Memory resistant*: no 
- *Self-replicating*: no
- *Can clean memory*: limited, only Reset Vector and `RESVALID`
- *Special features*: 
    - Only works with TOS 1.0, 1.02, 1.04
    - (Fails to) Check if `HDV_BPB` vector is in ROM else resets it to default value (based on TOS version)
    - It deletes a zone of the memory (100 bytes at diskbuffer + $600) without a clear intent

### Description

The Ripped Off vaccine is a simple and buggy vaccine which won't catch most of the viruses. It was a good idea to look carefully at the `HDV_BPB` vector and try to reset it but it was not coded in a safe manner. And the next check on the reset vector is usually avoided by most viruses.

Here are the screenshots of the vaccine at boot, after a hard reboot and when a Reset Vector is set and valid:

<img src="{attach}rippedoff_photo_0.png" width="45%"/>&nbsp;<img src="{attach}rippedoff_photo_1.png" width="45%"/>


## Detection capabilities

| Threat                          | Result                                |
|---------------------------------|:-------------------------------------:|
| Check PHYSTOP memory            | <span style="color:red">No</span>     |
| Undocumented resident program   | <span style="color:red">No</span>     |
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

...

A pretty lame 1/10

