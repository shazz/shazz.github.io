Title: What makes a good vaccine?
Slug: goodvaccine
Date: 2025-11-17 23:34
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: published
summary: Learn more bootsectors vaccines.
image: {filename}images/max_t.png
Tags: learning, viruses

## Introduction

Bootsector vaccines were important counter measures of viruses as at this time, running a full resident antivirus was technically impossible using floppy disks and at least difficult when hard drives become more common, at least using GEM Accessories. So having vaccines on bootsectors was the easiest way to prevent virus infection.
But what makes a good vaccine? Let's find out...

## Memory check at boot time

Boot order is important, these are steps from the TOS boot which are usually use by viruses:

1. Run valid reset vector
2. Run executable bootsector
3. Run valid undocumented resident programs (from `PHYSTOP` to `0x600`)
4. AUTO folder

Considering this order, many viruses use the Reset vector to set an undocumented resident program then clear the reset vector to clean their traces and especially any bootsector vaccine which would look at a valid reset vector.
 
Then the undocumented resident program will be responsible to set the various disk replications vectors (`HDV_BPB`, `HDV_BPB`, `HDV_MEDIACH`,...)

As a result, the most important check to do for a bootsector vaccine are the search of valid undocumented resident programs. 
Looking at valid reset vectors and disk vectors is not useless but in most cases, they won't be still or yet set to avoid detection.

It is probably smarter to limit the boot memory check but use any resident capability and to set the disk vectors check in a vaccine resident memory check at `0x600` (or at multiple places to avoid being overwritten by a virus) for example to be executed after any virus

## Resident capabilities

Bootsector viruses can't be activated if they we not executed at boot time (with the exception of key viruses in a special case) or if they were not already in memory. So if the bootsector vaccine did a good job at checking and clearing the memory, the risk to contaminate disks become very low. But that doesn't mean some disks were not already contaminated. 

That's why a resident vaccine can be usefull to detect those dormant viruses and propose different options:
- warning the user (usually using sound and/or screen color flashes)
- destroying the virus on the disk
- disabling the read bootsector
- ...

This is not an easy task as a comprehensive bootsector check, without any database, is tricky to implement especially within the 480 bytes of the bootsector vaccine (and in addition to the memory check capability)


## AUTO guardian program

Especially if an hard disk is connected, having a guardian program running from the AUTO folder doing some additional checks as this is the last step of the TOS boot process can really provide some good protection. Antiviruses like Ultimate Virus Checker or Effect System-Bootup