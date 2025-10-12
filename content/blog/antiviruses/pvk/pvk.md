Title: Professional Virus Killer
Slug: pvk
Name: PVK
Date: 2025-10-06 12:04
Location: Montreal / Canada
Category: Atari ST, Antivirus
Lang: en
Author: shazz & draedon
status: hidden
summary: This article is about PVK...
image: {filename}../../../gallery/antiviruses/pvk.png
Tags: Antivirus

## Basic Information
* Author: Mike Mee (MUG_UK)
* Program language: English
* Version 2.0b
* Creation date: 21.08.1991
* Can detect 529 boot sectors

## Virus Killer

The first antivirus program by Mike Mee, which became the prototype for all others.
It seems to have been written sometime in March 1989.

## SVK

Super Virus Killer was written by Muguk (Mike Mee) in September 1989 and was the second version, which evolved into Professional Virus Killer V2.0 on 25.03.1991. After 19.09.1991, V2.0b was released, which we will now analyze.

# PVK

So let's move on to the main analysis of version V2.0a. 
It can recognize 529 boot sectors. 
When we enter, we see an image that looks like it was taken from a comic book. 

![photo]({attach}pvk_photo_0.png)

### Next comes the memory check.

The check is passed:

![photo]({attach}pvk_photo_1.png)

There is a virus in memory:

![photo]({attach}pvk_photo_9.png)

### After that, we get to the main menu of the antivirus.

![photo]({attach}pvk_photo_2.png)

### Tabs

* _PVK_

* _Bootsector_

* _Options_

* _Info_

* _Desktop_

### What are they doing?

1. When you click the PVK button, you will see the author, phone number, and who released this program. You can also read the instructions and information about the program. 

![photo]({attach}pvk_photo_4.png)

2. Investigate Bootsector - Check the boot sector for viruses
    
    1. **Store Bootsector As File** allows you to save the boot sector to a .B_B file.
    
    2. **Display Bootsector** allows you to select the source type bootsector/.B_B File, as well as select the display format ASCII Text/Hexadecimal and the disk or file from which the boot sector will be displayed. 
    The boot sector will be displayed in a format of 25 bytes per line.
    
    3. Bios Parameter Block displays BPB statistics, for example:

![photo]({attach}pvk_photo_7.png)

    4. **Compare Bootsector** allows you to compare the boot sector/boot sector file .B_B/boot sector with each other, for example:

![photo]({attach}pvk_photo_8.png)

3. Swap Hertz Rate allows you to switch the hertz rate
    1. Default Drive allows you to select the default drive. 
    2. System Status shows the system status (Gemdos version, vectors, etc.). Example: 

![photo]({attach}pvk_photo_11.png)

    3. Internal Vars shows PVK performance statistics, i.e., how many viruses have been detected/killed, how many boot sectors have been recognized/not recognized, and everything else. (photo 10)

4. Credits Page.

![photo]({attach}pvk_photo_3.png)

    1. Hot-Keys

![photo]({attach}pvk_photo_12.png)

5. The “Desktop” tab is only used to exit the program.

### Vaccine

This antivirus has its own vaccine.

### Other versions
Versions 2.0, 2.0a, 2.0b, 2.0c, as well as the latest 2.1 version, which are very difficult to find...

## Virus Test

The “Bootsector” tab. Here you can examine the boot sector, and we will immediately check for a new virus for this program. Virus Killer emitted a long beep and displayed the disk diagnostics. 

![photo]({attach}pvk_photo_5.png)

![photo]({attach}pvk_photo_6.png)

* **ACA**

* **Macumba 3.3**

* **Merlin's Mad**

* **Non-Executable EICAR Virus**

* **Oli**

### Test results

1. **PVK** correctly identified the ACA virus.

2. **PVK** said it is an unknown executable boot sector.

3. **PVK** correctly identified the Merlin's Mad virus.

4. **PVK** said it is a non-executable boot sector but is not 100% sure it can’t do anything.

5. **PVK** said it is an unknown executable boot sector.

## In conclusion

An excellent antivirus, the golden mean. 5/10