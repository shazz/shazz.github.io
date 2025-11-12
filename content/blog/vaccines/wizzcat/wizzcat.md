Title: WizzCat VProtector
Slug: wizzcat
Name: WizzCat VProtector
Date: 2025-11-06 09:05
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about the WizzCat VProtector
image: {filename}../../../gallery/vaccines/wizzcat.png
Tags: Vaccine


## Basic Information

- *Author*: Wizzcat from Delta Force, 1990-10-31
- *Type*: bootsector
- *Subtype*: ?
- *Size*: 370 bytes
- *Resident*: no
 - *Memory resistant*: no 
- *Self-replicating*: no
- *Can clean memory*: Partial, clear `MEMVALID` and `RESVALID` and call the TOS reset vector to force a nearly full reset
- *Special features*: 
    - A 4MB fix but not clear what if does, hardto tell without the original version.

### Description

The WizzCat VProtector doesn't do much except checking the Reset Vector validity so it won't catch most if any virus.
It is supposed to show a color gradient when a reset vector is found but not working.

Here are the screenshots of the vaccine at boot, after a hard reboot and when a reset vector `RESVALID` magic word is set.

<img src="{attach}wizzcat_photo_0.png" width="45%"/>&nbsp;<img src="{attach}wizzcat_photo_2.png" width="45%"/>

The 4MB fix code:

```asm
   cmpi.l      #$400000, PHYSTOP.w
    blt.s       L36
    move.l      #$300000, $PHYSTOP.w
    movea.l     $4.w, a0                        
    jmp         (a0)                            ; jump to reset vector
```

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
| Detect virus footprints         | <span style="color:red">No</span>     |
| Catch key viruses               | <span style="color:red">No</span>     |
| Other threat detection          | <span style="color:red">No</span>     |

## Conclusion

Wizzcat / Delta Force did some better stuff for the ST.

A little 1/10 because it is Delta Force.

You can download the installer on [demozoo](https://demozoo.org/productions/95866/)