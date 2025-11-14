Title: Xtermine
Slug: xtermine
Name: Xtermine
Date: 2025-10-28 22:32
Location: Russia
Category: Atari ST, Antivirus
Lang: en
Author: Draedon
status: hidden
summary: This article is about Xtermine...
image: {filename}../../../gallery/antiviruses/xtermine.png
Tags: Antivirus

## Basic Information

- *Version*: 0.2 - released 14/05/1993
- *Author*: Christophe Boyanique aka DMViolator
- *Program language*: French
- *License*: Shareware (50 Francs, a bit less than 8 euros)
- *Can detect*: 12 viruses, 29 antiviruses, 6 utilities, 6 miscellaneous, 10 demos. 63 total
- *Test configuration*: Atari STE TOS 1.62. Xtermine is fully compatible with other Atari computers (TT, Falcon) and latest OS (MultiTOS, Mint...)
- Author's website with the latest demo version: [link](https://www.raceme.org/atari/xtermine/)


### Recognized viruses:

- *Bootsector viruses*: Ghost, C'T, OLI, Kobold #2, Signum BPL, BHP, Mad, Swiss, PD141, Toubab, VDU, Raster & Text
- *Link virus*: None
- Note1: Xtermine can import The Killer, Exorcist and some Sagrotan (with some restrictions) bootsectors libraries
- Note2: Xtermine database identifies Raster & Text as a virus (which is not) and Sagrotan 4.18 as a vaccine (which is not at all but a sneaky virus)

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

| Virus<p>(difficulty) | Analysis                                      | Result                                                                                        |
|:--------------------:|:---------------------------------------------:|:---------------------------------------------------------------------------------------------:|
| [Ghost](https://retrovirology.metaverse.fr/ghost-en.html)<br>(1/5)       | ![photo]({attach}xtermine_photo_1.png)        | Xtermine successfully identified the Ghost virus                                              |
| [Signum BPL](https://retrovirology.metaverse.fr/signum-en.html)<br>(1/5)  | ![photo]({attach}xtermine_photo_2.png)        | Xtermine successfully identified the Signum BPL virus                                         |
| [Macumba 3.3](https://retrovirology.metaverse.fr/macumba3-en.html)<br>(4/5)| ![photo]({attach}xtermine_photo_3.png)        | Xtermine said it is an unknown executable bootsector with 0 signs of viral infection          |
| [Carpe Diem](https://retrovirology.metaverse.fr/carpediem-en.html)<br>(2/5)  | ![photo]({attach}xtermine_photo_4.png)        | Xtermine said it is an unknown executable bootsector but it has 3 signs of viral infection    |
| [OLI](https://retrovirology.metaverse.fr/oli-en.html)<br>(1/5)         | ![photo]({attach}xtermine_photo_5.png)        | Xtermine successfully identified the OLI virus                                                |
| [OLI2](https://retrovirology.metaverse.fr/oli2-en.html)<br>(1/5)        | ![photo]({attach}xtermine_photo_6.png)        | Xtermine reported that it detected only 1 sign of viral infection                             |
| [EICAR](https://retrovirology.metaverse.fr/eicar-en.html)<br>(3/5)       | ![photo]({attach}xtermine_photo_7.png)        | Xtermine said it is an unknown non-executable bootsector with 0 signs of viral infection      |

### Challenge 2: Recognize bootsector viruses loaded in memory

Xtermine cannot scan memory, this option is not implemented in version 0.2. <BR>
However, while stealth viruses are in merory Xtermine:
 
 - Successfully recognized the OLI virus in the bootsector when it was in memory (which catch `floprd` trap calls) ! 
 - But it did not recognize OLI2 which catch `rwabs` calls

OLI2 failed detection, Xtermine "thinks" this is a safe TOS formatted disk:

![photo]({attach}xtermine_photo_11.png)

That indicates that Xtermine probably uses `rwabs` to read the bootsector and not lower level access (talking to the FDC directly) to prevent any misdirection.


### Challenge 3: Recognize a link virus

Xtermine is not capable of analyzing files and detectking link viruses.

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

To write the Xtermine vaccine, simply repeat these steps with the `Raster & Texte` vaccine. Interesting fact: Xtermine has a second vaccine that is labeled as a virus.

Here is what we see upon booting:

<img src="{attach}xtermine_photo_8.png" width="40%"/>&nbsp;<img src="{attach}xtermine_photo_10.png" width="40%"/>

Those vaccines don't do much rather than showing nice rasters, that's more a pretty beacon than real vaccines preventing viruses.

### Challenge 6: Analyze a suspicious bootsector

#### Directions

Xtermine checks the bootsector similarly to how Sagrotan does. But its heuristic analysis is much less advanced than Sagrotan's.

- Xtermine does not check vectors
- Xtermine checks the checksum (`$1234`)
- Xtermine does not check for the Magic long word (`$12123456`) for "non-executable" bootsectors (like EICAR)
- Xtermine performs heuristic analysis of the bootsector, heuristic details are not described.
- Xtermine checks the BPB

### Challenge 7: Detect a malware when Xtermine is not running

#### Directions

Xtermine doesn't have any resident TOS Accessory which can detect viruses while Xtermine is not running.

### Summary and Conclusion

Before the final results, we would like to thank Christophe, a lot. Christophe took the time to find his old floppy disks, test them in order to provide us a fully registered version of Xtermine. We are extremelly grateful. So again, Christophe, thanks a lot!

![photo]({attach}xtermine_photo_12.png)


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

In conclusion, Xtermine is a good antivirus, user friendly, that has good detection capabilities (good but undocumetned heuristics and usage of `rwabs`). And icing on the cake, in addition to your own bootsectors, you can even add libraries from other well known antiviruses!

Nevertheless, the lack of support for Link viruses and memory check are a miss. 