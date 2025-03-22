Title: Barbichette
Slug: Barbichette
Name: Barbichette virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Barbichette virus...
image: {filename}../../../gallery/viruses/Barbichette.png
Source: no
UVK: 
OtherName: |12|[Barbichette](/Barbichette-en.html)|No Virus virus|yes|||NOVIRUS.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: 

## Details

 - **Replication**: on A or B, based on Getbpb(dev) call, it checks if dev is lower or equals to 1,
             if any byte of the bootcode doesn't match the virus.
             A counter is incremented and reset at 5 but doesn't change anything.
 - **Bootcode size**: 484 bytes (probably less as some code / data is never reached).
 - **Resident address**: 0x200.
 - **Start address**: 0x1C.
 - **Stealth address**: no.
 - **Attached vectors**: hdv_bpb, illegal.
 - **Reset resistance**: No.
 - **TOS**: all.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Barbichette", False) }}