Title: Trojan Horse 1
Slug: trojanhorse1
Name: Trojan Horse 1 virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Trojan Horse 1 virus...
image: {filename}../../../gallery/viruses/trojanhorse1.png
Source: no
UVK: 
OtherName: |82|[Trojan Horse 1](/trojanhorse1-en.html)|N/A|yes|||TROJAN_HORSE1.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: show message and replicates unless the payload is decoded by the TROJAN virus and then executed

## Details

 - **Replication**: on A or B only, when Getbpb() is called on non executable floppies
 - **Bootcode size**: 188 bytes + 288 bytes available for payload  + 4 bytes signature.
 - **Resident address**: PHYSTOP - 0x200.
 - **Start address**: Bootcode start unknown.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: No
;.
 - **TOS**: TOS compatibility unknown.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("trojanhorse1", False) }}