Title: Meaning2
Slug: MeaningLess2
Name: Meaning2 virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Meaning2 virus...
image: {filename}../../../gallery/viruses/MeaningLess2.png
Source: no
UVK: 
OtherName: |57|[Meaning2](/MeaningLess2-en.html)|N/A|yes|||MEANING2.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: delete existing bootsector

## Details

 - **Replication**: on A or B, based on Getbpb(dev) call, it checks if dev is A or B and if so, replace the bootsector
 - **Bootcode size**: bytes.
 - **Resident address**: .
 - **Start address**: 0x1E.
 - **Stealth address**: No.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: No.
 - **TOS**: Yes.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("MeaningLess2", False) }}