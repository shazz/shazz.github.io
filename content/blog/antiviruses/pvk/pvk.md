Title: Professional Virus Killer
Slug: pvk
Name: PVK
Date: 2025-10-06 12:04
Location: Montreal / Canada
Category: Atari ST, Antivirus
Lang: en
Author: shazz
status: hidden
summary: This article is about PVK...
image: {filename}../../../gallery/antiviruses/pvk.png
Tags: Antivirus

## Basic Information

* Author: Mike Mee (MUG_UK)
* Program language: English
* Version 2.0a
* Creation date: 19.09.1991
* Can detect 477 bootsectors

# Virus Killer

The first antivirus by Mike Mee, which became the prototype for all others.
It appears to have been written sometime in March 1989.

## SVK

Super Virus Killer was written by Muguk (Mike Mee) in September 1989 and was the second version, which evolved into Professional Virus Killer V2.0 on 25.03.1991, and later the final V2.0a was released on 19.09.1991, which is the version we will examine.

## PVK

Now, let's move on to the main analysis of version V2.0a.
It can recognize 477 bootsectors.
Upon startup, we see an image that looks like it's taken from a comic.

![photo1]({attach}photo 0.png)

#### Next, a memory check is performed.

![photo1]({attach}photo 1.png)

#### After that, we enter the main menu of the antivirus.

![photo1]({attach}photo 2.png)

#### Pressing the PVK button, we will see
The author, phone number, and who released this program.
We can also read the program instructions and information.
The program has quite extensive functionality, and we will quickly go through each feature.
The "Desktop" tab is used only to exit the program.
The "Info" tab contains information about key combinations as well as a Credits Page.

![photo1]({attach}photo 3.png)

#### The "Options" tab
Allows viewing the system status (Gemdos version, Vectors, etc.).
The "Default Drive" button allows selecting the default drive.
The "Internal Vars" button shows PVK operation statistics, i.e., how many viruses detected/killed, bootsectors recognized/not recognized, and everything else.

![photo1]({attach}photo 4.png)

#### Now, let's move on to the most interesting part:
The "Bootsector" tab. Here you can examine the boot sector, and we will immediately check a virus new to this program.
Virus Killer emitted a prolonged beep and displayed the disk diagnostics.

![photo1]({attach}photo 5.png)

#### Now let's check a disk with one of the first viruses (MAD).
The program beeped again and displayed the following text.

![photo1]({attach}photo 6.png)

Since I don't have the full version, it's likely that we would have been prompted to repair the disk by destroying the virus.
Let's go back and explore other functions.
The "Store Bootsector As File" function, as the name implies, allows saving the boot sector to a .B_B file.
The "Display Bootsector" function allows selecting the source type (bootsector/.B_B File) and also choosing the display format (ASCII Text/Hexadecimal), as well as the drive or file from which the boot sector will be displayed.
The boot sector will be displayed in a format of 25 bytes per line.
The "Bios Parameter Block" function displays BPB statistics, for example:

![photo1]({attach}photo 7.png)

#### The "Compare Bootsector" function
Allows comparing a boot sector / .B_B boot sector file / boot sector with each other, for example:

![photo1]({attach}photo 8.png)

## In conclusion...
This virus killer, although having average functionality, cannot detect link viruses and does not cope very well with new viruses. 5/10 :(

# Version 2.1
Versions 2.0, 2.0a, 2.0b, 2.0c, and the latest 2.1 version are very difficult to find...