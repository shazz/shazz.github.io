Title: Ultimate Virus Checker
Slug: uvc
Name: Ultimate Virus Checker
Date: 2025-11-22 18:10
Location: Russia
Category: Atari ST, Antivirus
Lang: en
Author: draedon
status: hidden
summary: This article is about Ultimate Virus Checker...
image: {filename}../../../gallery/antiviruses/uvc.png
Tags: Antivirus

## Basic Information
* *Version*: 1.10+
* *Author*: The Master (Kent)
* *Language*: English
* *Recognizes*: 23 bootsectors

![photo]({attach}uvc_photo_0.png)

### Recognized Viruses:

* **Boot Viruses**: Signum, Ghost, THE BAD GHOST, kobold #2, MASTER VIRUS, KENT VIRUS
* **File Viruses**: None
* **Others**: 8 others bootsectors

## Tasks

### Task 1: Recognize boot viruses not loaded into memory

#### Instructions:

To test a floppy disk with UVC, follow these steps:

* Insert the test floppy into drive A:
* Press F1

![photo]({attach}uvc_photo_1.png)

* Then the boot sector details and the analysis result will appear

| Virus<p>Difficulty                      | Analysis                                           | Result                                         |
|:---------------------------------------:|:--------------------------------------------------:|:----------------------------------------------:|
| [Ghost](/ghost-en.html)<p>(1/5)         | <img src="{attach}uvc_photo_2.png" width="100%"/>  | UVC correctly recognized the Ghost virus       |
| [Signum BPL](/signum-en.html)<p>(1/5)   | <img src="{attach}uvc_photo_3.png" width="100%"/>  | UVC correctly recognized the Signum BPL virus  |
| [Macumba 3.3](/macumba3-en.html)<p>(4/5)| <img src="{attach}uvc_photo_4.png" width="100%"/>  | UVC said this is an unknown boot sector.       |
| [Carpe Diem](/carpediem-en.html)<p>(2/5)| <img src="{attach}uvc_photo_5.png" width="100%"/>  | UVC said this is an unknown boot sector.       |
| [OLI](/oli-en.html)<p>(1/5)             | <img src="{attach}uvc_photo_6.png" width="100%"/>  | UVC said this is an unknown boot sector.       |
| [OLI2](/oli2-en.html)<p>(1/5)           | <img src="{attach}uvc_photo_7.png" width="100%"/>  | UVC said this is an unknown boot sector.       |
| [EICAR](/eicar-en.html)<p>(3/5)         | <img src="{attach}uvc_photo_8.png" width="100%"/>  | UVC said this is a safe disk.                  |

### Task 2: Recognize boot viruses loaded into memory

#### Instructions

* Boot from the infected floppy disk in drive A:
* Change the disk to the UVC disk
* Enter UVC
* Press F7

#### One of the most common viruses: Ghost

Test results:

* Hdv_bpb vector infected
* Reset vector infected

UVC correctly recognized the Ghost virus

#### Key virus and its key disk: Signum BPL

Test results:

* Hdv_bpb vector infected

UVC correctly recognized the Ghost virus

#### Polymorphic virus: Macumba 3.3

Test results:

* No exception vectors outside the allowed memory area.

UVC said this is an unknown boot sector.

#### Trojan virus: Carpe Diem

Test results:

* Hdv-bpb vector is below allowed user memory
* Reset vector is below allowed user memory

UVC said this is an unknown boot sector.

#### Stealth virus: OLI

Test results:

* Hdv-init vector is below allowed user memory
* Hdv-rw vector is below allowed user memory
* Trap #14 (XBIOS) vector is below allowed user memory
* Reset vector is below allowed user memory

UVC said this is an unknown boot sector.

#### Super Stealth virus: OLI2

Test results:

* Hdv-init vector is below allowed user memory
* Hdv-rw vector is below allowed user memory
* Trap #14 (XBIOS) vector is below allowed user memory
* Reset vector is below allowed user memory

UVC said this is an unknown boot sector.

#### Non-executable boot sector: EICAR

Test results:

UVC reported that there is nothing in memory. This is correct.
UVC said this is a safe disk. This is not true.

### Task 3: Recognize a file virus

UVC cannot scan files for viruses

### Task 4: Restore a damaged boot sector

UVC can save the boot sector to a file but cannot restore it.

### Task 5: Vaccinate a non-executable floppy disk

#### Instructions

* Insert the test floppy into drive A:
* Press F2

Now when booting from this disk you will see this:

![photo]({attach}uvc_photo_9.png)

![photo]({attach}uvc_photo_10.png)

It seems like the vaccine helped and warned about a virus in memory.

### Task 6: Analyze a suspicious boot sector

#### Instructions

* Insert the test floppy into drive A:
* Click on the floppy disk image labeled Drive A below

UVC checks:

* Vectors
* Checksum (actually it detects viruses by it!)
* UVC does not check disk BPB
* UVC does not check Magic Long Word ($12123456)
* UVC does not perform heuristic disk analysis

### Task 7: Detect malware when UVC is not running

UVC has a resident virus scanner and if a virus gets into your boot sector, this scanner... Will crash your ST! This resident scanner is installed from the Antivirus:

* Press F4
* Place the Guardian.PRG file in the AUTO folder
* Press OK

## Summary and Conclusion

In the following table we have summarized the task completion results:

| Task | Result |
| :---------------------------------------------------------------- | :------: |
| Recognize boot viruses not loaded into memory                     |   2/7    |
| Recognize boot viruses loaded into memory                         |   2/7    |
| Recognize a file virus                                            |   0/1    |
| Restore a damaged boot sector                                     |   0/1    |
| Vaccinate a non-executable floppy disk                            |   1/1    |
| Analyze a suspicious boot sector                                  |   2/5    |
| Detect malware when UVC is not running                            |   2/2    |
| **Total**                                                         |   9/24   |

In conclusion, UVC is a very interesting antivirus that detects viruses rather poorly since it checks the checksum which is quite ineffective. What's interesting is that the author apparently wrote 2 viruses - Master virus and Kent Virus - and added their detection to his antivirus and apparently distributed these two viruses! 

It's also interesting that it has a resident scanner that simply... Will blow the fuses in the electrical panel if it detects a virus :D! And still, 9/24 is 1 point more than the quite cool antivirus Boot Protector II. 

Actually, the antivirus is made for enthusiasts since only it recognizes the Kent Virus which unfortunately we don't have yet. I also encountered a strange bug where I couldn't open the disk when the virus was in memory. Interesting fact: you can save the boot sector to the library as soon as you enter UVC. Apparently, it checks the boot sector as soon as you enter it.

![photo]({attach}uvc_photo_11.png)

![photo]({attach}uvc_photo_12.png)