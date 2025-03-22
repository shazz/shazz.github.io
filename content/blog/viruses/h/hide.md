Title: Hide
Slug: hide
Name: Hide virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Hide virus...
image: {filename}../../../gallery/viruses/hide.png
Source: no
UVK: 
OtherName: |41|[Hide](/hide-en.html)|Flash and Sound|yes|||HIDE.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 5 copies it will starts to flash rapidly the backgound color, makes random music and slow down more and more the computer.

## Details

 - **Replication**: on A or B, based on Getbpb(dev) call, it checks if dev is lower or equals to 1
 - **Bootcode size**: 474 bytes.
 - **Resident address**: PHYSTOP-0x200 to PHYSTOP (0xFFFE0 on 1MB ST).. Counter at 0xFFF80.
 - **Start address**: 0x1E.
 - **Stealth address**: PHYSTOP-0x8200 = 0xF7E00 on 1MB ST.
 - **Attached vectors**: hdv_bpb, resvector.
 - **Reset resistance**: Yes.
 - **TOS**: Needs TOS meminit to be located at 0xFC0074.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("hide", False) }}