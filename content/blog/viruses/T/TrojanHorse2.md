Title: Trojan Horse 2
Slug: TrojanHorse2
Name: Trojan Horse 2 virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Trojan Horse 2 virus...
image: {filename}../../../gallery/viruses/TrojanHorse2.png
Source: no
UVK: 
OtherName: |83|[Trojan Horse 2](/TrojanHorse2-en.html)|N/A|yes|||TROJAN_HORSE2.S|
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
{{ emulator("TrojanHorse2", False) }}