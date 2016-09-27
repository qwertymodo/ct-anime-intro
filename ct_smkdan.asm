;***********************************************************************************
;
; CT anime intro for 21fx (MSU1) hack by smkdan, (c) 2011
; Disassembled and edited for re-assembly by ManuLöwe, (c) 2015
;
; Assembling this file using a vanilla Chrono Trigger ROM image will yield a ROM
; which is 100% identical to smkdan's original CT anime intro hack. Along with
; ct_msu1.msu (renamed to 21fx.bin) and a WAV version of the music (renamed to
; audio00000.wav), this is playable on any emulator that supports the 21fx (e.g.,
; bsnes v058).
;
;***********************************************************************************



; ************************* Source ROM layout **************************

.MEMORYMAP					; SNES ROM area per bank: $0000-$FFFF
	SLOTSIZE $10000				; ROM area is $10000 bytes in size
	DEFAULTSLOT 0				; SNES has only one slot per bank
	SLOT 0 $0000
.ENDME

.ROMBANKSIZE $10000				; ROM bank size = 64 KBytes

.ROMBANKS 64					; 32 Mbits

.BACKGROUND "ct.sfc"				; original CT ROM image (without copier header)

.BASE $C0					; HiROM, bank 0 = $C0



; ******************************** Code ********************************

.BANK $00 SLOT 0
.ORG $FF03					; ROM location $00FF03

.SECTION "jmp 1" OVERWRITE

; $00/FF03 5C 00 E0 DC JMP $DCE000[$DC:E000]   A:0000 X:0000 Y:0000 P:envMXdIzC

	jml label_dce000

.ENDS



.BANK $07 SLOT 0
.ORG $0140					; ROM location $070140

.SECTION "jmp 2" OVERWRITE

; $C7/0140 5C 04 E0 DC JMP $DCE004[$DC:E004]   A:0081 X:08A0 Y:005C P:eNvMxdIzc

	jml label_dce004

.ENDS



.BANK $1C SLOT 0
.ORG $E000					; ROM location $1CE000

.SECTION "msu1 code" OVERWRITE

label_dce000:
	jml $fdc000

label_dce004:
	phb                    ; A:0081 X:08a0 Y:005c S:06f8 D:0100 DB:00 NvMxdIzc V:213 H: 160
	phd                    ; A:0081 X:08a0 Y:005c S:06f7 D:0100 DB:00 NvMxdIzc V:213 H: 180
	php                    ; A:0081 X:08a0 Y:005c S:06f5 D:0100 DB:00 NvMxdIzc V:213 H: 208
	rep #$30               ; A:0081 X:08a0 Y:005c S:06f4 D:0100 DB:00 NvMxdIzc V:213 H: 228
	cpx #$0131             ; A:0081 X:08a0 Y:005c S:06f4 D:0100 DB:00 NvmxdIzc V:213 H: 246
	bne label_e026     ; [dce026] ; A:0081 X:08a0 Y:005c S:06f4 D:0100 DB:00 nvmxdIzC V:213 H: 264
	cpy #$0130             ; A:0181 X:0131 Y:0130 S:06ee D:0100 DB:00 nvmxdiZC V:  2 H: 694
	bne label_e026     ; [dce026] ; A:0181 X:0131 Y:0130 S:06ee D:0100 DB:00 nvmxdiZC V:  2 H: 712
	lda.l $0021f0   ; [0021f0] ; A:0181 X:0131 Y:0130 S:06ee D:0100 DB:00 nvmxdiZC V:  2 H: 724
	beq label_e026     ; [dce026] ; A:00c1 X:0131 Y:0130 S:06ee D:0100 DB:00 nvmxdizC V:  2 H: 760
	lda #$0000             ; A:00c1 X:0131 Y:0130 S:06ee D:0100 DB:00 nvmxdizC V:  2 H: 772
	tcd                    ; A:0000 X:0131 Y:0130 S:06ee D:0100 DB:00 nvmxdiZC V:  2 H: 790
	jsr label_e02c     ; [dce02c] ; A:0000 X:0131 Y:0130 S:06ee D:0000 DB:00 nvmxdiZC V:  2 H: 802
	jsr label_e1b6     ; [dce1b6] ; A:ff41 X:0014 Y:0001 S:06ee D:0000 DB:00 nvmxdiZC V:224 H:1226
	jmp label_e041

label_e026:
	rep #$20               ; A:0081 X:08a0 Y:005c S:06f4 D:0100 DB:00 nvmxdIzC V:213 H: 282
	jml $c70145   ; [c70145] ; A:0081 X:08a0 Y:005c S:06f4 D:0100 DB:00 nvmxdIzC V:213 H: 300

label_e02c:
	php                    ; A:0000 X:0131 Y:0130 S:06ec D:0000 DB:00 nvmxdiZC V:  2 H: 842
	sep #$30               ; A:0000 X:0131 Y:0130 S:06eb D:0000 DB:00 nvmxdiZC V:  2 H: 862
	stz $4200     ; [004200] ; A:0000 X:0031 Y:0030 S:06eb D:0000 DB:00 nvMXdiZC V:  2 H: 880
	sei                    ; A:0000 X:0031 Y:0030 S:06eb D:0000 DB:00 nvMXdiZC V:  2 H: 904
	phb                    ; A:0000 X:0031 Y:0030 S:06eb D:0000 DB:00 nvMXdIZC V:  2 H: 916
	lda #$7f               ; A:0000 X:0031 Y:0030 S:06ea D:0000 DB:00 nvMXdIZC V:  2 H: 936
	pha                    ; A:007f X:0031 Y:0030 S:06ea D:0000 DB:00 nvMXdIzC V:  2 H: 948
	plb                    ; A:007f X:0031 Y:0030 S:06e9 D:0000 DB:00 nvMXdIzC V:  2 H: 968
	jsr label_e04c     ; [dce04c] ; A:007f X:0031 Y:0030 S:06ea D:0000 DB:7f nvMXdIzC V:  2 H: 994
	jsr label_e093     ; [dce093] ; A:00dc X:0031 Y:0030 S:06ea D:0000 DB:7f nvMXdIzC V:  2 H:1336
	plb                    ; A:ff41 X:0014 Y:0001 S:06ea D:0000 DB:7f nvMXdIzC V:224 H:1134
	plp                    ; A:ff41 X:0014 Y:0001 S:06eb D:0000 DB:00 nvMXdIZC V:224 H:1160
	rts                    ; A:ff41 X:0014 Y:0001 S:06ec D:0000 DB:00 nvmxdiZC V:224 H:1186

label_e041:
	sep #$20
	rep #$10
	stz $4200
	jml $C00057

label_e04c:
	php                    ; A:007f X:0031 Y:0030 S:06e8 D:0000 DB:7f nvMXdIzC V:  2 H:1034
	sep #$30               ; A:007f X:0031 Y:0030 S:06e7 D:0000 DB:7f nvMXdIzC V:  2 H:1054
	lda #$63     ; #<label_dce063          ; A:007f X:0031 Y:0030 S:06e7 D:0000 DB:7f nvMXdIzC V:  2 H:1072
	sta.l $000505   ; [000505] ; A:0063 X:0031 Y:0030 S:06e7 D:0000 DB:7f nvMXdIzC V:  2 H:1084
	lda #$e0     ; #>label_dce063          ; A:0063 X:0031 Y:0030 S:06e7 D:0000 DB:7f nvMXdIzC V:  2 H:1116
	sta.l $000506   ; [000506] ; A:00e0 X:0031 Y:0030 S:06e7 D:0000 DB:7f NvMXdIzC V:  2 H:1194
	lda #$dc     ; #:label_dce063          ; A:00e0 X:0031 Y:0030 S:06e7 D:0000 DB:7f NvMXdIzC V:  2 H:1226
	sta.l $000507   ; [000507] ; A:00dc X:0031 Y:0030 S:06e7 D:0000 DB:7f NvMXdIzC V:  2 H:1238
	plp                    ; A:00dc X:0031 Y:0030 S:06e7 D:0000 DB:7f NvMXdIzC V:  2 H:1270
	rts                    ; A:00dc X:0031 Y:0030 S:06e8 D:0000 DB:7f nvMXdIzC V:  2 H:1296

label_dce063:
	rep #$30               ; A:0000 X:0000 Y:0001 S:06e6 D:0000 DB:7f nvMxdIZc V: 32 H: 594
	pha                    ; A:0000 X:0000 Y:0001 S:06e6 D:0000 DB:7f nvmxdIZc V: 32 H: 612
	phx                    ; A:0000 X:0000 Y:0001 S:06e4 D:0000 DB:7f nvmxdIZc V: 32 H: 640
	phy                    ; A:0000 X:0000 Y:0001 S:06e2 D:0000 DB:7f nvmxdIZc V: 32 H: 668
	phd                    ; A:0000 X:0000 Y:0001 S:06e0 D:0000 DB:7f nvmxdIZc V: 32 H: 696
	phb                    ; A:0000 X:0000 Y:0001 S:06de D:0000 DB:7f nvmxdIZc V: 32 H: 724
	lda #$0000             ; A:0000 X:0000 Y:0001 S:06dd D:0000 DB:7f nvmxdIZc V: 32 H: 744
	tcd                    ; A:0000 X:0000 Y:0001 S:06dd D:0000 DB:7f nvmxdIZc V: 32 H: 762
	jsr label_e317     ; [dce317] ; A:0000 X:0000 Y:0001 S:06dd D:0000 DB:7f nvmxdIZc V: 32 H: 774
	rep #$30               ; A:00c0 X:0002 Y:0001 S:06dd D:0000 DB:7f nvMXdIzc V: 33 H: 298
	plb                    ; A:00c0 X:0002 Y:0001 S:06dd D:0000 DB:7f nvmxdIzc V: 33 H: 316
	pld                    ; A:00c0 X:0002 Y:0001 S:06de D:0000 DB:7f nvmxdIzc V: 33 H: 342
	ply                    ; A:00c0 X:0002 Y:0001 S:06e0 D:0000 DB:7f nvmxdIZc V: 33 H: 376
	plx                    ; A:00c0 X:0002 Y:0001 S:06e2 D:0000 DB:7f nvmxdIzc V: 33 H: 410
	pla                    ; A:00c0 X:0000 Y:0001 S:06e4 D:0000 DB:7f nvmxdIZc V: 33 H: 444
	rti                    ; A:0000 X:0000 Y:0001 S:06e6 D:0000 DB:7f nvmxdIZc V: 33 H: 478

.ACCU 8
.INDEX 8

; label ??
	stz $4200				; supposedly unused code section with trap loop
	sei
	ldx #$00
	stx $2121
	lda #$AA
	sep #$20
-	sta $2122
	inx
	bne -
-	lda #$0F
	sta $2100
	bra -

label_e093:
	jsr label_e0a3     ; [dce0a3] ; A:00dc X:0031 Y:0030 S:06e8 D:0000 DB:7f nvMXdIzC V:  3 H:  12
	jsr label_e0d7     ; [dce0d7] ; A:00dc X:000a Y:0030 S:06e8 D:0000 DB:7f nvMXdIzC V:  3 H: 580
	jsr label_e104     ; [dce104] ; A:217a X:000a Y:0030 S:06e8 D:0000 DB:7f nvMXdIzC V:225 H: 290
	jsr label_e18d     ; [dce18d] ; A:ffff X:0014 Y:0001 S:06e8 D:0000 DB:7f nvMXdIzC V:224 H: 262
	jsr label_e4b2     ; [dce4b2] ; A:fff7 X:0014 Y:0001 S:06e8 D:0000 DB:7f nvMXdIzC V:224 H: 698
	rts                    ; A:ff41 X:0014 Y:0001 S:06e8 D:0000 DB:7f nvMXdIzC V:224 H:1094

label_e0a3:
	php                    ; A:00dc X:0031 Y:0030 S:06e6 D:0000 DB:7f nvMXdIzC V:  3 H:  52
	rep #$20               ; A:00dc X:0031 Y:0030 S:06e5 D:0000 DB:7f nvMXdIzC V:  3 H:  72
	sep #$10               ; A:00dc X:0031 Y:0030 S:06e5 D:0000 DB:7f nvmXdIzC V:  3 H:  90
	ldx #$00               ; A:00dc X:0031 Y:0030 S:06e5 D:0000 DB:7f nvmXdIzC V:  3 H: 108
	stz $ffe0     ; [7fffe0] ; A:00dc X:0000 Y:0030 S:06e5 D:0000 DB:7f nvmXdIZC V:  3 H: 120
	stx $ffe3     ; [7fffe3] ; A:00dc X:0000 Y:0030 S:06e5 D:0000 DB:7f nvmXdIZC V:  3 H: 154
	stx $ffe4     ; [7fffe4] ; A:00dc X:0000 Y:0030 S:06e5 D:0000 DB:7f nvmXdIZC V:  3 H: 180
	stx $ffe9     ; [7fffe9] ; A:00dc X:0000 Y:0030 S:06e5 D:0000 DB:7f nvmXdIZC V:  3 H: 206
	stx $ffe6     ; [7fffe6] ; A:00dc X:0000 Y:0030 S:06e5 D:0000 DB:7f nvmXdIZC V:  3 H: 232
	stx $ffef     ; [7fffef] ; A:00dc X:0000 Y:0030 S:06e5 D:0000 DB:7f nvmXdIZC V:  3 H: 258
	ldx #$ff               ; A:00dc X:0000 Y:0030 S:06e5 D:0000 DB:7f nvmXdIZC V:  3 H: 284
	stx $ffe2     ; [7fffe2] ; A:00dc X:00ff Y:0030 S:06e5 D:0000 DB:7f NvmXdIzC V:  3 H: 296
	ldx #$80               ; A:00dc X:00ff Y:0030 S:06e5 D:0000 DB:7f NvmXdIzC V:  3 H: 322
	stx $ffe7     ; [7fffe7] ; A:00dc X:0080 Y:0030 S:06e5 D:0000 DB:7f NvmXdIzC V:  3 H: 334
	ldx #$30               ; A:00dc X:0080 Y:0030 S:06e5 D:0000 DB:7f NvmXdIzC V:  3 H: 360
	stx $ffe8     ; [7fffe8] ; A:00dc X:0030 Y:0030 S:06e5 D:0000 DB:7f nvmXdIzC V:  3 H: 372
	ldx #$00               ; A:00dc X:0030 Y:0030 S:06e5 D:0000 DB:7f nvmXdIzC V:  3 H: 398
	stx $ffed     ; [7fffed] ; A:00dc X:0000 Y:0030 S:06e5 D:0000 DB:7f nvmXdIZC V:  3 H: 410
	ldx #$0a               ; A:00dc X:0000 Y:0030 S:06e5 D:0000 DB:7f nvmXdIZC V:  3 H: 436
	stx $ffee     ; [7fffee] ; A:00dc X:000a Y:0030 S:06e5 D:0000 DB:7f nvmXdIzC V:  3 H: 448
	plp                    ; A:00dc X:000a Y:0030 S:06e5 D:0000 DB:7f nvmXdIzC V:  3 H: 474
	rts                    ; A:00dc X:000a Y:0030 S:06e6 D:0000 DB:7f nvMXdIzC V:  3 H: 500

label_e0d7:
	php                    ; A:00dc X:000a Y:0030 S:06e6 D:0000 DB:7f nvMXdIzC V:  3 H: 620
	rep #$20               ; A:00dc X:000a Y:0030 S:06e5 D:0000 DB:7f nvMXdIzC V:  3 H: 640
	phd                    ; A:00dc X:000a Y:0030 S:06e5 D:0000 DB:7f nvmXdIzC V:  3 H: 658
	lda #$2100             ; A:00dc X:000a Y:0030 S:06e3 D:0000 DB:7f nvmXdIzC V:  3 H: 686
	tcd                    ; A:2100 X:000a Y:0030 S:06e3 D:0000 DB:7f nvmXdIzC V:  3 H: 704
	sep #$20               ; A:2100 X:000a Y:0030 S:06e3 D:2100 DB:7f nvmXdIzC V:  3 H: 716
	lda #$80               ; A:2100 X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:  3 H: 734
	sta $00       ; [002100] ; A:2180 X:000a Y:0030 S:06e3 D:2100 DB:7f NvMXdIzC V:  3 H: 746
	lda #$00               ; A:2180 X:000a Y:0030 S:06e3 D:2100 DB:7f NvMXdIzC V:  3 H: 764
	sta.l $00420c   ; [00420c] ; A:2100 X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIZC V:  3 H: 776

label_e0eb:
	lda.l $004210   ; [004210] ; A:2100 X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIZC V:  3 H: 806
	bpl label_e0eb     ; [dce0eb] ; A:2102 X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:  3 H: 836
	lda #$03               ; A:2182 X:000a Y:0030 S:06e3 D:2100 DB:7f NvMXdIzC V:225 H:  64
	sta $05       ; [002105] ; A:2103 X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:225 H:  76
	lda #$01               ; A:2103 X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:225 H:  94
	sta $2c       ; [00212c] ; A:2101 X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:225 H: 106
	stz $26       ; [002126] ; A:2101 X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:225 H: 124
	lda #$7a               ; A:2101 X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:225 H: 142
	sta $07       ; [002107] ; A:217a X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:225 H: 154
	stz $0b       ; [00210b] ; A:217a X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:225 H: 172
	pld                    ; A:217a X:000a Y:0030 S:06e3 D:2100 DB:7f nvMXdIzC V:225 H: 190
	plp                    ; A:217a X:000a Y:0030 S:06e5 D:0000 DB:7f nvMXdIZC V:225 H: 224
	rts                    ; A:217a X:000a Y:0030 S:06e6 D:0000 DB:7f nvMXdIzC V:225 H: 250

label_e104:
	php                    ; A:217a X:000a Y:0030 S:06e6 D:0000 DB:7f nvMXdIzC V:225 H: 330
	phb                    ; A:217a X:000a Y:0030 S:06e5 D:0000 DB:7f nvMXdIzC V:225 H: 350
	sep #$20               ; A:217a X:000a Y:0030 S:06e4 D:0000 DB:7f nvMXdIzC V:225 H: 370
	rep #$10               ; A:217a X:000a Y:0030 S:06e4 D:0000 DB:7f nvMXdIzC V:225 H: 388
	lda #$00               ; A:217a X:000a Y:0030 S:06e4 D:0000 DB:7f nvMxdIzC V:225 H: 406
	pha                    ; A:2100 X:000a Y:0030 S:06e4 D:0000 DB:7f nvMxdIZC V:225 H: 418
	plb                    ; A:2100 X:000a Y:0030 S:06e3 D:0000 DB:7f nvMxdIZC V:225 H: 438
	lda #$80               ; A:2100 X:000a Y:0030 S:06e4 D:0000 DB:00 nvMxdIZC V:225 H: 464
	sta $2115     ; [002115] ; A:2180 X:000a Y:0030 S:06e4 D:0000 DB:00 NvMxdIzC V:225 H: 476
	ldx #$0000             ; A:2180 X:000a Y:0030 S:06e4 D:0000 DB:00 NvMxdIzC V:225 H: 500
	stx $2116     ; [002116] ; A:2180 X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIZC V:225 H: 518
	lda #$09               ; A:2180 X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIZC V:225 H: 588
	sta $4300     ; [004300] ; A:2109 X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIzC V:225 H: 600
	lda #$18               ; A:2109 X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIzC V:225 H: 624
	sta $4301     ; [004301] ; A:2118 X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIzC V:225 H: 636
	ldx #$e18c  ; #label_e18c           ; A:2118 X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIzC V:225 H: 660
	stx $4302     ; [004302] ; A:2118 X:e18c Y:0030 S:06e4 D:0000 DB:00 NvMxdIzC V:225 H: 678
	lda #$dc    ; #:label_e18c           ; A:2118 X:e18c Y:0030 S:06e4 D:0000 DB:00 NvMxdIzC V:225 H: 708
	sta $4304     ; [004304] ; A:21dc X:e18c Y:0030 S:06e4 D:0000 DB:00 NvMxdIzC V:225 H: 720
	ldx #$0000             ; A:21dc X:e18c Y:0030 S:06e4 D:0000 DB:00 NvMxdIzC V:225 H: 744
	stx $4305     ; [004305] ; A:21dc X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIZC V:225 H: 762
	lda #$01               ; A:21dc X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIZC V:225 H: 792
	sta $420b     ; [00420b] ; A:2101 X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIzC V:225 H: 804
	phk                    ; A:2101 X:0000 Y:0030 S:06e4 D:0000 DB:00 nvMxdIzC V:225 H: 828
	plb                    ; A:2101 X:0000 Y:0030 S:06e3 D:0000 DB:00 nvMxdIzC V: 97 H: 858
	ldy #$7b00             ; A:2101 X:0000 Y:0030 S:06e4 D:0000 DB:dc NvMxdIzC V: 97 H: 884
	sty $00       ; [000000] ; A:2101 X:0000 Y:7b00 S:06e4 D:0000 DB:dc nvMxdIzC V: 97 H: 902
	ldx #$0002             ; A:2101 X:0000 Y:7b00 S:06e4 D:0000 DB:dc nvMxdIzC V: 97 H: 930
	rep #$20               ; A:2101 X:0002 Y:7b00 S:06e4 D:0000 DB:dc nvMxdIzC V: 97 H: 948
	lda.w label_e176     ; [dce176] ; A:2101 X:0002 Y:7b00 S:06e4 D:0000 DB:dc nvmxdIzC V: 97 H: 966

label_e148:
	ldy #$001e             ; A:0010 X:0002 Y:7b00 S:06e4 D:0000 DB:dc nvmxdIzC V: 97 H: 996
	pha                    ; A:0010 X:0002 Y:001e S:06e4 D:0000 DB:dc nvmxdIzC V: 97 H:1014
	lda $00       ; [000000] ; A:0010 X:0002 Y:001e S:06e2 D:0000 DB:dc nvmxdIzC V: 97 H:1042
	sta.l $002116   ; [002116] ; A:7b00 X:0002 Y:001e S:06e2 D:0000 DB:dc nvmxdIzC V: 97 H:1070
	clc                    ; A:7b00 X:0002 Y:001e S:06e2 D:0000 DB:dc nvmxdIzC V: 97 H:1106
	adc #$0020             ; A:7b00 X:0002 Y:001e S:06e2 D:0000 DB:dc nvmxdIzc V: 97 H:1118
	sta $00       ; [000000] ; A:7b20 X:0002 Y:001e S:06e2 D:0000 DB:dc nvmxdIzc V: 97 H:1136
	pla                    ; A:7b20 X:0002 Y:001e S:06e2 D:0000 DB:dc nvmxdIzc V: 97 H:1164

label_e159:
	sta.l $002118   ; [002118] ; A:0010 X:0002 Y:001e S:06e4 D:0000 DB:dc nvmxdIzc V: 97 H:1198
	cmp.w label_e176,x   ; [dce178] ; A:0010 X:0002 Y:001e S:06e4 D:0000 DB:dc nvmxdIzc V: 97 H:1234
	bne label_e16d     ; [dce16d] ; A:0010 X:0002 Y:001e S:06e4 D:0000 DB:dc NvmxdIzc V: 97 H:1270
	inx                    ; A:0257 X:0002 Y:0011 S:06e4 D:0000 DB:dc nvmxdIZC V:159 H: 176
	inx                    ; A:0257 X:0003 Y:0011 S:06e4 D:0000 DB:dc nvmxdIzC V:159 H: 188
	lda.w label_e176,x   ; [dce17a] ; A:0257 X:0004 Y:0011 S:06e4 D:0000 DB:dc nvmxdIzC V:159 H: 200
	bmi label_e173     ; [dce173] ; A:0000 X:0004 Y:0011 S:06e4 D:0000 DB:dc nvmxdIZC V:159 H: 236
	inx                    ; A:0000 X:0004 Y:0011 S:06e4 D:0000 DB:dc nvmxdIZC V:159 H: 248
	inx                    ; A:0000 X:0005 Y:0011 S:06e4 D:0000 DB:dc nvmxdIzC V:159 H: 260
	bra label_e16e     ; [dce16e] ; A:0000 X:0006 Y:0011 S:06e4 D:0000 DB:dc nvmxdIzC V:159 H: 272

label_e16d:
	inc a                    ; A:0010 X:0002 Y:001e S:06e4 D:0000 DB:dc NvmxdIzc V: 97 H:1288

label_e16e:
	dey                    ; A:0011 X:0002 Y:001e S:06e4 D:0000 DB:dc nvmxdIzc V: 97 H:1300
	bne label_e159     ; [dce159] ; A:0011 X:0002 Y:001d S:06e4 D:0000 DB:dc nvmxdIzc V: 97 H:1312
	bra label_e148     ; [dce148] ; A:002e X:0002 Y:0000 S:06e4 D:0000 DB:dc nvmxdIZc V:100 H:1180

label_e173:
	plb                    ; A:ffff X:0014 Y:0001 S:06e4 D:0000 DB:dc NVmxdIzC V:224 H: 170
	plp                    ; A:ffff X:0014 Y:0001 S:06e5 D:0000 DB:7f nVmxdIzC V:224 H: 196
	rts                    ; A:ffff X:0014 Y:0001 S:06e6 D:0000 DB:7f nvMXdIzC V:224 H: 222

label_e176:
	.DW $0010
	.DW $0257
	.DW $0000
	.DW $000F
	.DW $0258
	.DW $03D7
	.DW $0190
	.DW $0257
	.DW $0000
	.DW $000F
	.DW $FFFF

;label_e18c:
	.DB $00

label_e18d:
	php                    ; A:ffff X:0014 Y:0001 S:06e6 D:0000 DB:7f nvMXdIzC V:224 H: 302
	sep #$20               ; A:ffff X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 322
	lda #$20               ; A:ffff X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 340
	sta.l $002125   ; [002125] ; A:ff20 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 352
	lda #$20               ; A:ff20 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 382
	sta.l $002130   ; [002130] ; A:ff20 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 394
	lda #$bf               ; A:ff20 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 424
	sta.l $002131   ; [002131] ; A:ffbf X:0014 Y:0001 S:06e5 D:0000 DB:7f NvMXdIzC V:224 H: 436
	lda #$ff               ; A:ffbf X:0014 Y:0001 S:06e5 D:0000 DB:7f NvMXdIzC V:224 H: 466
	sta.l $002132   ; [002132] ; A:ffff X:0014 Y:0001 S:06e5 D:0000 DB:7f NvMXdIzC V:224 H: 478
	lda #$08               ; A:ffff X:0014 Y:0001 S:06e5 D:0000 DB:7f NvMXdIzC V:224 H: 508
	sta.l $002126   ; [002126] ; A:ff08 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 520
	lda #$f7               ; A:ff08 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 590
	sta.l $002127   ; [002127] ; A:fff7 X:0014 Y:0001 S:06e5 D:0000 DB:7f NvMXdIzC V:224 H: 602
	plp                    ; A:fff7 X:0014 Y:0001 S:06e5 D:0000 DB:7f NvMXdIzC V:224 H: 632
	rts                    ; A:fff7 X:0014 Y:0001 S:06e6 D:0000 DB:7f nvMXdIzC V:224 H: 658

label_e1b6:
	php                    ; A:ff41 X:0014 Y:0001 S:06ec D:0000 DB:00 nvmxdiZC V:224 H:1266
	sep #$20               ; A:ff41 X:0014 Y:0001 S:06eb D:0000 DB:00 nvmxdiZC V:224 H:1286
	phb                    ; A:ff41 X:0014 Y:0001 S:06eb D:0000 DB:00 nvMxdiZC V:224 H:1304
	lda #$7f               ; A:ff41 X:0014 Y:0001 S:06ea D:0000 DB:00 nvMxdiZC V:224 H:1324
	pha                    ; A:ff7f X:0014 Y:0001 S:06ea D:0000 DB:00 nvMxdizC V:224 H:1336
	plb                    ; A:ff7f X:0014 Y:0001 S:06e9 D:0000 DB:00 nvMxdizC V:224 H:1356
	jsr label_e4db     ; [dce4db] ; A:ff7f X:0014 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V:225 H:  18

label_e1c1:
	lda.l $004210   ; [004210] ; A:ff02 X:0014 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V:225 H: 456
	bpl label_e1c1     ; [dce1c1] ; A:ff82 X:0014 Y:0001 S:06ea D:0000 DB:7f NvMxdizC V:225 H: 486
	jsr label_e452     ; [dce452] ; A:ff82 X:0014 Y:0001 S:06ea D:0000 DB:7f NvMxdizC V:225 H: 498
	lda.l $004211   ; [004211] ; A:0020 X:0000 Y:0001 S:06ea D:0000 DB:7f NvMxdizC V:225 H: 902
	lda $ffe8     ; [7fffe8] ; A:0000 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZC V:225 H: 932
	ora #$01               ; A:0030 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V:225 H: 958
	sta.l $004200   ; [004200] ; A:0031 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V:225 H: 970
	cli                    ; A:0031 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V:225 H:1000
	lda #$0f               ; A:0031 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V:225 H:1012
	sta $ffe7     ; [7fffe7] ; A:000f X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V:225 H:1024

label_e1dd:
	lda $ffef     ; [7fffef] ; A:000f X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V:225 H:1050
	bne label_e1ec     ; [dce1ec] ; A:0000 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZC V:225 H:1076
	jsr label_e21e     ; [dce21e] ; A:0000 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZC V:225 H:1088
	bcc label_e1ec     ; [dce1ec] ; A:0000 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZc V:225 H:1314
	lda #$8f               ; A:0023 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZC V:  4 H: 524
	sta $ffef     ; [7fffef] ; A:008f X:0000 Y:0001 S:06ea D:0000 DB:7f NvMxdizC V:  4 H: 536

label_e1ec:
	stz $ffe4     ; [7fffe4] ; A:0000 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZc V:225 H:1332

label_e1ef:
	lda $ffe4     ; [7fffe4] ; A:0000 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZc V:225 H:1358
	beq label_e1ef     ; [dce1ef] ; A:0000 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZc V:226 H:  20
	lda $ffed     ; [7fffed] ; A:00ff X:0000 Y:0001 S:06ea D:0000 DB:7f NvMxdizc V:193 H: 720
	beq label_e1fe     ; [dce1fe] ; A:0000 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZc V:193 H: 746
	dec $ffed
	bra label_e1dd

label_e1fe:
	jsr label_e50a     ; [dce50a] ; A:0000 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZc V:193 H: 764
	bit $ffef     ; [7fffef] ; A:0003 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZc V:193 H:1046
	bpl label_e1dd     ; [dce1dd] ; A:0003 X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdiZc V:193 H:1072
	dec $ffef     ; [7fffef] ; A:0020 X:0000 Y:0001 S:06ea D:0000 DB:7f NvMxdiZC V: 20 H: 778
	bpl label_e218     ; [dce218] ; A:0020 X:0000 Y:0001 S:06ea D:0000 DB:7f NvMxdizC V: 20 H: 818
	lda $ffef     ; [7fffef] ; A:0020 X:0000 Y:0001 S:06ea D:0000 DB:7f NvMxdizC V: 20 H: 830
	and #$0f               ; A:008e X:0000 Y:0001 S:06ea D:0000 DB:7f NvMxdizC V: 20 H: 856
	sta $ffe7     ; [7fffe7] ; A:000e X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V: 20 H: 868
	jsr label_e53c     ; [dce53c] ; A:000e X:0000 Y:0001 S:06ea D:0000 DB:7f nvMxdizC V: 20 H: 894
	bra label_e1dd

label_e218:
	jsr label_e523
	plb
	plp
	rts

label_e21e:
	clc                    ; A:0000 X:0000 Y:0001 S:06e8 D:0000 DB:7f nvMxdiZC V:225 H:1128
	php                    ; A:0000 X:0000 Y:0001 S:06e8 D:0000 DB:7f nvMxdiZc V:225 H:1140
	rep #$20               ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZc V:225 H:1160
	lda $ffe0     ; [7fffe0] ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmxdiZc V:225 H:1178
	cmp #$0014             ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmxdiZc V:225 H:1212
	bcc label_e240     ; [dce240] ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f Nvmxdizc V:225 H:1230
	lda.l $004218   ; [004218] ; A:0014 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmxdiZC V: 20 H: 990
	bne label_e238     ; [dce238] ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmxdiZC V: 20 H:1026
	lda $ffe0     ; [7fffe0] ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmxdiZC V: 20 H:1038
	cmp #$0915             ; A:0014 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmxdizC V: 20 H:1072
	bne label_e240     ; [dce240] ; A:0014 X:0000 Y:0001 S:06e7 D:0000 DB:7f Nvmxdizc V: 20 H:1090

label_e238:
	sep #$20               ; A:0020 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmxdizC V:  4 H: 364
	lda $01,s     ; [0006e8] ; A:0020 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:  4 H: 382
	ora #$01               ; A:0022 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:  4 H: 408
	sta $01,s     ; [0006e8] ; A:0023 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:  4 H: 420

label_e240:
	plp                    ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f Nvmxdizc V:225 H:1248
	rts                    ; A:0000 X:0000 Y:0001 S:06e8 D:0000 DB:7f nvMxdiZc V:225 H:1274

label_e242:
	php                    ; A:0000 X:0000 Y:0001 S:06d7 D:0000 DB:7f nvMXdIZc V: 32 H:1260
	rep #$10               ; A:0000 X:0000 Y:0001 S:06d6 D:0000 DB:7f nvMXdIZc V: 32 H:1280
	sep #$20               ; A:0000 X:0000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 32 H:1298
	lda $ffe2     ; [7fffe2] ; A:0000 X:0000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 32 H:1316
	bmi label_e294     ; [dce294] ; A:00ff X:0000 Y:0001 S:06d6 D:0000 DB:7f NvMxdIzc V: 32 H:1342
	stz $ffea     ; [7fffea] ; A:0000 X:0000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 32 H:1356
	ldx #$c000             ; A:0000 X:0000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 33 H:  18
	stx $ffeb     ; [7fffeb] ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f NvMxdIzc V: 33 H:  36
	lda $ffe3     ; [7fffe3] ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f NvMxdIzc V: 33 H:  70
	asl a                  ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 33 H:  96
	clc                    ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 33 H: 108
	adc $ffe3     ; [7fffe3] ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 33 H: 120
	clc                    ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 33 H: 146
	adc $ffe2     ; [7fffe2] ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 33 H: 158
	rep #$20               ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvMxdIZc V: 33 H: 184
	and #$00ff             ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvmxdIZc V: 33 H: 202
	sta $00       ; [000000] ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvmxdIZc V: 33 H: 220
	asl a                  ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvmxdIZc V: 33 H: 248
	clc                    ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvmxdIZc V: 33 H: 260
	adc $00       ; [000000] ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvmxdIZc V: 33 H: 272
	asl a                  ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvmxdIZc V: 33 H: 300
	tax                    ; A:0000 X:c000 Y:0001 S:06d6 D:0000 DB:7f nvmxdIZc V: 33 H: 312
	lda.l label_dce2ba,x ; [dce2ba] ; A:0000 X:0000 Y:0001 S:06d6 D:0000 DB:7f nvmxdIZc V: 33 H: 324
	tay                    ; A:1900 X:0000 Y:0001 S:06d6 D:0000 DB:7f nvmxdIzc V: 33 H: 360
	lda.l label_dce296,x ; [dce296] ; A:1900 X:0000 Y:1900 S:06d6 D:0000 DB:7f nvmxdIzc V: 33 H: 372
	jsr label_e2de     ; [dce2de] ; A:0200 X:0000 Y:1900 S:06d6 D:0000 DB:7f nvmxdIzc V: 33 H: 408
	lda.l label_dce2bc,x ; [dce2bc] ; A:d900 X:0000 Y:1900 S:06d6 D:0000 DB:7f nvmxdIzc V: 72 H:1178
	tay                    ; A:1900 X:0000 Y:1900 S:06d6 D:0000 DB:7f nvmxdIzc V: 72 H:1214
	lda.l label_dce298,x ; [dce298] ; A:1900 X:0000 Y:1900 S:06d6 D:0000 DB:7f nvmxdIzc V: 72 H:1226
	jsr label_e2de     ; [dce2de] ; A:0e80 X:0000 Y:1900 S:06d6 D:0000 DB:7f nvmxdIzc V: 72 H:1262
	lda.l label_dce2be,x ; [dce2be] ; A:f200 X:0000 Y:1900 S:06d6 D:0000 DB:7f nvmxdIzc V:112 H: 674
	beq label_e294     ; [dce294] ; A:0000 X:0000 Y:1900 S:06d6 D:0000 DB:7f nvmxdIZc V:112 H: 710
	tay                    ; A:0400 X:000c Y:1900 S:06d6 D:0000 DB:7f nvmxdIzc V:112 H: 710
	lda.l label_dce29a,x ; [dce2a6] ; A:0400 X:000c Y:0400 S:06d6 D:0000 DB:7f nvmxdIzc V:112 H: 722
	jsr label_e2de     ; [dce2de] ; A:0000 X:000c Y:0400 S:06d6 D:0000 DB:7f nvmxdIZc V:112 H: 758

label_e294:
	plp                    ; A:00ff X:0000 Y:0001 S:06d6 D:0000 DB:7f NvMxdIzc V: 32 H:1360
	rts                    ; A:00ff X:0000 Y:0001 S:06d7 D:0000 DB:7f nvMXdIZc V: 33 H:  22

label_dce296:
	.DW $0200

label_dce298:
	.DW $0E80

label_dce29a:
	.DW $FFFF
	.DW $1B00
	.DW $2780
	.DW $FFFF
	.DW $3200
	.DW $3E80
	.DW $0000
	.DW $4B00
	.DW $5780
	.DW $FFFF
	.DW $6400
	.DW $7080
	.DW $FFFF
	.DW $3200
	.DW $3E80
	.DW $0000

label_dce2ba:
	.DW $1900

label_dce2bc:
	.DW $1900

label_dce2be:
	.DW $0000
	.DW $1900
	.DW $1500
	.DW $0000
	.DW $1900
	.DW $1900
	.DW $0400
	.DW $1900
	.DW $1900
	.DW $0000
	.DW $1900
	.DW $1500
	.DW $0000
	.DW $1900
	.DW $1900
	.DW $0400

label_e2de:
	php                    ; A:0200 X:0000 Y:1900 S:06d4 D:0000 DB:7f nvmxdIzc V: 33 H: 448
	phx                    ; A:0200 X:0000 Y:1900 S:06d3 D:0000 DB:7f nvmxdIzc V: 33 H: 468
	phy                    ; A:0200 X:0000 Y:1900 S:06d1 D:0000 DB:7f nvmxdIzc V: 33 H: 496
	sep #$10               ; A:0200 X:0000 Y:1900 S:06cf D:0000 DB:7f nvmxdIzc V: 33 H: 524
	ldx $ffea     ; [7fffea] ; A:0200 X:0000 Y:0000 S:06cf D:0000 DB:7f nvmXdIzc V: 33 H: 582
	sta $fff0,x   ; [7ffff0] ; A:0200 X:0000 Y:0000 S:06cf D:0000 DB:7f nvmXdIZc V: 33 H: 608
	lda $01,s     ; [0006d0] ; A:0200 X:0000 Y:0000 S:06cf D:0000 DB:7f nvmXdIZc V: 33 H: 648
	sta $fff2,x   ; [7ffff2] ; A:1900 X:0000 Y:0000 S:06cf D:0000 DB:7f nvmXdIzc V: 33 H: 682
	lda #$ffff             ; A:1900 X:0000 Y:0000 S:06cf D:0000 DB:7f nvmXdIzc V: 33 H: 722
	sta $fff4,x   ; [7ffff4] ; A:ffff X:0000 Y:0000 S:06cf D:0000 DB:7f NvmXdIzc V: 33 H: 740
	sep #$20               ; A:ffff X:0000 Y:0000 S:06cf D:0000 DB:7f NvmXdIzc V: 33 H: 780
	txa                    ; A:ffff X:0000 Y:0000 S:06cf D:0000 DB:7f NvMXdIzc V: 33 H: 798
	clc                    ; A:ff00 X:0000 Y:0000 S:06cf D:0000 DB:7f nvMXdIZc V: 33 H: 810
	adc #$04               ; A:ff00 X:0000 Y:0000 S:06cf D:0000 DB:7f nvMXdIZc V: 33 H: 822
	sta $7fffea   ; [7fffea] ; A:ff04 X:0000 Y:0000 S:06cf D:0000 DB:7f nvMXdIzc V: 33 H: 834
	rep #$30               ; A:ff04 X:0000 Y:0000 S:06cf D:0000 DB:7f nvMXdIzc V: 33 H: 866
	lda $01,s     ; [0006d0] ; A:ff04 X:0000 Y:0000 S:06cf D:0000 DB:7f nvmxdIzc V: 33 H: 884
	tay                    ; A:1900 X:0000 Y:0000 S:06cf D:0000 DB:7f nvmxdIzc V: 33 H: 918
	lda $ffeb     ; [7fffeb] ; A:1900 X:0000 Y:1900 S:06cf D:0000 DB:7f nvmxdIzc V: 33 H: 930
	ldx #$007f             ; A:c000 X:0000 Y:1900 S:06cf D:0000 DB:7f NvmxdIzc V: 33 H: 964
	jsr label_e48d     ; [dce48d] ; A:c000 X:007f Y:1900 S:06cf D:0000 DB:7f nvmxdIzc V: 33 H: 982
	pla                    ; A:1901 X:007f Y:1900 S:06cf D:0000 DB:7f nvmxdIzc V: 72 H: 964
	clc                    ; A:1900 X:007f Y:1900 S:06d1 D:0000 DB:7f nvmxdIzc V: 72 H: 998
	adc $ffeb     ; [7fffeb] ; A:1900 X:007f Y:1900 S:06d1 D:0000 DB:7f nvmxdIzc V: 72 H:1010
	sta $ffeb     ; [7fffeb] ; A:d900 X:007f Y:1900 S:06d1 D:0000 DB:7f NvmxdIzc V: 72 H:1044
	plx                    ; A:d900 X:007f Y:1900 S:06d1 D:0000 DB:7f NvmxdIzc V: 72 H:1078
	plp                    ; A:d900 X:0000 Y:1900 S:06d3 D:0000 DB:7f nvmxdIZc V: 72 H:1112
	rts                    ; A:d900 X:0000 Y:1900 S:06d4 D:0000 DB:7f nvmxdIzc V: 72 H:1138

label_e317:
	sep #$30               ; A:0000 X:0000 Y:0001 S:06db D:0000 DB:7f nvmxdIZc V: 32 H: 814
	lda.l $004211   ; [004211] ; A:0000 X:0000 Y:0001 S:06db D:0000 DB:7f nvMXdIZc V: 32 H: 832
	lda #$7f               ; A:0080 X:0000 Y:0001 S:06db D:0000 DB:7f NvMXdIzc V: 32 H: 862
	pha                    ; A:007f X:0000 Y:0001 S:06db D:0000 DB:7f nvMXdIzc V: 32 H: 874
	plb                    ; A:007f X:0000 Y:0001 S:06da D:0000 DB:7f nvMXdIzc V: 32 H: 894
	lda $ffe9     ; [7fffe9] ; A:007f X:0000 Y:0001 S:06db D:0000 DB:7f nvMXdIzc V: 32 H: 920
	asl a                  ; A:0000 X:0000 Y:0001 S:06db D:0000 DB:7f nvMXdIZc V: 32 H: 946
	tax                    ; A:0000 X:0000 Y:0001 S:06db D:0000 DB:7f nvMXdIZc V: 32 H: 958
	inc $ffe9     ; [7fffe9] ; A:0000 X:0000 Y:0001 S:06db D:0000 DB:7f nvMXdIZc V: 32 H: 970
	lda $ffe9     ; [7fffe9] ; A:0000 X:0000 Y:0001 S:06db D:0000 DB:7f nvMXdIzc V: 32 H:1010
	cmp #$02               ; A:0001 X:0000 Y:0001 S:06db D:0000 DB:7f nvMXdIzc V: 32 H:1036
	bne label_e333     ; [dce333] ; A:0001 X:0000 Y:0001 S:06db D:0000 DB:7f NvMXdIzc V: 32 H:1048
	stz $ffe9     ; [7fffe9] ; A:0002 X:0002 Y:0001 S:06db D:0000 DB:7f nvMXdIZC V:192 H:1076

label_e333:
	jsr (label_e33a,x) ; [dce33a] ; BSNES 0.058 DEBUGGER ERROR, indirect jump location is dce33e, not dce33a! A:0001 X:0000 Y:0001 S:06db D:0000 DB:7f NvMXdIzc V: 32 H:1066
	jsr label_e452     ; [dce452] ; A:000a X:0000 Y:0001 S:06db D:0000 DB:7f nvMXdIzc V: 32 H:1258
	rts                    ; A:00c0 X:0002 Y:0001 S:06db D:0000 DB:7f nvMXdIzc V: 33 H: 258

label_e33a:
	.DW label_e33e
	.DW label_e351

label_e33e:
	lda $ffe7     ; [7fffe7] ; A:0001 X:0000 Y:0001 S:06d9 D:0000 DB:7f NvMXdIzc V: 32 H:1118
	sta.l $002100   ; [002100] ; A:000f X:0000 Y:0001 S:06d9 D:0000 DB:7f nvMXdIzc V: 32 H:1144
	lda $ffee     ; [7fffee] ; A:000f X:0000 Y:0001 S:06d9 D:0000 DB:7f nvMXdIzc V: 32 H:1174
	bne label_e350     ; [dce350] ; A:000a X:0000 Y:0001 S:06d9 D:0000 DB:7f nvMXdIzc V: 32 H:1200
	jsr label_e242     ; [dce242] ; A:0000 X:0000 Y:0001 S:06d9 D:0000 DB:7f nvMXdIZc V: 32 H:1220
	jsr label_e40d     ; [dce40d] ; A:00ff X:0000 Y:0001 S:06d9 D:0000 DB:7f nvMXdIZc V: 33 H:  62

label_e350:
	rts                    ; A:000a X:0000 Y:0001 S:06d9 D:0000 DB:7f nvMXdIzc V: 32 H:1218

label_e351:
	lda #$80               ; A:0002 X:0002 Y:0001 S:06d9 D:0000 DB:7f nvMXdIZC V:192 H:1154
	sta.l $002100   ; [002100] ; A:0080 X:0002 Y:0001 S:06d9 D:0000 DB:7f NvMXdIzC V:192 H:1166
	lda $ffee     ; [7fffee] ; A:0080 X:0002 Y:0001 S:06d9 D:0000 DB:7f NvMXdIzC V:192 H:1196
	beq label_e363     ; [dce363] ; A:000a X:0002 Y:0001 S:06d9 D:0000 DB:7f nvMXdIzC V:192 H:1222
	dec $ffee     ; [7fffee] ; A:000a X:0002 Y:0001 S:06d9 D:0000 DB:7f nvMXdIzC V:192 H:1234
	dec $ffe4     ; [7fffe4] ; A:000a X:0002 Y:0001 S:06d9 D:0000 DB:7f nvMXdIzC V:192 H:1274
	rts                    ; A:000a X:0002 Y:0001 S:06d9 D:0000 DB:7f NvMXdIzC V:192 H:1314

label_e363:
	lda $ffe2     ; [7fffe2] ; A:0000 X:0002 Y:0001 S:06d9 D:0000 DB:7f nvMXdIZC V:192 H:1226
	bmi label_e36b     ; [dce36b] ; A:00ff X:0002 Y:0001 S:06d9 D:0000 DB:7f NvMXdIzC V:192 H:1252
	jsr label_e390     ; [dce390] ; A:0000 X:0002 Y:0001 S:06d9 D:0000 DB:7f nvMXdIZC V:192 H:1260

label_e36b:
	dec $ffe4     ; [7fffe4] ; A:00ff X:0002 Y:0001 S:06d9 D:0000 DB:7f NvMXdIzC V:192 H:1270
	inc $ffe2     ; [7fffe2] ; A:00ff X:0002 Y:0001 S:06d9 D:0000 DB:7f NvMXdIzC V:192 H:1310
	lda $ffe2     ; [7fffe2] ; A:00ff X:0002 Y:0001 S:06d9 D:0000 DB:7f nvMXdIZC V:192 H:1350
	cmp #$03               ; A:0000 X:0002 Y:0001 S:06d9 D:0000 DB:7f nvMXdIZC V:193 H:  12
	bcc label_e38f     ; [dce38f] ; A:0000 X:0002 Y:0001 S:06d9 D:0000 DB:7f NvMXdIzc V:193 H:  24
	lda #$ff               ; A:ff03 X:0002 Y:0000 S:06d9 D:0000 DB:7f nvMXdIZC V: 19 H: 442
	sta $ffe2     ; [7fffe2] ; A:ffff X:0002 Y:0000 S:06d9 D:0000 DB:7f NvMXdIzC V: 19 H: 454
	inc $ffe3     ; [7fffe3] ; A:ffff X:0002 Y:0000 S:06d9 D:0000 DB:7f NvMXdIzC V: 19 H: 480
	lda #$fe               ; A:ffff X:0002 Y:0000 S:06d9 D:0000 DB:7f nvMXdIzC V: 19 H: 520
	trb $ffe3     ; [7fffe3] ; A:fffe X:0002 Y:0000 S:06d9 D:0000 DB:7f NvMXdIzC V: 19 H: 532
	rep #$20               ; A:fffe X:0002 Y:0000 S:06d9 D:0000 DB:7f NvMXdIZC V: 19 H: 612
	inc $ffe0     ; [7fffe0] ; A:fffe X:0002 Y:0000 S:06d9 D:0000 DB:7f NvmXdIZC V: 19 H: 630
	sep #$20               ; A:fffe X:0002 Y:0000 S:06d9 D:0000 DB:7f nvmXdIzC V: 19 H: 686
	jsr label_e427     ; [dce427] ; A:fffe X:0002 Y:0000 S:06d9 D:0000 DB:7f nvMXdIzC V: 19 H: 704

label_e38f:
	rts                    ; A:0000 X:0002 Y:0001 S:06d9 D:0000 DB:7f NvMXdIzc V:193 H:  42

label_e390:
	php                    ; A:0000 X:0002 Y:0001 S:06d7 D:0000 DB:7f nvMXdIZC V:192 H:1300
	phd                    ; A:0000 X:0002 Y:0001 S:06d6 D:0000 DB:7f nvMXdIZC V:192 H:1320
	rep #$20               ; A:0000 X:0002 Y:0001 S:06d4 D:0000 DB:7f nvMXdIZC V:192 H:1348
	sep #$10               ; A:0000 X:0002 Y:0001 S:06d4 D:0000 DB:7f nvmXdIZC V:193 H:   2
	lda #$4300             ; A:0000 X:0002 Y:0001 S:06d4 D:0000 DB:7f nvmXdIZC V:193 H:  20
	tcd                    ; A:4300 X:0002 Y:0001 S:06d4 D:0000 DB:7f nvmXdIzC V:193 H:  38
	sep #$20               ; A:4300 X:0002 Y:0001 S:06d4 D:4300 DB:7f nvmXdIzC V:193 H:  50
	lda #$80               ; A:4300 X:0002 Y:0001 S:06d4 D:4300 DB:7f nvMXdIzC V:193 H:  68
	sta.l $002115   ; [002115] ; A:4380 X:0002 Y:0001 S:06d4 D:4300 DB:7f NvMXdIzC V:193 H:  80
	rep #$20               ; A:4380 X:0002 Y:0001 S:06d4 D:4300 DB:7f NvMXdIzC V:193 H: 110
	lda #$c000             ; A:4380 X:0002 Y:0001 S:06d4 D:4300 DB:7f NvmXdIzC V:193 H: 128
	sta $ffeb     ; [7fffeb] ; A:c000 X:0002 Y:0001 S:06d4 D:4300 DB:7f NvmXdIzC V:193 H: 146
	ldy #$01               ; A:c000 X:0002 Y:0001 S:06d4 D:4300 DB:7f NvmXdIzC V:193 H: 180
	sty $00       ; [004300] ; A:c000 X:0002 Y:0001 S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 192
	ldy #$18               ; A:c000 X:0002 Y:0001 S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 210
	sty $01       ; [004301] ; A:c000 X:0002 Y:0018 S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 222
	ldy #$7f               ; A:c000 X:0002 Y:0018 S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 240
	sty $04       ; [004304] ; A:c000 X:0002 Y:007f S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 252
	ldx #$00               ; A:c000 X:0002 Y:007f S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 270

label_e3b8:
	lda $fff0,x   ; [7ffff0] ; A:c000 X:0000 Y:007f S:06d4 D:4300 DB:7f nvmXdIZC V:193 H: 282
	bmi label_e3e3     ; [dce3e3] ; A:0200 X:0000 Y:007f S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 316
	sta.l $002116   ; [002116] ; A:0200 X:0000 Y:007f S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 328
	lda $fff2,x   ; [7ffff2] ; A:0200 X:0000 Y:007f S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 364
	sta $05       ; [004305] ; A:1900 X:0000 Y:007f S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 398
	lda $ffeb     ; [7fffeb] ; A:1900 X:0000 Y:007f S:06d4 D:4300 DB:7f nvmXdIzC V:193 H: 422
	sta $02       ; [004302] ; A:c000 X:0000 Y:007f S:06d4 D:4300 DB:7f NvmXdIzC V:193 H: 456
	clc                    ; A:c000 X:0000 Y:007f S:06d4 D:4300 DB:7f NvmXdIzC V:193 H: 480
	adc $fff2,x   ; [7ffff2] ; A:c000 X:0000 Y:007f S:06d4 D:4300 DB:7f NvmXdIzc V:193 H: 492
	sta $ffeb     ; [7fffeb] ; A:d900 X:0000 Y:007f S:06d4 D:4300 DB:7f NvmXdIzc V:193 H: 526
	sep #$20               ; A:d900 X:0000 Y:007f S:06d4 D:4300 DB:7f NvmXdIzc V:193 H: 600
	lda #$01               ; A:d900 X:0000 Y:007f S:06d4 D:4300 DB:7f NvMXdIzc V:193 H: 618
	sta.l $00420b   ; [00420b] ; A:d901 X:0000 Y:007f S:06d4 D:4300 DB:7f nvMXdIzc V:193 H: 630
	txa                    ; A:d901 X:0000 Y:007f S:06d4 D:4300 DB:7f nvMXdIzc V:193 H: 660
	clc                    ; A:d900 X:0000 Y:007f S:06d4 D:4300 DB:7f nvMXdIZc V:232 H: 224
	adc #$04               ; A:d900 X:0000 Y:007f S:06d4 D:4300 DB:7f nvMXdIZc V:232 H: 236
	tax                    ; A:d904 X:0000 Y:007f S:06d4 D:4300 DB:7f nvMXdIzc V:232 H: 248
	rep #$20               ; A:d904 X:0004 Y:007f S:06d4 D:4300 DB:7f nvMXdIzc V:232 H: 260
	bra label_e3b8     ; [dce3b8] ; A:d904 X:0004 Y:007f S:06d4 D:4300 DB:7f nvmXdIzc V:232 H: 278

label_e3e3:
	ldx $ffe2     ; [7fffe2] ; A:ffff X:0008 Y:007f S:06d4 D:4300 DB:7f NvmXdIzc V:  9 H: 360
	cpx #$02               ; A:ffff X:0000 Y:007f S:06d4 D:4300 DB:7f nvmXdIZc V:  9 H: 386
	bne label_e40a     ; [dce40a] ; A:ffff X:0000 Y:007f S:06d4 D:4300 DB:7f NvmXdIzc V:  9 H: 398
	sep #$20               ; A:ffff X:0002 Y:007f S:06d4 D:4300 DB:7f nvmXdIZC V: 15 H:1158
	rep #$10               ; A:ffff X:0002 Y:007f S:06d4 D:4300 DB:7f nvMXdIZC V: 15 H:1176
	lda #$00               ; A:ffff X:0002 Y:007f S:06d4 D:4300 DB:7f nvMxdIZC V: 15 H:1194
	sta.l $002121   ; [002121] ; A:ff00 X:0002 Y:007f S:06d4 D:4300 DB:7f nvMxdIZC V: 15 H:1206
	stz $00       ; [004300] ; A:ff00 X:0002 Y:007f S:06d4 D:4300 DB:7f nvMxdIZC V: 15 H:1236
	lda #$22               ; A:ff00 X:0002 Y:007f S:06d4 D:4300 DB:7f nvMxdIZC V: 15 H:1254
	sta $01       ; [004301] ; A:ff22 X:0002 Y:007f S:06d4 D:4300 DB:7f nvMxdIzC V: 15 H:1266
	ldy $ffeb     ; [7fffeb] ; A:ff22 X:0002 Y:007f S:06d4 D:4300 DB:7f nvMxdIzC V: 15 H:1284
	sty $02       ; [004302] ; A:ff22 X:0002 Y:f600 S:06d4 D:4300 DB:7f NvMxdIzC V: 15 H:1318
	ldy #$0200             ; A:ff22 X:0002 Y:f600 S:06d4 D:4300 DB:7f NvMxdIzC V: 15 H:1342
	sty $05       ; [004305] ; A:ff22 X:0002 Y:0200 S:06d4 D:4300 DB:7f nvMxdIzC V: 15 H:1360
	lda #$01               ; A:ff22 X:0002 Y:0200 S:06d4 D:4300 DB:7f nvMxdIzC V: 16 H:  20
	sta.l $00420b   ; [00420b] ; A:ff01 X:0002 Y:0200 S:06d4 D:4300 DB:7f nvMxdIzC V: 16 H:  32

label_e40a:
	pld                    ; A:ffff X:0000 Y:007f S:06d4 D:4300 DB:7f NvmXdIzc V:  9 H: 416
	plp                    ; A:ffff X:0000 Y:007f S:06d6 D:0000 DB:7f nvmXdIZc V:  9 H: 450
	rts                    ; A:ffff X:0000 Y:007f S:06d7 D:0000 DB:7f nvMXdIZC V:  9 H: 476

label_e40d:
	php                    ; A:00ff X:0000 Y:0001 S:06d7 D:0000 DB:7f nvMXdIZc V: 33 H: 102
	sep #$20               ; A:00ff X:0000 Y:0001 S:06d6 D:0000 DB:7f nvMXdIZc V: 33 H: 122
	lda $ffe2     ; [7fffe2] ; A:00ff X:0000 Y:0001 S:06d6 D:0000 DB:7f nvMXdIZc V: 33 H: 140
	cmp #$02               ; A:00ff X:0000 Y:0001 S:06d6 D:0000 DB:7f NvMXdIzc V: 33 H: 166
	bne label_e425     ; [dce425] ; A:00ff X:0000 Y:0001 S:06d6 D:0000 DB:7f NvMXdIzC V: 33 H: 178
	rep #$30               ; A:f602 X:000c Y:0000 S:06d6 D:0000 DB:7f nvMXdIZC V:119 H:1042
	lda $ffeb     ; [7fffeb] ; A:f602 X:000c Y:0000 S:06d6 D:0000 DB:7f nvmxdIZC V:119 H:1060
	ldx #$007f             ; A:f600 X:000c Y:0000 S:06d6 D:0000 DB:7f NvmxdIzC V:119 H:1094
	ldy #$0200             ; A:f600 X:007f Y:0000 S:06d6 D:0000 DB:7f nvmxdIzC V:119 H:1112
	jsr label_e48d     ; [dce48d] ; A:f600 X:007f Y:0200 S:06d6 D:0000 DB:7f nvmxdIzC V:119 H:1130

label_e425:
	plp                    ; A:00ff X:0000 Y:0001 S:06d6 D:0000 DB:7f NvMXdIzC V: 33 H: 196
	rts                    ; A:00ff X:0000 Y:0001 S:06d7 D:0000 DB:7f nvMXdIZc V: 33 H: 222

label_e427:
	php                    ; A:fffe X:0002 Y:0000 S:06d7 D:0000 DB:7f nvMXdIzC V: 19 H: 744
	sep #$30               ; A:fffe X:0002 Y:0000 S:06d6 D:0000 DB:7f nvMXdIzC V: 19 H: 764
	lda #$f8               ; A:fffe X:0002 Y:0000 S:06d6 D:0000 DB:7f nvMXdIzC V: 19 H: 782
	sta.l $00210d   ; [00210d] ; A:fff8 X:0002 Y:0000 S:06d6 D:0000 DB:7f NvMXdIzC V: 19 H: 794
	lda #$ff               ; A:fff8 X:0002 Y:0000 S:06d6 D:0000 DB:7f NvMXdIzC V: 19 H: 824
	sta.l $00210d   ; [00210d] ; A:ffff X:0002 Y:0000 S:06d6 D:0000 DB:7f NvMXdIzC V: 19 H: 836
	lda $7fffe3   ; [7fffe3] ; A:ffff X:0002 Y:0000 S:06d6 D:0000 DB:7f NvMXdIzC V: 19 H: 866
	asl a                  ; A:ff01 X:0002 Y:0000 S:06d6 D:0000 DB:7f nvMXdIzC V: 19 H: 898
	tax                    ; A:ff02 X:0002 Y:0000 S:06d6 D:0000 DB:7f nvMXdIzc V: 19 H: 910
	lda.l label_dce44e,x ; [dce450] ; A:ff02 X:0002 Y:0000 S:06d6 D:0000 DB:7f nvMXdIzc V: 19 H: 922
	sta.l $00210e   ; [00210e] ; A:ff9f X:0002 Y:0000 S:06d6 D:0000 DB:7f NvMXdIzc V: 19 H: 952
	lda.l label_dce44f,x ; [dce451] ; A:ff9f X:0002 Y:0000 S:06d6 D:0000 DB:7f NvMXdIzc V: 19 H: 982
	sta.l $00210e   ; [00210e] ; A:ff00 X:0002 Y:0000 S:06d6 D:0000 DB:7f nvMXdIZc V: 19 H:1012
	plp                    ; A:ff00 X:0002 Y:0000 S:06d6 D:0000 DB:7f nvMXdIZc V: 19 H:1042
	rts                    ; A:ff00 X:0002 Y:0000 S:06d7 D:0000 DB:7f nvMXdIzC V: 19 H:1068

label_dce44e:
	.DB $3F

label_dce44f:
	.DB $01
	.DB $9F
	.DB $00

label_e452:
	php                    ; A:ff82 X:0014 Y:0001 S:06e8 D:0000 DB:7f NvMxdizC V:225 H: 538
	rep #$20               ; A:ff82 X:0014 Y:0001 S:06e7 D:0000 DB:7f NvMxdizC V:225 H: 598
	sep #$10               ; A:ff82 X:0014 Y:0001 S:06e7 D:0000 DB:7f NvmxdizC V:225 H: 616
	lda #$0064             ; A:ff82 X:0014 Y:0001 S:06e7 D:0000 DB:7f NvmXdizC V:225 H: 634
	sta.l $004207   ; [004207] ; A:0064 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvmXdizC V:225 H: 652
	lda $ffe9     ; [7fffe9] ; A:0064 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvmXdizC V:225 H: 688
	and #$00ff             ; A:5500 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvmXdizC V:225 H: 722
	asl a                  ; A:0000 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvmXdiZC V:225 H: 740
	tax                    ; A:0000 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvmXdiZc V:225 H: 752
	lda.l label_dce470,x ; [dce470] ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmXdiZc V:225 H: 764
	sta.l $004209   ; [004209] ; A:0020 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmXdizc V:225 H: 800
	plp                    ; A:0020 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvmXdizc V:225 H: 836
	rts                    ; A:0020 X:0000 Y:0001 S:06e8 D:0000 DB:7f NvMxdizC V:225 H: 862

label_dce470:
	.DB $20
	.DB $00
	.DB $C0
	.DB $00

; label ??
	php					; unused code snippet (?)
	sep #$20
	lda #$00
	sta.l $002121
	lda $ffe0
	sta.l $002122
	lda $ffe1
	sta.l $002122
	plp
	rts

.ACCU 16

label_e48d:
	php                    ; A:c000 X:007f Y:1900 S:06cd D:0000 DB:7f nvmxdIzc V: 33 H:1022
	sta.l $004302   ; [004302] ; A:c000 X:007f Y:1900 S:06cc D:0000 DB:7f nvmxdIzc V: 33 H:1042
	tya                    ; A:c000 X:007f Y:1900 S:06cc D:0000 DB:7f nvmxdIzc V: 33 H:1078
	sta.l $004305   ; [004305] ; A:1900 X:007f Y:1900 S:06cc D:0000 DB:7f nvmxdIzc V: 33 H:1090
	sep #$20               ; A:1900 X:007f Y:1900 S:06cc D:0000 DB:7f nvmxdIzc V: 33 H:1126
	txa                    ; A:1900 X:007f Y:1900 S:06cc D:0000 DB:7f nvMxdIzc V: 33 H:1144
	sta.l $004304   ; [004304] ; A:197f X:007f Y:1900 S:06cc D:0000 DB:7f nvMxdIzc V: 33 H:1156
	lda #$80               ; A:197f X:007f Y:1900 S:06cc D:0000 DB:7f nvMxdIzc V: 33 H:1186
	sta.l $004300   ; [004300] ; A:1980 X:007f Y:1900 S:06cc D:0000 DB:7f NvMxdIzc V: 33 H:1198
	lda #$f2               ; A:1980 X:007f Y:1900 S:06cc D:0000 DB:7f NvMxdIzc V: 33 H:1228
	sta.l $004301   ; [004301] ; A:19f2 X:007f Y:1900 S:06cc D:0000 DB:7f NvMxdIzc V: 33 H:1240
	lda #$01               ; A:19f2 X:007f Y:1900 S:06cc D:0000 DB:7f NvMxdIzc V: 33 H:1270
	sta.l $00420b   ; [00420b] ; A:1901 X:007f Y:1900 S:06cc D:0000 DB:7f nvMxdIzc V: 33 H:1282
	plp                    ; A:1901 X:007f Y:1900 S:06cc D:0000 DB:7f nvMxdIzc V: 33 H:1312
	rts                    ; A:1901 X:007f Y:1900 S:06cd D:0000 DB:7f nvmxdIzc V: 72 H: 924

label_e4b2:
	php                    ; A:fff7 X:0014 Y:0001 S:06e6 D:0000 DB:7f nvMXdIzC V:224 H: 738
	sep #$20               ; A:fff7 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 758
	lda #$00               ; A:fff7 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H: 776
	sta.l $0021f1   ; [0021f1] ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 788
	lda #$00               ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 818
	sta.l $0021f1   ; [0021f1] ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 830
	lda #$00               ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 860
	sta.l $0021f1   ; [0021f1] ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 872
	lda #$00               ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 902
	sta.l $0021f1   ; [0021f1] ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 914
	lda #$00               ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 944
	sta.l $0021f0   ; [0021f0] ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 956

label_e4d3:
	lda.l $0021f0   ; [0021f0] ; A:ff00 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIZC V:224 H: 986
	bmi label_e4d3     ; [dce4d3] ; A:ff41 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H:1016
	plp                    ; A:ff41 X:0014 Y:0001 S:06e5 D:0000 DB:7f nvMXdIzC V:224 H:1028
	rts                    ; A:ff41 X:0014 Y:0001 S:06e6 D:0000 DB:7f nvMXdIzC V:224 H:1054

label_e4db:
	php                    ; A:ff7f X:0014 Y:0001 S:06e8 D:0000 DB:7f nvMxdizC V:225 H:  58
	sep #$20               ; A:ff7f X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:225 H:  78
	lda #$00               ; A:ff7f X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:225 H:  96
	sta.l $0021f1   ; [0021f1] ; A:ff00 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZC V:225 H: 108
	lda #$00               ; A:ff00 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZC V:225 H: 138
	sta.l $0021f1   ; [0021f1] ; A:ff00 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZC V:225 H: 150
	lda #$01               ; A:ff00 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZC V:225 H: 180
	sta.l $0021f0   ; [0021f0] ; A:ff01 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:225 H: 192

label_e4f0:
	lda.l $0021f0   ; [0021f0] ; A:ff01 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:225 H: 222
	and #$40               ; A:ff01 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:225 H: 252
	bne label_e4f0     ; [dce4f0] ; A:ff00 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZC V:225 H: 264
	lda #$ff               ; A:ff00 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZC V:225 H: 276
	sta.l $0021f1   ; [0021f1] ; A:ffff X:0014 Y:0001 S:06e7 D:0000 DB:7f NvMxdizC V:225 H: 288
	sta.l $0021f1   ; [0021f1] ; A:ffff X:0014 Y:0001 S:06e7 D:0000 DB:7f NvMxdizC V:225 H: 318
	lda #$02               ; A:ffff X:0014 Y:0001 S:06e7 D:0000 DB:7f NvMxdizC V:225 H: 348
	sta.l $0021f0   ; [0021f0] ; A:ff02 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:225 H: 360
	plp                    ; A:ff02 X:0014 Y:0001 S:06e7 D:0000 DB:7f nvMxdizC V:225 H: 390
	rts                    ; A:ff02 X:0014 Y:0001 S:06e8 D:0000 DB:7f nvMxdizC V:225 H: 416

label_e50a:
	php                    ; A:0000 X:0000 Y:0001 S:06e8 D:0000 DB:7f nvMxdiZc V:193 H: 804
	sep #$20               ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZc V:193 H: 824
	lda.l $0021f0   ; [0021f0] ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZc V:193 H: 842
	and #$20               ; A:0001 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdizc V:193 H: 872
	bne label_e521     ; [dce521] ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZc V:193 H: 884
	lda #$00               ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZc V:193 H: 896
	sta.l $0021f1   ; [0021f1] ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZc V:193 H: 908
	lda #$03               ; A:0000 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdiZc V:193 H: 938
	sta.l $0021f0   ; [0021f0] ; A:0003 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdizc V:193 H: 950

label_e521:
	plp                    ; A:0003 X:0000 Y:0001 S:06e7 D:0000 DB:7f nvMxdizc V:193 H: 980
	rts                    ; A:0003 X:0000 Y:0001 S:06e8 D:0000 DB:7f nvMxdiZc V:193 H:1006

label_e523:
	php
	sep #$20
	lda.l $0021F0
	and #$20
	beq +
	lda #$02
	sta.l $0021F1
	lda #$03
	sta.l $0021F0
+	plp
	rts

label_e53c:
	asl a                  ; A:000e X:0000 Y:0001 S:06e8 D:0000 DB:7f nvMxdizC V: 20 H: 934
	asl a                  ; A:001c X:0000 Y:0001 S:06e8 D:0000 DB:7f nvMxdizc V: 20 H: 946
	asl a                  ; A:0038 X:0000 Y:0001 S:06e8 D:0000 DB:7f nvMxdizc V: 20 H: 958
	asl a                  ; A:0070 X:0000 Y:0001 S:06e8 D:0000 DB:7f nvMxdizc V: 20 H: 970
	sta.l $0021f1   ; [0021f1] ; A:00e0 X:0000 Y:0001 S:06e8 D:0000 DB:7f NvMxdizc V: 20 H: 982
	sta.l $0021f1   ; [0021f1] ; A:00e0 X:0000 Y:0001 S:06e8 D:0000 DB:7f NvMxdizc V: 20 H:1012
	lda #$02
	sta.l $0021f0
	rts

.ENDS



; ******************************** EOF *********************************
