Title: Night Force
Slug: NightForceVirus
Name: Night Force virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Night Force virus...
image: {filename}../../../gallery/viruses/NightForceVirus.png
Source: no
UVK: 
OtherName: |89|[Night Force](/NightForceVirus-en.html)|Zoch Virus|yes|68||ZOCH.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: 

## Details

 - **Replication**: on any drive calling Getbpb(), when called, on any bootsector if the virus signature "ZOCH" is not found in OEM reserved bytes
 - **Bootcode size**: 394 bytes.
 - **Resident address**: at Disk Buffer (DISKBUFP) + 0x600.
 - **Start address**: 0x1E.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: No.
 - **TOS**: All.

### What's special ?

- The encoded message (XOR) and the fact it re-encodes the messages in RAM after decoding and display
- Using the OEM bytes to store a signature
- Symptoms (except replication) are happening only at boot time and are ususual (changing the keyboard rate and change the date)
;

### Fun facts

- Zoch is a member of thge cracking crew The Nightforce, part of the guild

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("NightForceVirus", False) }}