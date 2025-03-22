Title: Fastload
Slug: fastload
Name: Fastload virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Fastload virus...
image: {filename}../../../gallery/viruses/fastload.png
Source: no
UVK: 
OtherName: |31|[Fastload](/Fastload-en.html)|Fastload-Virus|yes|||FASTLOAD.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: No symptoms

## Details

 - **Replication**: replicates on any disk where get_bpb () is called if the bootsector doesn't start with 0x6038
 - **Bootcode size**: 262 bytes.
 - **Resident address**: given by Malloc (0xcc00 on TOS 1.02).
 - **Start address**: 0x3a.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: No.
 - **TOS**: All.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("fastload", False) }}