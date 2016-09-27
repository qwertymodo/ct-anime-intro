;***********************************************************************************
;
; CT anime intro for 21fx (MSU1) hack by smkdan, (c) 2011
; Disassembled, edited for re-assembly, and ported to MSU1 by ManuLöwe, (c) 2015
;
;***********************************************************************************



  WHAT THIS PATCH DOES
______________________________________________________________________

This re-implements smkdan's Chrono Trigger anime intro hack, which
was made for a SNES multimedia add-on named "21fx" back in 2011. Now
called the MSU1, and implemented in hardware by ikari_01, this en-
hancement unit has grown rather popular, so I thought I'd contribute
to the growing list of software and mods by disassembling smkdan's
work (the sourcecode of which apparently got lost over the years) and
making it compatible with the latest MSU1 specifications. :-)



  DISCLAIMER
______________________________________________________________________

All trademarks mentioned in this readme file are the property of their
respective owners.

This software is freeware. It is provided "as is" and without express
or implied warranty of any kind. ManuLöwe will not be held liable or
responsible for any losses, damages, injuries, and/or legal consequen-
ces due to the misuse and/or illegal use of any of the files con-
tained within this archive. 



  TECHNICAL DETAILS
______________________________________________________________________

While making this patch, four different emulators were used:
- Geiger's Snes9x tracer v1.43ep9r8, for tracing the original boot
  routine in CT.
- bsnes v058 debugger, which has 21fx support and allowed me to trace
  close to 99% of smkdan's code.
- bsnes v071 debugger, which supports the MSU1 _and_ has a nice
  tracer as well.
- higan v094, which is the latest software that supports the MSU1.

It took a few hours to obtain a file of usable assembly code from
the tracelogs. Routines and snippets had to be rearranged in order
to restore the original program flow. The few remaining holes -- a
couple of missing labels, data tables a tracer naturally omits, and
even small bits of code that a branching path hadn't been taken to
during tracing -- were filled in the hard way, i.e. by reading and
context-based interpreting the corresponding section in the ROM
using a hex editor.

Before I started to update smkdan's code, I made sure it assembled
just fine, resulting in a byte-perfect copy of his original hacked
ROM. This achieved, "porting" the hack to MSU1 was basically a piece
of cake. :-) One of the major challenges was to get bsnes v071 to
cooperate by finding a suitable template XML file, which is needed
for the emulator to actually enable MSU1 support. While the original
MSU1 data file simply had to be renamed, the WAV file was converted
to PCM using wav2msu.

The original implementation of the 21fx had the data port (and all of
its control registers) sitting on the B-bus of the SNES, which re-
quired developers to buffer all streamed data in WRAM for DMA. In the
course of the transition to the MSU1, ports and registers were thank-
fully relocated to the A-bus, allowing the data port to be used as a
fixed source for DMA.

Initially, I didn't bother to eliminate the WRAM buffer. Later on, I
decided to update the hack in that regard for the sake of simplicity
and code readability. Also, the issue that users of sd2snes had to
rename the PCM file is now resolved, and the hack should run on both
sd2snes and higan out-of-the-box. :-)



  HOW TO USE BPS FILES
______________________________________________________________________

Read your emulator's docs to check whether it supports real-time BPS
patching. Or, find and download a tool named beat v03. It's self-
explanatory and easy to use. The source ROM must not have a copier
header (file size: exactly 4.194.304 bytes, checksum: 0x788C,
CRC32: 2D206BF7, rename it to ct_msu1.sfc).



  QUESTIONS, COMMENTS ...
______________________________________________________________________

... will be ignored. :p



  THANKS
______________________________________________________________________

- byuu for inventing the 21fx/MSU1
- ikari_01 for inventing the sd2snes
- smkdan for his original work on CT



