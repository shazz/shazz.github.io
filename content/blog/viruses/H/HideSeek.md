Title: Hide Seek
Slug: hideseek
Name: Hide Seek virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Hide Seek virus...
image: {filename}../../../gallery/viruses/hideseek.png
Source: no
UVK: 
OtherName: |42|[Hide Seek](/HideSeek-en.html)|Angle of Death|yes|||HIDE_SEEK.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: Switch background color after 3 new replications, if the virus did not reach 4 generations else it deactivates itself

## Details

 - **Replication**: On any call to get_bpb if the current bootsector is not executable or doesn't contain the virus branch or contains Sagrotan
 - **Bootcode size**: 440 bytes.
 - **Resident address**: Diskbuf + 0x600.
 - **Start address**: 0x1e.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: no.
 - **TOS**: All.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("hideseek", False) }}