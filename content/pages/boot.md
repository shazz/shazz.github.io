Title: Atari ST booting process
Slug: HowAtariBoots
Date: 1994-10-06 12:34
Location: Slovenia
Category: Atari ST
Lang: en
Author: Lucky Lady

### Booting

Upon a cold or warm boot, microprocessors in the 680x0 series load the initial supervisor stack pointer from the second longword in memory ($4) and begin execution at the PC found in
the first longword ($0). The location this points to is the base initialization point for the Atari computers. Every Atari computer or TOS clone follows a predefined set of steps to accomplish system initialization. The following illustrates these steps leaving out some hardware initialization which is specific to the particular computer line (ST, TT, Falcon, etc.).

A cold boot occurs when the computer system experiences a total loss of power and no memory locations can be considered valid (this can be done artificially by zeroing memory, as is the case with the CTRL_ALT_right SHIFT-DELETE reset). A warm boot is a manual restart of the system which can be accomplished via software or the reset button or with CTRL-ALT_DELETE reset.

### Step / description:

1. The Interrupt Priority Level (IPL) is set to 7 and the OS switches to supervisor mode.

2. A RESET instruction is executed to reset external hardware devices.

3. The presence of diagnostic cartridge is determined. If one is inserted, it is JMP'ed to with a return address in register A6.

4. If running on a MC68030/68040, the `CACR`, `VBR`, `TC`, `TT0` and `TT1` registers are initialized.

5. If a floating-point coprocessor is present it is initialized.

6. If the `memvalid` ($4F2), `memval2` ($43A), and `memval3` ($51A) system variables are all valid, a warm boot is assumed and the memory controller is initialized with the return value from `memcntrl` ($424).

7. The initial color palette registers are loaded and the screen base is initialized to $100000.

8. Memory is sized if it wasn't from a previous reset.

9. Magic numbers are stored in low memory to indicate the successful sizing and initialization of memory.

10. System variables and the cookie jar are initialized.

11. The BIOS initialization point is executed.

12. Installed cartridges of type 2 are executed.

13. The screen resolution is programmed.

14. Installed cartridges of type 0 are executed.

15. Interrupts are enabled by lowering the IPL to 3.

16. Installed cartridges of type 1 are executed.

17. If running TOS 2.06, 3.06, 4.0x or 5.0x, the Fuji logo is displayed and a memory test and hard disk spin-up sequence is executed.

18. If at least one floppy drive is attached to the system, the first sector (bootsector) of the first floppy drive is loaded and if executable, it is called.

19. If at least one hard disk or other media is attached to the system, the first sector of each is loaded in succession until one with an executable sector is found or each has been tried.

20. If a hard disk sector was found that was executable, it is executed.

21. The text cursor is enabled.

22. All "\AUTO\*.PRG" files found on the boot disk are executed.

23. If `cmdload` ($482) is 0 then an environment string is created and the AES is launched, otherwise "\COMMAND.PRG" is loaded.

24. If the AES ever terminates, the system is reset and system initialization begins again.
