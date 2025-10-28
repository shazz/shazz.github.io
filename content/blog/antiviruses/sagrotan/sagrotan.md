Title: Sagrotan
Slug: sagrotan
Name: Sagrotan
Date: 2025-10-06 12:04
Location: Montreal / Canada
Category: Atari ST, Antivirus
Lang: en
Author: shazz & draedon
status: hidden
summary: This article is about Sagrotan...
image: {filename}../../../gallery/antiviruses/sagrotan.png
Tags: Antivirus


## Basic Information

* **Latest version**: 4.17 released 13.05.1990
* **Author**: Henrik Alt
* **Language**: German, some versions translated into English and French
* **Can detect**: 15 viruses, 91 standard boot sectors, 106 total. X file viruses
* **Other known versions**: 4.03, 4.06, 4.10, 4.12, 4.14, 4.17
* **License**: Freeware

![photo]({attach}sagrotan_photo_0.png)

### Recognized Viruses:

* **Boot Viruses**: AIDS, Ghost, C'T, OLI, Maulwurf I, Kobold #2, Fastload, Signum BPL, BHP, Fun, Swiss, Screen, VDU, Bomb, PD 141
* **File Viruses**: None
* **Others**: N/A

![photo]({attach}sagrotan_photo_1.png)

## Tasks

### Task 1: Recognize boot viruses not loaded into memory

#### Instructions:

To test a floppy disk with Sagrotan, follow these steps:

* Insert the test floppy into drive A:
* Select the `LAUFWERK` (DRIVE) menu to select the drive
* Select the menu action `Laufwerk A: <A>` to select drive A:
* Select the `VIRUS` menu
* Select the menu action `Bootsektor prüfen <P>` (Check boot sector) to test the boot sector
* Click Ok to confirm the action

![photo]({attach}sagrotan_photo_2.png)

* Then the boot sector details and the analysis result will appear

| Virus       | Analysis                                      | Result                                                                       |
|-------------|-----------------------------------------------|------------------------------------------------------------------------------|
| Ghost       | ![photo]({attach}sagrotan_photo_3.png)        | We see that Sagrotan successfully identified the Ghost virus                             |
| Signum BPL  | ![photo]({attach}sagrotan_photo_4.png)        | We see that Sagrotan successfully identified the Signum virus                        |
| Macumba 3.3 | ![photo]({attach}sagrotan_photo_5.png)        | Sagrotan reported that it found no signs of a virus in the disk's boot sector |
| Carpe Diem  | ![photo]({attach}sagrotan_photo_6.png)        | We see that Sagrotan detected 9 signs of a viral infection |
| OLI         | ![photo]({attach}sagrotan_photo_8.png)        | We see that Sagrotan successfully identified the OLI virus                               |
| OLI2        | ![photo]({attach}sagrotan_photo_9.png)        | We see that Sagrotan detected 7 signs of viral infection in OLI2            |
| EICAR       | ![photo]({attach}sagrotan_photo_11.png)        | Sagrotan said the boot sector is not executable and contains no viruses |

### Task 2: Recognize boot viruses loaded into memory

#### Instructions

* Boot from the infected floppy disk in drive A:
* Change the disk to the Sagrotan disk
* Run Sagrotan
* Check if Sagrotan's warning appears that a virus was found in memory
* If the virus was not fully detected, follow the same instructions as in Task 1

#### One of the most common viruses: Ghost

Test results:

* Hdv_bpb vector infected
* Reset vector infected

Sagrotan recognized the Ghost virus in the boot sector.

#### Key virus and its key disk: Signum BPL

Test results:

* Hdv_bpb vector infected

Sagrotan recognized the Signum BPL virus in the boot sector.

#### Polymorphic virus: Macumba 3.3

Test results:

* No exception vectors outside the allowed memory area.

Sagrotan did not recognize the virus in memory. Sagrotan said it found no signs of a viral infection in the boot sector.

#### Trojan virus: Carpe Diem

Test results:

* Hdv-bpb vector is below allowed user memory
* Reset vector is below allowed user memory

Sagrotan Recognized 9 signs of a viral infection in the boot sector.

#### Stealth virus: OLI

Test results:

* Hdv-init vector is below allowed user memory
* Hdv-rw vector is below allowed user memory
* Trap #14 (XBIOS) vector is below allowed user memory
* Reset vector is below allowed user memory

Sagrotan did not recognize the OLI virus in the boot sector.

#### Super Stealth virus: OLI2

Test results:

* Hdv-init vector is below allowed user memory
* Hdv-rw vector is below allowed user memory
* Trap #14 (XBIOS) vector is below allowed user memory
* Reset vector is below allowed user memory

Sagrotan did not recognize the OLI2 virus in the boot sector.

#### Non-executable boot sector: EICAR

Test results:

Sagrotan reported that there is nothing in memory. This is correct.
Sagrotan reported that the boot sector is not executable and is safe. This is not true.

### Task 3: Recognize a file virus

#### Instructions

##### Option 1

* Select the `VIRUS` menu
* Select the menu action `Datein (Files)` (Check files) to test files for Link Viruses
* Click Ok to confirm the action
* Select the drive to test
* Select the file you want to check
* Click Ok to confirm the action

##### Option 2

* Select the `VIRUS` menu
* Select the menu action `Optionen` to configure file testing for Link Viruses
* Select the file types you want to check
* Click Start to confirm the action
* Select the drive to test
* Select the file you want to check
* Click Ok to confirm the action

![photo]({attach}sagrotan_photo_7.png)

#### First file virus: Milzbrand

Sagrotan reported that the program has a second program but that it is a virus - unlikely.

### Task 4: Restore a damaged boot sector

#### Instructions

* Insert the test floppy into drive A:
* Select the `LAUFWERK` (DRIVE) menu to select the drive
* Select the menu action `Laufwerk A: <A>` to select drive A:
* Select the `BIBLIOTHEK` (LIBRARY) menu
* Select the menu action `Bootsektor speichern`
* Click Ok to confirm the action
* Press any letter and then press ENTER
* Save the boot sector to the Sagrotan library and click OK

Let's check! Let's replace the boot sector with the Sagrotan vaccine and try to restore the floppy disk's boot sector. To restore the floppy disk:

* Select the `VIRUS` menu
* Select the menu action `Bootsektor reparieren`
* Click Ok to confirm the action
* Scroll down and select our recently saved boot sector which is now at the very bottom of the list
* Press `Bootsektor schreiben`
* Boot sector restored!

### Task 5: Vaccinate a non-executable floppy disk

#### Instructions

* Select the `VIRUS` menu
* Select the menu action `Bootsektor schutzen` (write vaccine to boot sector)
* Click Ok to confirm the action
* Click Ja to confirm the action

Now upon boot we will see the message "Kein Virus im Bootsektor". Let's try to run the Ghost virus and see what happens!

* Load the virus into memory
* Change the disk to the one vaccinated by Sagrotan
* Boot from it

We will see the message "Kein Virus im Bootsektor" :( ... Sagrotan could not defeat the virus and the virus will overwrite your boot sector!

### Task 6: Analyze a suspicious boot sector

#### Instructions

* Insert the test floppy into drive A:
* Select the `LAUFWERK` (DRIVE) menu to select the drive
* Select the menu action `Laufwerk A: <A>` to select drive A:
* Select the `VIRUS` menu
* Select the menu action `Bootsektor prüfen <P>` (Check boot sector) to test the boot sector
* Click Ok to confirm the action

When scanning the boot sector, Sagrotan performs heuristic analysis and looks at the disk's condition.
It checks:

* It checks the BPB
* Checksum
* Signs of viral infection
* Infected vectors
* Sagrotan does not check for the Magic long word ($12123456)

After loading, Sagrotan will report if vectors have been changed and if so, will suggest performing a cold reboot. Sagrotan analyzes the boot sector code and outputs information about it:

* Whether the BPB is damaged
* How many signs of viral infection were detected
* Whether the checksum equals $1234

If Sagrotan detects a familiar virus in the boot sector, it will report it and display the percentage match with the virus from the Sagrotan database.

### Task 7: Detect malware when Sagrotan is not running

#### Instructions

Sagrotan does not have a resident TOS accessory that could detect viruses when Sagrotan is not running.

## Summary and Conclusion

In the following table we have summarized the task completion results:

| Task | Result |
| :---------------------------------------------------------------- | :------: |
| Recognize boot viruses not loaded into memory                     |   4/7    |
| Recognize boot viruses loaded into memory                         |  3.5/7   |
| Recognize a file virus                                            |  0.5/1   |
| Restore a damaged boot sector                                     |   1/1    |
| Vaccinate a non-executable floppy disk                            |   0/1    |
| Analyze a suspicious boot sector                                  |   4/5    |
| Detect malware when Sagrotan is not running                       |   0/2    |
| **Total**                                                         |  13/24   |

In conclusion, Sagrotan is one of the first antiviruses in history that began using heuristic analysis to recognize viruses. Its analysis methods are still relevant today!