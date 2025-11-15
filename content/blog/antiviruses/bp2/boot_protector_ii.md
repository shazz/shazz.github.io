Title: Boot Protector
Slug: bootprotectorii
Name: Boot Protector
Date: 2025-11-01 18:46
Location: Russia
Category: Atari ST, Antivirus
Lang: en
Author: draedon
status: hidden
summary: This article is about Boot Protector...
image: {filename}../../../gallery/antiviruses/bootprotectorii.png
Tags: Antivirus

## Basic Information
* *Version*: 2.82
* *Author*: Fantomas (Michel GOUX)
* *Language*: French
* *Release Date*: 11/12/2024
* *Recognizes*: 515 boot sectors
* Author's website: [click!](https://dompub030.netlify.app/)



### Recognized Viruses:

* **Boot Viruses**: C'T, CARPEDIEM, COOKIE #1, COOKIE #2, DIR. WASTER, EVIL NICK, FAT (SWISS/BLOT), FLYING CHIMP, FREEZE, GREEN GOBLIN, GHOST (A, I), KOBOLD II, MAD (FUN), MERLIN MAD, OLI, PIRATE TRAP, SCREEN, SIGNUM BPL (KEY), VIR'87 VIRUS (BHP), VIRUS MASTER 
* **link viruses**: None
* **Others**: 494 others bootsectors

## Tasks

### Task 1: Recognize boot viruses not loaded into memory

#### Instructions:

To test a floppy disk with Boot Protector, follow these steps:

* Insert the test floppy into drive A:
* Click on the floppy disk image labeled A

![photo]({attach}bp2_photo_1.png)

* Then the boot sector details and the analysis result will appear

| Virus<p>Difficulty                      | Analysis                                            | Result                                                                         |
|:---------------------------------------:|:---------------------------------------------------:|:------------------------------------------------------------------------------:|
| [Ghost](/ghost-en.html) (1/5)           | <img src="{attach}bp2_photo_2.png" width="60%"/>    | Boot Protector II correctly recognized the Ghost virus                         |
| [Signum BPL](/signum-en.html) (1/5)     | <img src="{attach}bp2_photo_3.png" width="60%"/>    | Boot Protector II correctly recognized the Signum BPL virus                    |
| [Macumba 3.3](/macumba3-en.html) (4/5)  | <img src="{attach}bp2_photo_4.png" width="60%"/>    | Boot Protector II said this is an unknown executable boot sector               |
| [Carpe Diem](/carpediem-en.html) (2/5)  | <img src="{attach}bp2_photo_5.png" width="60%"/>    | Boot Protector II said this is an unknown executable boot sector. (See NOTE 1) |
| [OLI](/oli-en.html)      (1/5)          | <img src="{attach}bp2_photo_6.png" width="60%"/>    | Boot Protector II correctly recognized the OLI virus                           |
| [OLI2](/oli2-en.html)     (1/5)         | <img src="{attach}bp2_photo_7.png" width="60%"/>    | Boot Protector II said this is an unknown executable boot sector               |
| [EICAR](/eicar-en.html)   (3/5)         | <img src="{attach}bp2_photo_8.png" width="60%"/>    | Boot Protector II said this is an unknown non-executable boot sector           |

NOTE 1: For tests we use the Fixed version of Carpe Diem to check how antiviruses will react to an unknown virus. If this was the original Carpe Diem then Boot Protector II would detect it.

### Task 2: Recognize boot viruses loaded into memory

#### Instructions

* Boot from the infected floppy disk in drive A:
* Change the disk to the Boot Protector II disk
* Enter Boot Protector II

Note that if a virus is already in memory or some vectors are attached, Boot Protector II won't load:

<img src="{attach}bp2_photo_0.png" width="640"/> 

#### One of the most common viruses: Ghost

Test results: Hdv_bpb vector infected, Boot Protector II correctly recognized the Ghost virus in the boot sector

#### Key virus and its key disk: Signum BPL

Test results: Hdv_bpb vector infected, Boot Protector II correctly recognized the Signum BPL virus in the boot sector

#### Polymorphic virus: Macumba 3.3

Test results: Hdv_bpb infected, Hdv_rw infected. Boot Protector II did not recognize the Macumba 3.3 virus in the boot sector

#### Trojan virus: Carpe Diem

Test results: Boot Protector II did not recognize Carpe Diem (Fixed) in memory and did not recognize it in the boot sector.

#### Stealth virus: OLI

Test results: Hdv-rw vector infected

#### Super Stealth virus: OLI2

Test results: Hdv-rw vector infected

#### Non-executable boot sector: EICAR

Test results:

- Boot Protector reported that there is nothing in memory. This is correct.
- Boot Protector reported that the boot sector is not executable. This is not true.

### Task 3: Recognize a link virus

Boot Protector II cannot scan files for viruses

### Task 4: Restore a damaged boot sector

Boot Protector II cannot restore the boot sector

### Task 5: Vaccinate a non-executable floppy disk

#### Instructions

* Insert the test floppy into drive A:
* Click on the floppy disk image labeled A
* Click on the syringe on the right
* Click OK to confirm the action

Now when booting from this disk you will see this:

![photo]({attach}bp2_photo_9.png)

Unfortunately the vaccine didn't help me and the virus overwrote the boot sector!

### Task 6: Analyze a suspicious boot sector

#### Instructions

* Insert the test floppy into drive A:
* Press F1 in the main menu

Boot Protector II checks:

* Disk BPB
* Checksum
* Vectors when starting Boot Protector
* Boot Protector II does not check Magic Long Word ($12123456)
* Boot Protector II does not perform heuristic disk analysis

### Task 7: Detect malware when Boot Protector II is not running

Boot Protector II does not have a scanner when it is not running

## Summary and Conclusion

In the following table we have summarized the task completion results:

| Task                                                              | Result    |
|-------------------------------------------------------------------|:---------:|
| Recognize boot viruses not loaded into memory                     |   3/7     |
| Recognize boot viruses loaded into memory                         |   2/7     |
| Recognize a link virus                                            |   0/1     |
| Restore a damaged boot sector                                     |   0/1     |
| Vaccinate a non-executable floppy disk                            |   0/1     |
| Analyze a suspicious boot sector                                  |   3/5     |
| Detect malware when Boot Pro is not running                       |   0/2     |
| **Total**                                                         |   8/24    |

In conclusion, Boot Protector is not a bad antivirus in principle and it detects many boot sectors... 515!