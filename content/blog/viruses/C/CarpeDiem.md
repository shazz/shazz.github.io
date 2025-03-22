Title: Carpe Diem
Slug: carpediem
Name: Carpe Diem virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Carpe Diem virus...
image: {filename}../../../gallery/viruses/carpediem.png
Source: no
UVK: 
OtherName: |16|[Carpe Diem](/CarpeDiem-en.html)|Carpe Diem Virus|yes|95||CARPEDIEM.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: N/A

## Details

 - **Replication**: on any floppy when GetBpb() is called
 - **Bootcode size**: 482 bytes.
 - **Resident address**: 0x1c4 + random 30 even bytes range from Timer C.
 - **Start address**: 0x1c.
 - **Stealth address**: 0x50000.
 - **Attached vectors**: hdv_bpb, vbl_list, resvec, undocumented reset resident.
 - **Reset resistance**: Yes.
 - **TOS**: 4.0x in the non fixed version.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("carpediem", False) }}