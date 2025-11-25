Title: %TITLE%
Slug: horror
Name: %NAME%
Date: %DATE%
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: %SUMMARY%
image: {filename}../../../gallery/viruses/horror.png
Source: no
UVK: %UVK%
OtherName: %OTHER_NAMES%
Tags: bootsector virus

## In a few words...

This virus %DESC%.

The following symptoms may happen: %SYMPTOMS%

## Details

 - **Replication**: %REPLICATION%
 - **Bootcode size**: %SIZE%.
 - **Resident address**: %RESIDENT_ADDRESS%.
 - **Start address**: %START_ADDRESS%.
 - **Stealth address**: %STEALTH_LOCATION%.
 - **Attached vectors**: %VECTORS%.
 - **Reset resistance**: %RESISTANCE%.
 - **TOS**: %TOS%.

### What's special ?

%WHATS_SPECIAL%

### Fun facts

%FUN_FACTS%

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("%SLUG%", False) }}