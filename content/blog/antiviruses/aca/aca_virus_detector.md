Title: ACA Virus Detector And Vaccin 
Slug: acavirusdetector
Name: ACA Virus Detector And Vaccin 
Date: 2025-10-30 18:10
Location: Russia
Category: Atari ST, Antivirus
Lang: en
Author: draedon
status: hidden
summary: This article is about ACA Virus Detector and Vaccin...
image: {filename}../../../gallery/antiviruses/acavirusdetector.png
Tags: Antivirus

## Basic information

* *Version*: 1.0
* *Author*: Anti Copyright Association (ACA) 
* *Language*: English
* *Release date*: 1988
* *Can detect*: ACA

![photo]({attach}aca_photo_0.png)

### Recognized Viruses:

* **Bootsector Viruses**: ACA
* **Link Viruses**: None
* **Others**: ACA Vaccine

## Tasks

### Task 1: Recognize boot viruses not loaded into memory

#### Instructions:

To test a floppy disk with ACA, follow these steps:

* Insert the test floppy into drive A:
* Press F1 to check the disk
* Then the boot sector details and the analysis result will appear

| Virus<p>Difficulty   | Analysis                                          | Result                                             |
|:---------------------:|:-------------------------------------------------:|:--------------------------------------------------:|
| Ghost<br>(1/5)        | <img src="{attach}aca_photo_2.png" width="60%"/>  | ACA VKILL said the disk may contain a virus        |
| Signum BPL<br>(1/5)   | <img src="{attach}aca_photo_3.png" width="60%"/>  | ACA VKILL said the disk may contain a virus        |
| Macumba 3.3<br>(4/5)  | <img src="{attach}aca_photo_4.png" width="60%"/>  | ACA VKILL said the disk is clean                   |
| Carpe Diem<br>(2/5)   | <img src="{attach}aca_photo_5.png" width="60%"/>  | ACA VKILL said the disk is clean                   |
| OLI<br>(1/5)          | <img src="{attach}aca_photo_6.png" width="60%"/>  | ACA VKILL said the disk may contain a virus        |
| OLI2<br>(1/5)         | <img src="{attach}aca_photo_7.png" width="60%"/>  | ACA VKILL said the disk may contain a virus        |
| EICAR<br>(3/5)        | <img src="{attach}aca_photo_8.png" width="60%"/>  | ACA VKILL said the disk is clean                   |
| ACA<br>(1/5)          | <img src="{attach}aca_photo_1.png" width="60%"/>  | ACA is detected :)                                 |

### Task 2: Recognize boot viruses loaded into memory

ACA VKIL cannot scan memory

### Task 3: Recognize a link virus

ACA VKIL cannot scan files for link viruses

### Task 4: Restore a damaged boot sector

ACA VKIL cannot restore the boot sector

### Task 5: Vaccinate a non-executable floppy disk

#### Instructions

##### Method 1

- Press F2 in the main menu and you will get a vaccine that only protects against the ACA virus.

##### Method 2

- With `SHIFT` or `CAPS LOCK` held down, type `EVOT`
- In the main menu press F6 and after that the disk will be infected with the ACA virus

The vaccine from method 1 will not protect against viruses other than ACA

### Task 6: Analyze a suspicious boot sector

#### Instructions

* Insert the test floppy into drive A:
* Press F1 in the main menu

ACA VKIL checks the first byte and if it is 60 but it is not an ACA virus, it will say that there is a possible virus on the disk.
The maximum that will happen is that ACA VKIL will report that the disk may contain a virus

### Task 7: Detect malware when ACA VKIL is not running

ACA VKIL does not have a scanner when it is not running

## Summary and Conclusion

In the following table we have summarized the task completion results:

| Task | Result |
| :---------------------------------------------------------------- | :------: |
| Recognize boot viruses not loaded into memory                     |   1/8    |
| Recognize boot viruses loaded into memory                         |   0/8    |
| Recognize a link virus                                            |   0/1    |
| Restore a damaged boot sector                                     |   0/1    |
| Vaccinate a non-executable floppy disk                            |   0/1    |
| Analyze a suspicious boot sector                                  |   0/5    |
| Detect malware when ACA VKIL is not running                       |   0/2    |
| **Total**                                                         |   1/26   |

In conclusion, ACA VKIL is a terrible antivirus that can even infect your disk with a virus! Don't use this!!!