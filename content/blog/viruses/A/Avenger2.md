Title: Avenger 2
Slug: Avenger2
Name: Avenger 2 virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Avenger 2 virus...
image: {filename}../../../gallery/viruses/Avenger2.png
Source: no
UVK: 
OtherName: |6|[Avenger 2](/Avenger2-en.html)|N/A|yes|||AVENGER2.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 5 copies it will delete the FAT (21 sectors)

## Details

 - **Replication**: on A or B, based on Getbpb(dev) call, it checks if dev is lower or equals to 1;
             only if any byte of the 32 bytes from the bootsector, starting at 0x020 is different 
             compared to the virus in memory
 - **Bootcode size**: 482 bytes.
 - **Resident address**: 0x160 (bootcode, variables starting at $152).
 - **Start address**: 0x1C.
 - **Stealth address**: First double page available location starting at PHYSTOP-0x8000-0x200 where no resident program is set.
 - **Attached vectors**: hdv_bpb, resvector.
 - **Reset resistance**: Yes (resvec and undocumented resident program).
 - **TOS**: all.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Avenger2", False) }}