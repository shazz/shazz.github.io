Title: Avenger
Slug: avenger
Name: Avenger virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Avenger virus...
image: {filename}../../../gallery/viruses/avenger.png
Source: no
UVK: 
OtherName: |5|[Avenger](/Avenger-en.html)|N/A|yes|||AVENGER.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 5 copies it generate a constant high frequency sound and flashes the screen background color, no lock up.

## Details

 - **Replication**: on A or B, based on Getbpb(dev) call, it checks if dev is lower or equals to 1;
             only the bootsector long at 0x30 is 0x047221D3 (virus code at 0x14)
 - **Bootcode size**: 474 bytes.
 - **Resident address**: 0z150 (bootcode, variables starting at $144).
 - **Start address**: 0x1C.
 - **Stealth address**: No.
 - **Attached vectors**: hdv_bpb, vbl_vector.
 - **Reset resistance**: No.
 - **TOS**: all.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("avenger", False) }}