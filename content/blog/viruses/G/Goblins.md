Title: Goblins
Slug: goblins
Name: Goblins virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Goblins virus...
image: {filename}../../../gallery/viruses/goblins.png
Source: no
UVK: 
OtherName: |37|[Goblins](/Goblins-en.html)|Goblin Virus|yes|19||GOBLINS.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 3 copies it will Y-reverse the GEM menu, after 115 copies it will display the message "The Green Goblins Strike Again" and crashes.

## Details

 - **Replication**: on A or B, based on Getbpb(dev) call, it checks if dev is C and do nothing in this case.
 - **Bootcode size**: 474 bytes.
 - **Resident address**: PHYSTOP-0x200 to PHYSTOP (0xFFFE0 on 1MB ST). Counter at 0xFFF80..
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
{{ emulator("goblins", False) }}