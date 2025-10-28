Title: Xtermine
Slug: xtermine
Name: Xtermine
Date: 2025-10-06 12:04
Location: Montreal / Canada
Category: Atari ST, Antivirus
Lang: en
Author: shazz & draedon
status: hidden
summary: This article is about Xtermine...
image: {filename}../../../gallery/antiviruses/xtermine.png
Tags: Antivirus

## Basic Information

- *Version*: 0.2 released 14/05/1993
- *Author*: Christophe Boyanique
- *Program language*: French
- *Can detect*: 12 viruses, 29 antiviruses, 6 utilities, 6 miscellaneous, 10 demos. 63 total
- Author's website with the latest version: [click!](https://www.raceme.org/atari/xtermine/)

### Recognized viruses:

- *Bootsector viruses*: Ghost, C'T, OLI, Kobold #2, Signum BPL, BHP, Fun, Swiss, PD141t, BLOT, Toubab, VDU, Raster & Text
- *Link virus*: ...
- *Others*: N/A

![photo]({attach}xtermine_photo_0.png)

### Challenge 1: Recognize bootsector viruses not loaded in memory

#### Directions:

To test a floppy disk using Xtermine, here are the following actions:

- Insert the floppy disk to test in drive A:
- Select the menu `Boot`
- Select the menu action `Lecteur A:` to choose the drive
- Select the disk and click Ok
- Select the menu `Boot`
- Select the menu action `Lire` to test the bootsector
- Click Ok to validate the action

| Virus       | Analysis                                      | Result                                                                       |
|-------------|-----------------------------------------------|------------------------------------------------------------------------------|
| Ghost       | ![photo]({attach}xtermine_photo_1.png)        | Xtermine successfully identified the Ghost virus                             |
| Signum BPL  | ![photo]({attach}xtermine_photo_2.png)        | Xtermine successfully identified the Signum BPL virus                        |
| Macumba 3.3 | ![photo]({attach}xtermine_photo_3.png)        | Xtermine said it is an unknown executable bootsector with 0 signs of viral infection |
| Carpe Diem  | ![photo]({attach}xtermine_photo_4.png)        | Xtermine said it is an unknown executable bootsector but it has 3 signs of viral infection |
| OLI         | ![photo]({attach}xtermine_photo_5.png)        | Xtermine successfully identified the OLI virus                               |
| OLI2        | ![photo]({attach}xtermine_photo_6.png)        | Xtermine reported that it detected only 1 sign of viral infection            |
| EICAR       | ![photo]({attach}xtermine_photo_7.png)        | Xtermine said it is an unknown non-executable bootsector with 0 signs of viral infection |

### Challenge 2: Recognize bootsector viruses loaded in memory

Xtermine cannot scan memory. However, Xtermine successfully recognized the OLI virus in the bootsector when it was in memory! But it did not recognize OLI2...

### Challenge 3: Recognize a link virus

Xtermine is not capable of analyzing files.

### Challenge 4: Restore a broken bootsector

#### Directions

- Insert the floppy disk to test in drive A:
- Select the menu `Boot`
- Select the menu action `Lecteur A:` to choose the drive
- Select the disk and click Ok
- Select the menu `Boot`
- Select the menu action `Lire` to test the bootsector
- Click Ok to validate the action
- Select the menu `Biblio`
- Select the menu action `Inserer Boot`
- Add a description, select the bootsector type, select the vaccination type
- Click `METTRE A JOUR` to save the bootsector to the library

After you have saved the bootsector to the Xtermine library, you can load it into the bootsector. To do this, follow the instructions:

- Find the saved bootsector in the list
- Press and hold the button on the bootsector you want to put on the disk
- Select Vacciner and release the button
- In the menu that opens, click `Vacciner A:`

Congratulations! You have written your bootsector to the disk!

![photo]({attach}xtermine_photo_9.png)

### Challenge 5: Vaccine a non executable floppy disk

#### Directions

With Xtermine, you can vaccinate a disk with any of the provided bootsectors on the left. To write to the disk, repeat these steps:

- Press and hold the button on the bootsector you want to put on the disk
- Select Vacciner and release the button
- In the menu that opens, click `Vacciner A:`

To write the Xtermine vaccine, simply repeat these steps with the Raster & Texte vaccine. Interesting fact: Xtermine has a second vaccine that is labeled as a virus.

Here is what we see upon booting:

![photo]({attach}xtermine_photo_10.png)

![photo]({attach}xtermine_photo_8.png)

This vaccine has bugs, but having two of them is already good.

### Challenge 6: Analyze a suspicious bootsector

#### Directions

Xtermine checks the bootsector similarly to how Sagrotan does. But its heuristic analysis is much less advanced than Sagrotan's.

- Xtermine does not check vectors
- Xtermine checks the checksum
- Xtermine does not check for the Magic long word ($12123456)
- Xtermine performs heuristic analysis of the bootsector
- Xtermine checks the BPB

### Challenge 7: Detect a malware when Xtermine is not running

#### Directions

Xtermine doesn't have any resident TOS Accessory which can detect viruses while Xtermine is not running.

### Summary and Conclusion

In the following table, we summarized the challenges results:

| Challenge                                           | Result   |
|-----------------------------------------------------|:--------:|
| Recognize bootsector viruses not loaded in memory   |  4/7     |
| Recognize bootsector viruses loaded in memory       |  1/7     |
| Recognize a link virus                              |  0/1     |
| Restore a broken bootsector                         |  1/1     |
| Vaccine a non executable floppy disk                |  1/1     |
| Analyze a suspicious bootsector                     |  3/5     |
| Detect a malware when Xtermine is not running       |  0/2     |
| **Total**                                           |  10/24   |

In conclusion, Xtermine is a good antivirus that can detect the OLI virus while it is in memory. You can even add libraries from other antiviruses!