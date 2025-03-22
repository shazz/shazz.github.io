Title: Freeze
Slug: Freeze
Name: Freeze virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Freeze virus...
image: {filename}../../../gallery/viruses/Freeze.png
Source: no
UVK: 
OtherName: |33|[Freeze](/Freeze-en.html)|Freeze Virus|yes|5||FREEZE.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: as soon as run, will slow down the system by incrementing a delay loop each 200Hz (Timer A)

## Details

 - **Replication**: on A or B, boot device only, when the FAT sector (11) is read, on non executable disks (first byte = BRA)
 - **Bootcode size**: 338 bytes.
 - **Resident address**: PHYSTOP-0x300 to PHYSTOP-0x100 (0xFFD00 on 1MB ST).
 - **Start address**: 0x20.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_rw and timer A.
 - **Reset resistance**: No.
 - **TOS**: I guess all versions..

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Freeze", False) }}