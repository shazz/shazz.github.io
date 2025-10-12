Title: VKiller
Slug: vkiller
Name: VKiller
Date: 2025-10-06 12:04
Location: Montreal / Canada
Category: Atari ST, Antivirus
Lang: en
Author: shazz & draedon
status: hidden
summary: This article is about VKiller...
image: {filename}../../../gallery/antiviruses/vkiller.png
Tags: Antivirus

## Basic information
* Author: George R. Woodside
* Program language: English
* Version 3.84
* Creation date: April 1991
* Can detect boot sectors

## Main text

When we enter, we are greeted with a warning.

![photo]({attach}vkiller_photo_0.png)

After that, we select drive A/B and enter the main menu. 

![photo]({attach}vkiller_photo_1.png)

At the top, we see tabs... Let's quickly run through them!

1. _Desk_

2. _File_

3. _Options_

1. Here you can view information about the author.

![photo]({attach}vkiller_photo_2.png)

2. Here you can exit the program and select the file selector

3. Here you can:

    1. **Quiet**

    2. **System Info**

    3. **Test Kill**

    4. **Extra Zeroing**

        1. Apparently disables sounds in the program?

        2. Displays system information

        ![photo]({attach}vkiller_photo_3.png)

        ![photo]({attach}vkiller_photo_4.png)

### Main functionality

1. You can check drive A/B. 

2. You can view the boot sector in HEX and ASCII simultaneously! Function: Show

3. You can print all data or just the boot sector! Function: Print

4. You can write the boot sector to a file! Function: File

5. You can kill the boot sector! Function: Kill

6. You can put a vaccine in the boot sector! Function: Guard

7. You can repair the boot sector if the BPB is damaged! Function: Repair

8. You can exit the program! Function: Quit

### Information about boot sectors

If Vkiller recognizes a boot sector, you can find out information about it by clicking the “Boot sector recognized!” button.

### Vaccine

This antivirus has its own vaccine, and when you boot up, you'll see this:

![photo]({attach}vkiller_photo_5.png)

## Virus Test

* **ACA**

* **Macumba 3.3**

* **Merlin's Mad**

* **Non-Executable EICAR Virus**

* **Oli**

### Test results

1. **Vkiller** correctly identified the ACA virus.

2. **Vkiller** said that extra sectors are not zeroed and the boot sector is executable.

3. **Vkiller** said that extra sectors are not zeroed and the boot sector is executable.

4.  **Vkiller** said that extra sectors are not zeroed and the boot sector is not zeroed, but the disk is safe.

5. **Vkiller** correctly identified the OLI virus.

## In conclusion

This is basically an average virus killer that can detect some interesting viruses. 5/10