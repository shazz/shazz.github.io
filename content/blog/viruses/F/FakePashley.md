Title: Fake pashley
Slug: FakePashley
Name: Fake pashley virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Fake pashley virus...
image: {filename}../../../gallery/viruses/FakePashley.png
Source: no
UVK: 
OtherName: |30|[Fake pashley](/FakePashley-en.html)|Pashley Virus|yes|82||FAKE_PASHLEY.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: Red flash at boot with the message "VIRUS KILLED BY S.C.PASHLEY" (in the fixed version).

## Details

 - **Replication**: on every non-executable bootsectors
 - **Bootcode size**: 361 bytes.
 - **Resident address**: DISKBUF + 0x600.
 - **Start address**: 0x3A.
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
{{ emulator("FakePashley", False) }}