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

- *Last version*: 4.17 released 1990-05-13
- *Author*: Henrik Alt
- *language*: German, some versions translated in English and French
- *Can detect*: 15 viruses, 91 regular boot sectors, 106 total. X link viruses
- *Other known versions*: 4.03, 4.10, 4.12, 4.14, 4.17
- *License*: Freeware

![photo]({attach}sagrotan_photo_0.png)


### Recognized viruses:

- *Boosectors viruses*: AIDS, Ghost, CT, OLI, Maulwurf I, Kobold #2, Fastload, Signum BPL, BHP, Fun, Swiss, Screen, VDU, Bomb, PD141t,...
- *Link virus*: ...
- *Others*: N/A

![photo]({attach}sagrotan_photo_6.png)

## Chalenges

### Challenge 1: Recognize bootsector viruses not loaded in memory

#### Directions:

To test a floppy disk using Sagrotan, here are the following actions:

- insert the floppy disk to test in drive A:
- select the menu `LAUFWERK` to choose the drive
- select the menu action `Laufwerk A:  <A>` to chose the drive A
- select the menu `VIRUS`
- select the menu action `Bootsektor prüfen  <P>` to test the bootsector
- Click Ok to validate the action

![photo]({attach}sagrotan_photo_2.png)

- Then the bootsector details will appear and the analysis result

#### One of the most spread virus: Ghost

Here is the result with a disk infected by the Ghost virus:

![photo]({attach}sagrotan_photo_2.png)

We can see that Sagrotan succesfully identified the Ghost virus...


#### A key virus and is keyed disk: Signum BPL

#### A polymorphic virus: Macumba 3.3

#### A trojan virus: Carpe Diem

#### A stealth virus: OLI2

#### A non executable bootsector: EICAR

### Challenge 2: Recognize bootsector viruses loaded in memory

#### Directions

- Boot with the infected floppy disk in drive A:
- Swap the disk with Sagrotan 
- Run Sagrotan
- Check Sagrotan warning appears, saying that the virus is found in memory
- If the virus was not fully detected, run the same directions as Challenge 1


#### One of the most spread virus: Ghost

Here is the result with a disk infected by the Ghost virus:

![photo]({attach}sagrotan_photo_2.png)

#### A key virus and is keyed disk: Signum BPL

#### A polymorphic virus: Macumba 3.3

#### A trojan virus: Carpe Diem

#### A stealth virus: OLI2

#### A non executable bootsector: EICAR


### Challenge 3: Recognize a link virus

#### Directions

 - ... => Explain direction to detect a link virus knowing that 2 methods exists, one is using known footprint of PRG/TOS/TTP files and check if the footprint has changed, second is really to look like at the link virus code.

![photo]({attach}sagrotan_photo_4.png)

#### The first link virus: Milzbrand


### Challenge 3: Restore a broken bootsector

#### Directions

 - ... => Explain direction to repair a boot sector, take the Fantasia deo from Dune, add the bootsector to the library, replace the bootsector using the vaccine, repair the bootsector and check the demo is still working after restoration.

### Challenge 4: Vaccine a non executable floppy disk

#### Directions

 - ... => Explain directions to vaccine a floppy disk, reboot with an infected disk, warm reboot with the vaccinated disk and check if the vaccin detected the virus and if it was not repalced by the virus

![photo]({attach}sagrotan_photo_5.png)

### Challenge 5: Analyze a suspicious bootsector

#### Directions

- ... => Explain directions to study a suspicious bootsector: vectors, checksum, heuristics, BPB,...

![photo]({attach}sagrotan_photo_3.png)

### Challenge 6: Detect a malware when Sagrotan is not running

#### Directions

 - ... => Explain the directions to run the resident virus checker, usually a memory resident vaccine or a TOS ACC-essory, then try to detect a bootsector virus and a link virus

Sagrotan doesn't have any resident TOS Accessory which can detect viruses while Sagrotan is not running 


### Summary and Conclusion

In the following table, we summarized the challenges results:

| Challenge                                           | Result   |
|-----------------------------------------------------|:--------:|
| Recognize bootsector viruses not loaded in memory   |  5/6     |
| Recognize bootsector viruses loaded in memory       |  1/6     |
| Restore a broken bootsector                         |  1/1     |
| Vaccine a non executable floppy disk                |  1/4     |
| Analyze a suspicious bootsector                     |  3/4     |
| Detect a malware when Sagrotan is not running       |  0/2     |
| **Total**                                           |  10/20   |

As a conclusion, we can say that...