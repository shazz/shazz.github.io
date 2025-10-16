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

A cold boot occurs when the computer system experiences a total loss of power and no memory locations can be considered valid (this can be done artificially by zeroing memory, as is the case with the CTRL-ALT-right SHIFT-DELETE reset). A warm boot is a manual restart of the system which can be accomplished via software or the reset button or with CTRL-ALT-DELETE reset.

### Step / description:

Here is the TOS boot process, the steps in **bold** indicates potential virus usage.

1. The Interrupt Priority Level (IPL) is set to 7 and the OS switches to supervisor mode.
1. A `RESET` instruction is executed to reset external hardware devices.
1. The presence of diagnostic cartridge is determined. If one is inserted, it is JMP'ed to with a return address in register A6.
1. If running on a MC68030/68040, the `CACR`, `VBR`, `TC`, `TT0` and `TT1` registers are initialized.
1. If a floating-point coprocessor is present it is initialized.
1. If the `memvalid` (`$4F2`), `memval2` (`$43A`), and `memval3` (`$51A`) system variables are all valid, a warm boot is assumed and the memory controller is initialized with the return value from `memcntrl` (`$424`).
1. **Reset Vector**: if the reset vector is set and `resvalid` contains `$31415926` then the routine is JMP'ed to.
1. Memory set up (`meminit`)
    - The initial color palette registers are loaded and the screen base is initialized to `$10000` 
    - Memory controller is configured
    - Memory is sized if it wasn't from a previous reset (PHYSTOP).
1. At first boot:
    - memory is cleared after `sysvars_start` to `ram_size`
    - Magic numbers are stored in low memory to indicate the successful sizing and initialization of memory.
    - Cache is set on MegaSTE, TT, Falcon
1. Screen mory is step to `PHYSTOP` - screen_size (`$8000`) and the memory is cleared from here to PHYSTOP.
1. System variables are initialized
1. Cookie jar are initialized.
1. Exception vectors are initialized
1. The BIOS initialization point is executed.
1. MFP, IKBD are initialized
1. Installed cartridges of type 2 are executed.
1. The screen resolution is set, blitter initialized, initialize terminal mode (The text cursor enabled)
1. Installed cartridges of type 0 are executed.
1. Interrupts are enabled by lowering the IPL to 3.
1. Installed cartridges of type 1 are executed.
1. If running TOS 2.06, 3.06, 4.0x or 5.0x, the Fuji logo is displayed and a memory test and hard disk spin-up sequence is executed.
1. **HDV Boot**: routine hdv_boot is called, if at least one floppy drive is attached to the system, the bootsector of the first floppy drive is loaded and if executable, it is called.
1. DMA Boot: If at least one hard disk or other media is attached to the system, the first sector of each is loaded in succession until one with an executable sector is found or each has been tried.
1. IDE Boot: If a hard disk sector was found that was executable, it is executed.
1. **Resident programs**: if a Reset Resident program exists (i.e. with valid header at `$200` boundaries), it will be executed.
1. Startup GEM
1. All `\AUTO\*.PRG` files found on the boot disk are executed.
1. If `cmdload` (`$482`) is 0 then an environment string is created and the AES is launched, otherwise `\COMMAND.PRG` is loaded.
1. If the AES ever terminates, the system is reset and system initialization begins again.

## Sources

- Lucky Lady, UDV Manual
- TOS 1.x disassembly from Thorsten Otto: [Github](https://github.com/th-otto/tos1x/blob/master/bios/startup.S)