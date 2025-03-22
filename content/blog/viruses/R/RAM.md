Title: RAM
Slug: RAM
Name: RAM virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the RAM virus...
image: {filename}../../../gallery/viruses/RAM.png
Source: no
UVK: 
OtherName: |28|[RAM](/RAM-en.html)|Exception virus|yes|23||EXEP_VIR.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: 

## Details

 - **Replication**: After 65536 VBLs (around 22 minutes at 50Hz) following the first replication, the virus will write random values at random memory location every 50 VBLs (1s at 50Hz) which will eventually cause a crash and reboot
 - **Bootcode size**: 320 bytes.
 - **Resident address**: 0x600.
 - **Start address**: 0x1E / 0x26.
 - **Stealth address**: 0x600.
 - **Attached vectors**: vbl_list, hdv_rw.
 - **Reset resistance**: No.
 - **TOS**: 1.0 and 1.02 only as it harcodes DISKBUFP addresses..

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("RAM", False) }}