Title: Virus Kicker 2
Slug: viruskicker2
Name: Virus Kicker 2
Date: 2025-11-03 16:12
Location: Montreal / Canada
Category: Atari ST, Vaccine
Lang: en
Author: shazz
status: hidden
summary: This article is about yje Virus Kicker II vaccine...
image: {filename}../../../gallery/vaccines/viruskicker2.png
Tags: Vaccine


## Basic Information

- *Author*: Jedi / Sector One / The Heavy Killers
- *Type*: bootsector
- *Resident*: no
- *Self-replicating*: no
- *Can clean memory*: yes
- *Special features*: 
  - Can copy itself on other disks
  - Can set a persistent name for a disk (stored in the vaccine)
  - Can switch 50/60 Hz monitor frequency (version 2 only)

<img src="{attach}vk2_photo_0.png" width="45%"/><img src="{attach}vk2_photo_1.png" width="45%"/> 

## Detection capabilities

| Threat                          | Result version 2 | Result version 3 |
|:-------------------------------:|:----------------:|:----------------:|
| Undocumented resident program   | Yes              | Yes              |            
| Non-ROM HDV BPB Vector          | No               | Yes              |
| Non-ROM HDV RW Vector           | No               | Yes              |
| Non-ROM HDV BOOT Vector         | No               | Yes              |
| Non-ROM HDV INIT Vector         | No               | Yes              |
| Non-ROM HDV MEDIACH Vector      | No               | No               |
| Non-ROM Gemdos Vector           | No               | Yes              |
| Non-ROM Bios Vector             | No               | Yes              |
| Non-ROM Xbios Vector            | No               | Yes              |
| NDetect specific viruses        | No               | No               |
