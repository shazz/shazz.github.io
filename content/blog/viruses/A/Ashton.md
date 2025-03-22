Title: Ashton
Slug: Ashton
Name: Ashton virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Ashton virus...
image: {filename}../../../gallery/viruses/Ashton.png
Source: no
UVK: 
OtherName: |63|[Ashton](/Ashton-en.html)|Ashton Nirvana Virus|yes|64||ASHTON.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: Mess with the floppy after 5 replications, and with the harddrive as soon as a Getbpb() calls on it is performed

## Details

 - **Replication**: on any floppy only bootsector where the virus signature ('AS' in the first OEM word) is not found
 - **Bootcode size**: 480 bytes.
 - **Resident address**: 0x140.
 - **Start address**: 0x1e.
 - **Stealth address**: 0x600.
 - **Attached vectors**: hdv_bpb, undocumented reset resident routine.
 - **Reset resistance**: yes.
 - **TOS**: all.

### What's special ?

- Technically speaking, nothing much, it uses a generation counter, the classic hdv_bpb vector and undocumented reset resident routine header. The code focuses on the symptoms which are pretty destructive, write 'ASHTON' on a random number of sectors. 
- the code uses multiple counters:
  - a generation counter (GENERATION_COUNTER, in the virus code to be persisted)
  - an in-memory counter (FLOPPY_ACCESS_COUNTER) set to 5 at start, tested to 0 to trigger the hardrive mayhem, decremented at each Getbpb(). After being triggered the coutner won't be reset until the memory is cleaned.
  - an in-memory counter (NON_VIRUS_COUNTER), cleared at each Getbpb() calls, incremented if the virus is not on disk and in case of read/write errors
    if this counter is not 0, it will also decrement the FLOPPY_ACCESS_COUNTER
;

### Fun facts

- There is a kind of backdoor, if a RTS is located at 0x180, the virus won't install
- There a message in the bootsector : "With the lights out it's less dangerous. NEVERMIND". Probably a sarcastic hint, don't power on your hard drive when this virus is around.

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Ashton", False) }}