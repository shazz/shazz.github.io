Title: Toxis
Slug: toxis
Name: Toxis
Date: 2025-10-29 18:06
Location: Russia
Category: Atari ST, Antivirus
Lang: en
Author: draedon
status: hidden
summary: This article is about Toxis...
image: {filename}../../../gallery/antiviruses/toxis.png
Tags: Antivirus

## Basic Information

* ToXis is a successor of Sagrotan
* *Author*: Henrik Alt
* *Program language*: German
* *Version 5.50* creation date: 25/05/1993
* *Version*: 5.50
* *Can detect*: 16 viruses, 92 regular boot sectors, 108 total

### Recognized Viruses:

* **Boot Viruses**: AIDS, Ghost, C'T, OLI, Maulwurf I, Kobold #2, Fastload, Signum BPL, BHP, Fun, Swiss, Screen, VDU, Bomb, PD 141, Angle of Death
* **File Viruses**: None
* **Others**: N/A

![photo]({attach}toxis_photo_0.png)

## Tasks

### Task 1: Recognize boot viruses not loaded into memory

#### Instructions:

To test a floppy disk with Toxis, follow these steps:

* Insert the test floppy into drive A:
* Select the `EINSTELLUNG` menu
* Select the menu action `Laufwerksauswahl` 
* Select the menu action `Physikalisches Laufwerk A:` to select drive A:
* Select the `VIRUS` menu
* Select the menu action `prüfen` to test the boot sector
* Click Ok to confirm the action

![photo]({attach}toxis_photo_1.png)

* Then the boot sector details and the analysis result will appear

| Virus<p>Difficulty                                                            | Analysis                                          | Result                                                                                        |
|:-----------------------------------------------------------------------------:|:-------------------------------------------------:|:---------------------------------------------------------------------------------------------:|
| [Ghost](https://retrovirology.metaverse.fr/ghost-en.html)<br>(1/5)            | ![photo]({attach}toxis_photo_3.png)               | We see that Toxis successfully identified the Ghost virus                                     |
| [Signum BPL](https://retrovirology.metaverse.fr/signum-en.html)<br>(1/5)      | ![photo]({attach}toxis_photo_4.png)               | We see that Toxis successfully identified the Signum virus                                    |
| [Macumba 3.3](https://retrovirology.metaverse.fr/macumba3-en.html)<br>(4/5)   | ![photo]({attach}toxis_photo_5.png)               | Toxis reported that it found no signs of a virus in the disk's boot sector                    |
| [Carpe Diem](https://retrovirology.metaverse.fr/carpediem-en.html)<br>(2/5)   | ![photo]({attach}toxis_photo_6.png)               | We see that Toxis detected 9 signs of a viral infection                                       |
| [OLI](https://retrovirology.metaverse.fr/oli-en.html)<br>(1/5)                | ![photo]({attach}toxis_photo_7.png)               | We see that Toxis successfully identified the OLI virus                                       |
| [OLI2](https://retrovirology.metaverse.fr/oli2-en.html)<br>(1/5)              | ![photo]({attach}toxis_photo_8.png)               | We see that Toxis detected 7 signs of viral infection in OLI2                                 |
| [EICAR](https://retrovirology.metaverse.fr/eicar-en.html)<br>(3/5)            | ![photo]({attach}toxis_photo_9.png)               | Toxis reported that during initialization the boot sector starts as a reset-resistant program |

### Task 2: Recognize boot viruses loaded into memory

#### Instructions

* Boot from the infected floppy disk in drive A:
* Change the disk to the Toxis disk
* Run Toxis
* Check if Toxis's warning appears that a virus was found in memory
* If the virus was not fully detected, follow the same instructions as in Task 1

#### One of the most common viruses: Ghost

Test results:

* Hdv_bpb vector infected
* Reset vector infected

Toxis recognized the Ghost virus in the boot sector.

#### Key virus and its key disk: Signum BPL

Test results:

* Hdv_bpb vector infected

Toxis recognized the Signum BPL virus in the boot sector.

#### Polymorphic virus: Macumba 3.3

Test results:

* No exception vectors outside the allowed memory area.

Toxis did not recognize the virus in memory. Toxis said it found no signs of a viral infection in the boot sector.

#### Trojan virus: Carpe Diem

Test results:

* Hdv-bpb vector is below allowed user memory
* Reset vector is below allowed user memory

Toxis Recognized 9 signs of a viral infection in the boot sector.

#### Stealth virus: OLI

Test results:

* Hdv-init vector is below allowed user memory
* Hdv-rw vector is below allowed user memory
* Trap #14 (XBIOS) vector is below allowed user memory
* Reset vector is below allowed user memory

Toxis recognized the OLI virus in the boot sector

#### Super Stealth virus: OLI2

Test results:

* Hdv-init vector is below allowed user memory
* Hdv-rw vector is below allowed user memory
* Trap #14 (XBIOS) vector is below allowed user memory
* Reset vector is below allowed user memory

Toxis recognized OLI2 in the boot sector while it was in memory

#### Non-executable boot sector: EICAR

Test results:

Toxis reported that there is nothing in memory. This is correct.
Toxis detected that the boot sector will still start. This is correct.

### Task 3: Recognize a file virus

#### Instructions

##### Option 1

* Insert the test floppy into drive A:
* Select the `EINSTELLUNG` menu
* Select the menu action `Laufwerksauswahl` 
* Select the menu action `Physikalisches Laufwerk A:` to select drive A:
* Select the `VIRUS` menu
* Select the menu action `Datein prüfen` (Check files) to test files for Link Viruses
* Click Ok to confirm the action

##### Option 2

* Select the `EINSTELLUNG` menu
* Select the menu action `Dateinprüfun` to configure file testing for Link Viruses
* Select the file types you want to check
* Click Start to confirm the action
* Select the drive to test
* Select the file you want to check
* Click Ok to confirm the action

![photo]({attach}toxis_photo_10.png)

#### First file virus: Milzbrand

Toxis reported that the file was modified by a virus!

![photo]({attach}toxis_photo_11.png)

### Task 4: Restore a damaged boot sector

#### Instructions

* Insert the test floppy into drive A:
* Select the `EINSTELLUNG` menu
* Select the menu action `Laufwerksauswahl` 
* Select the menu action `Physikalisches Laufwerk A:` to select drive A:
* Select the `BIBLIOTHEK` (LIBRARY) menu
* Select the menu action `speichern`
* Click Ok to confirm the action
* Press any letter and then press ENTER
* Save the boot sector to the Toxis library and click OK

Let's check! Let's replace the boot sector with the Toxis vaccine and try to restore the floppy disk's boot sector. To restore the floppy disk:

* Select the `VIRUS` menu
* Select the menu action `reparieren`
* Click Ok to confirm the action
* Scroll down and select our recently saved boot sector which is now at the very bottom of the list
* Press `Bootsektor schreiben`
* Boot sector restored!

### Task 5: Vaccinate a non-executable floppy disk

#### Instructions

* Select the `VIRUS` menu
* Select the menu action `schutzen` (write vaccine to boot sector)
* Click Ok to confirm the action

Now upon boot we will see the message "Kein Virus im Bootsektor". Let's try to run the Ghost virus and see what happens!

* Load the virus into memory
* Change the disk to the one vaccinated by Toxis
* Boot from it

We will see the message "Kein Virus im Bootsektor" :( ... Toxis could not defeat the virus and the virus will overwrite your boot sector! Well, basically the same as with Sagrotan.

![photo]({attach}toxis_photo_2.png)

### Task 6: Analyze a suspicious boot sector

#### Instructions

* Insert the test floppy into drive A:
* Select the `EINSTELLUNG` menu
* Select the menu action `Laufwerksauswahl` 
* Select the menu action `Physikalisches Laufwerk A:` to select drive A:
* Select the `VIRUS` menu
* Select the menu action `prüfen` to test the boot sector
* Click Ok to confirm the action

When scanning the boot sector, Toxis performs heuristic analysis and looks at the disk's condition.
It checks:

* It checks the BPB
* Checksum
* Signs of viral infection
* Infected vectors
* Toxis check for the Magic long word ($12123456)

After loading, Toxis will report if vectors have been changed and if so, will suggest performing a cold reboot. Toxis analyzes the boot sector code and outputs information about it:

* Whether the BPB is damaged
* How many signs of viral infection were detected
* Whether the checksum equals $1234

If Toxis detects a familiar virus in the boot sector, it will report it and display the percentage match with the virus from the Toxis database.

### Task 7: Detect malware when Toxis is not running

#### Instructions

When you boot from the disk, the Toxis disk must be in Drive A. If these conditions are met, the automatic scanner from the Toxis.ACC file will run. This scanner will scan the disk always residently staying in memory. Toxis Acc automatically deletes the bootsector if a virus is found.

After that, you will literally always have an open Toxis that you can open right from the desktop with all functions! For this:

- Hover over the Desk menu on the desktop
- Click on toXis
- toXis will open for you!

## Summary and Conclusion

In the following table we have summarized the task completion results:

| Task | Result |
| :---------------------------------------------------------------- | :------: |
| Recognize boot viruses not loaded into memory                     |   6/7    |
| Recognize boot viruses loaded into memory                         |   6/7    |
| Recognize a file virus                                            |   1/1    |
| Restore a damaged boot sector                                     |   1/1    |
| Vaccinate a non-executable floppy disk                            |   0/1    |
| Analyze a suspicious boot sector                                  |   5/5    |
| Detect malware when Toxis is not running                          |   2/2    |
| **Total**                                                         |  21/24   |

In conclusion, Toxis has many critical bugs! When running the memory-resident scanner, its library can break and stop detecting known viruses. It doesn't scan memory due to certain bugs... But now new functions have appeared, which also have bugs! The disassembler and vector modification protection are functions that Toxis doesn't scan... We h