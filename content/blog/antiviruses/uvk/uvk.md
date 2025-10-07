Title: Ultimate Virus Killer
Slug: uvk
Name: UVK
Date: 2025-10-06 12:04
Location: Montreal / Canada
Category: Atari ST, Antivirus
Lang: en
Author: shazz
status: hidden
summary: This article is about UVK...
image: {filename}../../../gallery/antiviruses/uvk.png
Tags: Antivirus


# UVK

## 2.0PRE

The first version was written by Richard Karsmakers and dates back to December 12, 1987, and was called "Virus Destruction Utility".
This version could only recognize one virus, "Signum". It was not widely distributed and was only received by a few people at an ST club meeting in Eindhoven.
All version 2 releases were public domain, versions 3 through 8.0 were commercial, and versions 8.1 and above were shareware.
This version had limited functionality and could not yet recognize safe boot sectors.

## Main Part
The most recent version of the UVK antivirus became version 9.0, written by Richard Karsmakers on April 12, 2004. This version became the final one and was no longer updated as virus writers lost interest in the Atari ST and moved to new systems. The final version is capable of recognizing 1936 boot sectors, 109 boot sector viruses, 5 link viruses, 41 antivirus programs, 190 resident applications, and 89 versions of packer/archiver formats. A total of 800 different boot sectors can be restored. So let's take a look inside this antivirus! When we open it, we are asked to set the time and date (photo 0).

Then we see system specifications such as TOS version, TOS date, GEMDOS version, AES version, and others (see picture 1). The program also notifies us if there are viruses in memory (photo 2) and if there are programs in memory protected from unauthorized reset. So we proceed to the main menu (photo 3). Here we see the program version, Richard's website, the date we selected, and functions such as:
"Seek'n' Destroy Viruses", "Restore Disks", "UVK 2000 9.0 Information", "System Status", "Quit to Desktop (U)". We will examine each function separately. Function 1 is where we can select the drive we want to check (photo 4). The second function allows us to select a drive and a boot sector that can be written to the disk (photo 5). The third function shows us information about the antivirus version, how many boot sectors can be detected, and some other information such as credits, etc. The fourth function returns us to the menu with system information. The fifth function shows program operation statistics and returns us to the desktop. Let's go back to the first function and select the drive to check. So we see that we can check the disk for 2 types of viruses: Link and Bootsector – let's examine each (photo 6)! When checking a boot sector (if it's not a virus), we see the name of the boot sector if it is recognized and what can be done with it. We can leave it untouched and keep everything as is, view it in HEX (the first 512 bytes), or we can destroy the boot sector, and then the UVK 2000 vaccine will be automatically written to it.

Afterwards, we will be offered to check another disk, restart the program, or exit to the desktop. If UVK detects a virus, we will not have the option to save it, and there will only be two buttons: view the boot sector or kill it (photo 7). When a virus is detected, UVK will emit a short beep, and if you do not want to destroy the virus, the only way to save it is to remove the infected disk at the moment of detection. When killing the virus, the UVK vaccine will also be written to the boot sector. If the boot sector is executable but UVK could not find it in its database, it will emit the same beep as when a virus is detected and display a window like this: (photo 8). It will also state the disk's VPF "Virus Probability Factor" percentage (photo 9). After this, we will be offered options on what to do with the disk next (photo 10). Now let's analyze the link virus scan (photo 11). Here we can return to the main menu, check files or folders, and also set or remove immunity on files. If UVK finds a virus in a file, it will report it but will not be able to do anything with the infected file (photo 12).

## In conclusion:
UVK is a good antivirus that recognizes more viruses than other antiviruses, but it is weak against new viruses. As was the case with some virus variants, it can make mistakes due to the slightest change in the virus code, and this is its weakness. The virus itself was updated over 17 years and was possibly the most popular on the market. For the large number of viruses it can recognize, I give this antivirus a rating of 8/10. It also contains documents with entries for all viruses, and the author released his own book dedicated to viruses (recommended reading!).