//***********************************************************************************
//
// CT anime intro for 21fx (MSU1) hack by smkdan, (c) 2011
// Disassembled, edited for re-assembly, and ported to MSU1 by ManuLöwe, (c) 2015
// Converted to bass v14 syntax by qwertymodo, (c) 2016
//
// Assembling this file using a vanilla Chrono Trigger ROM image will yield a ROM
// that can be played on higan v094 or using an sd2snes. :-)
//
//***********************************************************************************



// ************************* Source ROM layout **************************

arch snes.cpu

macro seek(variable offset) {
  origin (offset & $3FFFFF)
  base offset
}



// *************************** MSU1 registers ***************************

    define MSU_STATUS($002000)
    define MSU_READ($002001)
    define MSU_ID($002002)
    define MSU_SEEK($002000)
    define MSU_TRACK($002004)
    define MSU_VOLUME($002006)
    define MSU_CONTROL($002007)

    define var_ffe0($ffe0)
    define var_ffe1($ffe1)
    define var_ffe2($ffe2)
    define var_ffe3($ffe3)
    define var_ffe4($ffe4)
    define var_ffe6($ffe6)
    define var_ffe7($ffe7)
    define var_ffe8($ffe8)
    define var_ffe9($ffe9)
    define var_ffea($ffea)
//    define var_ffeb($ffeb)
    define var_ffed($ffed)
    define var_ffee($ffee)
    define var_ffef($ffef)

    define var_fff0($fff0)
    define var_fff2($fff2)
    define var_fff4($fff4)



// ******************************** Code ********************************

seek($C0FF03)               // ROM location $00FF03
    jml label_dce000


seek($C70140)               // ROM location $070140
    jml label_dce004


seek($DCE000)               // ROM location $1CE000
//msu1_code:
label_dce000:
    jml $fdc000

label_dce004:
    phb
    phd
    php
    rep #$30
    cpx #$0131
    bne NoMSU1
    cpy #$0130
    bne NoMSU1

    sep #$20                // A = 8 bit

    lda.l {MSU_ID}          // check if MSU1 hardware present
    cmp.b #'S'
    bne NoMSU1

    lda.l {MSU_ID}+1
    cmp.b #'-'
    bne NoMSU1

    lda.l {MSU_ID}+2
    cmp.b #'M'
    bne NoMSU1

    lda.l {MSU_ID}+3
    cmp.b #'S'
    bne NoMSU1

    lda.l {MSU_ID}+4
    cmp.b #'U'
    bne NoMSU1

    lda.l {MSU_ID}+5
    cmp.b #'1'
    bne NoMSU1

    rep #$20                // A = 8 bit

    lda #$0000              // MSU1 present, begin initialization
    tcd

    sep #$30
    stz $4200               // disable NMI/IRQ
    sei
    phb

    lda #$7f
    pha
    plb                     // data bank = $7F

    jsr SetInterruptRoutine
    jsr InitVariables
    jsr InitRegs
    jsr InitVRAM
    jsr InitMoreRegs
    jsr InitMSU1DataPort

    plb

    jsr label_e1b6

    sep #$20                // resume game
    rep #$10
    stz $4200
    jml $C00057

NoMSU1:
    rep #$20                // no MSU1, go to normal intro
    jml $c70145

SetInterruptRoutine:
    php
    sep #$30
    lda.b #$94              // lda #<Interrupt         // set 24-bit address of interrupt routine
    sta.l $000505
    lda.b #$E0              // lda #>Interrupt
    sta.l $000506
    lda.b #$DC              // lda #:Interrupt
    sta.l $000507
    plp
rts



Interrupt:                  // interrupt routine
    rep #$30
    pha
    phx
    phy
    phd
    phb
    lda #$0000
    tcd
    jsr label_e317
    rep #$30
    plb
    pld
    ply
    plx
    pla
rti



//.ACCU 8
//.INDEX 8

// label ??
//    stz $4200                // supposedly unused code section with trap loop
//    sei
//    ldx #$00
//    stx $2121
//    lda #$AA
//    sep #$20
//-;  sta $2122
//    inx
//    bne -
//-;  lda #$0F
//    sta $2100
//    bra -

seek($DCE0AA)
InitVariables:
    php
    rep #$20
    sep #$10
    ldx #$00
    stz {var_ffe0}
    stx {var_ffe3}
    stx {var_ffe4}
    stx {var_ffe9}
    stx {var_ffe6}
    stx {var_ffef}
    ldx #$ff
    stx {var_ffe2}
    ldx #$80
    stx {var_ffe7}
    ldx #$30
    stx {var_ffe8}
    ldx #$00
    stx {var_ffed}
    ldx #$0a
    stx {var_ffee}
    plp
rts



InitRegs:
    php
    rep #$20
    phd
    lda #$2100
    tcd                     // DP = $2100
    sep #$20
    lda #$80
    sta $00                 // screen off
    lda #$00
    sta.l $00420c           // HDMA disabled

-;  lda.l $004210
    bpl -
    lda #$03
    sta $05                 // BG mode 3 set
    lda #$01
    sta $2c                 // BG1 on main screen enabled
    stz $26                 // no window
    lda #$7a
    sta $07                 // BG1 screen base address = $7800, size = 2 screens (H-mirror)
    stz $0b                 // BG1 character data address = $0000
    pld
    plp
rts



InitVRAM:
    php
    phb
    sep #$20
    rep #$10
    lda #$00
    pha
    plb
    lda #$80
    sta $2115
    ldx #$0000
    stx $2116
    lda #$09
    sta $4300
    lda #$18
    sta $4301
    ldx #Zero
    stx $4302
    lda #$DC
    sta $4304
    ldx #$0000
    stx $4305
    lda #$01
    sta $420b               // this DMA clears the VRAM

    phk
    plb                     // data bank = program bank

// ---- build BG1 tilemap
    ldy #$7b00              // set VRAM start address to BG1 tilemap ($7A00) + $100 tiles (upper black border)
    sty $00
    ldx #$0002
    rep #$20
    lda.w table_BG1tilemap  // read tilemap entry

-;  ldy #$001e              // 30 tiles (window clips 1 tile on either side)
    pha
    lda $00
    sta.l $002116           // set current tilemap address
    clc
    adc #$0020              // increment by 32 tiles for next iteration
    sta $00
    pla

-;  sta.l $002118           // write tilemap entry
    cmp.w table_BG1tilemap,x// final value to write reached?
    bne +
    inx                     // increment to next table entry for writing to VRAM
    inx
    lda.w table_BG1tilemap,x
    bmi __InitVRAMdone      // last table entry reached?
    inx                     // increment to next table entry for comparison
    inx
    bra ++

+;  inc                     // increment tilemap entry value

+;  dey
    bne -                   // 30 tiles done?
    bra --                  // yes, do next row

__InitVRAMdone:
    plb
    plp
rts



table_BG1tilemap:           // there are 2 screens (H-mirror), so the tilemap size is 2048, 1195 of which are written to
    dw $0010
    dw $0257                // $257-$10 = 583 tiles
    dw $0000
    dw $000F                // $F-$0 = 15 tiles
    dw $0258
    dw $03D7                // $3D7-$258 = 383 tiles
    dw $0190
    dw $0257                // $257-$190 = 199 tiles
    dw $0000
    dw $000F                // $F-$0 = 15 tiles
    dw $FFFF



Zero:
    db $00



InitMoreRegs:
    php
    sep #$20
    lda #$20
    sta.l $002125           // window sprite/math settings
    lda #$20
    sta.l $002130           // color math control A
    lda #$bf
    sta.l $002131           // color math control B
    lda #$ff
    sta.l $002132           // COLDATA
    lda #$08                // set movie window
    sta.l $002126
    lda #$f7
    sta.l $002127
    plp
rts



label_e1b6:
    php
    sep #$20
    phb

    lda #$7f
    pha
    plb                     // data bank = $7F

    jsr SetAudioTrackAndVol

-;  lda.l $004210           // wait for Vblank
    bpl -

    jsr SetHVTimer
    lda.l $004211
    lda {var_ffe8}          // #$30
    ora #$01
    sta.l $004200           // enable H/V IRQ 
    cli
    lda #$0f
    sta {var_ffe7}          // set screen brightness

label_e1dd:
    lda {var_ffef}
    bne label_e1ec
    jsr label_e21e
    bcc label_e1ec
    lda #$8f
    sta {var_ffef}

label_e1ec:
    stz {var_ffe4}

-;  lda {var_ffe4}          // wait for ###
    beq -
    lda {var_ffed}
    beq +
    dec {var_ffed}
    bra label_e1dd

+;  jsr StartAudio
    bit {var_ffef}
    bpl label_e1dd
    dec {var_ffef}
    bpl +
    lda {var_ffef}
    and #$0f
    sta {var_ffe7}
    jsr SetAudioVolume
    bra label_e1dd

+;  jsr StopAudio
    plb
    plp
rts



label_e21e:
    clc
    php
    rep #$20
    lda {var_ffe0}
    cmp #$0014
    bcc ++
    lda.l $004218           // JOY1L
    bne +
    lda {var_ffe0}
    cmp #$0915
    bne ++

+;  sep #$20
    lda $01,s
    ora #$01
    sta $01,s

+;  plp
rts



label_e242:
    php
    rep #$10
    sep #$20
    lda {var_ffe2}
    bmi +
    stz {var_ffea}
//    ldx #$c000
//    stx {var_ffeb}
    lda {var_ffe3}
    asl
    clc
    adc {var_ffe3}
    clc
    adc {var_ffe2}
    rep #$20
    and #$00ff
    sta $00
    asl
    clc
    adc $00
    asl
    tax
    lda.l label_dce2ba,x
    tay
    lda.l label_dce296,x
    jsr label_e2de
    lda.l label_dce2bc,x
    tay
    lda.l label_dce298,x
    jsr label_e2de
    lda.l label_dce2be,x
    beq +
    tay
    lda.l label_dce29a,x
    jsr label_e2de

+;  plp
rts



label_dce296:
    dw $0200

label_dce298:
    dw $0E80

label_dce29a:
    dw $FFFF
    dw $1B00
    dw $2780
    dw $FFFF
    dw $3200
    dw $3E80
    dw $0000
    dw $4B00
    dw $5780
    dw $FFFF
    dw $6400
    dw $7080
    dw $FFFF
    dw $3200
    dw $3E80
    dw $0000

label_dce2ba:
    dw $1900

label_dce2bc:
    dw $1900

label_dce2be:
    dw $0000
    dw $1900
    dw $1500
    dw $0000
    dw $1900
    dw $1900
    dw $0400
    dw $1900
    dw $1900
    dw $0000
    dw $1900
    dw $1500
    dw $0000
    dw $1900
    dw $1900
    dw $0400

label_e2de:
    php
    phx
    phy
    sep #$10
    ldx {var_ffea}
    sta {var_fff0},x
    lda $01,s
    sta {var_fff2},x
    lda #$ffff
    sta {var_fff4},x
    sep #$20
    txa
    clc
    adc #$04
    sta $7fffea
    rep #$30
//    lda $01,s
//    tay
//    lda {var_ffeb}
//    ldx #$007f
//    jsr label_e48d
    pla
//    clc
//    adc {var_ffeb}
//    sta {var_ffeb}
    plx
    plp
rts



label_e317:
    sep #$30
    lda.l $004211
    lda #$7f
    pha
    plb                     // data bank = $7F
    lda {var_ffe9}
    asl
    tax
    inc {var_ffe9}
    lda {var_ffe9}
    cmp #$02
    bne +
    stz {var_ffe9}

+;  jsr (label_e33a,x)
    jsr SetHVTimer
rts



label_e33a:
    dw label_e33e           // build WRAM buffer
    dw label_e351           // read WRAM buffer

label_e33e:
    lda {var_ffe7}
    sta.l $002100
    lda {var_ffee}
    bne +
    jsr label_e242          // these two fill the WRAM buffer
//    jsr label_e40d

+
rts



label_e351:
    lda #$80
    sta.l $002100           // enter Forced blank
    lda {var_ffee}
    beq +
    dec {var_ffee}
    dec {var_ffe4}
rts



+;  lda {var_ffe2}
    bmi +
//    jsr label_e390          // this one transfers WRAM buffer content to VRAM/CGRAM
    jsr StreamMSU1Data

+;  dec {var_ffe4}
    inc {var_ffe2}
    lda {var_ffe2}
    cmp #$03
    bcc +
    lda #$ff
    sta {var_ffe2}
    inc {var_ffe3}
    lda #$fe
    trb {var_ffe3}
    rep #$20
    inc {var_ffe0}
    sep #$20
    jsr label_e427
+
rts



StreamMSU1Data:
    php
    phd
    rep #$20
    sep #$10
    lda #$4300
    tcd                     // DP = $4300

    sep #$20
    lda #$80
    sta.l $002115

    rep #$20
    ldy #$09                // DMA parameters: mode 1 (transfer 2 bytes to two registers), fixed src
    sty $00
    ldy #$18                // destination registers: VRAM
    sty $01
    lda #$2001              // set DMA source = MSU_READ
    sta $02
    ldy #$00                // DMA source bank
    sty $04

    ldx #$00

-;  lda {var_fff0},x
    bmi +
    sta.l $002116           // set VRAM address
    lda {var_fff2},x
    sta $05                 // set DMA transfer length

//    lda {var_ffeb}            // advance ### offset
//    clc
//    adc {var_fff2},x
//    sta {var_ffeb}

    sep #$20
    lda #$01
    sta.l $00420b           // initiate DMA transfer
    txa
    clc
    adc #$04
    tax
    rep #$20
    bra -

+;  ldx {var_ffe2}
    cpx #$02
    bne +
    sep #$20
    rep #$10
    lda #$00
    sta.l $002121           // reset CGRAM address
    lda #$08                // fixed source
    sta $00
    lda #$22                // destination register: CGRAM
    sta $01
    ldy #$0200
    sty $05                 // data length: 512 bytes fixed (full 256-color palette)
    lda #$01
    sta.l $00420b           // initiate DMA transfer

+;  pld
    plp
rts



label_e427:
    php
    sep #$30
    lda #$f8
    sta.l $00210d           // BG1 horizontal scroll (lower 8 bit)
    lda #$ff
    sta.l $00210d           // ditto (upper 2 bit)
    lda $7fffe3
    asl
    tax
    lda.l table_BG1vscroll,x// get vertical scroll offsets from table
    sta.l $00210e
    lda.l table_BG1vscroll+1,x
    sta.l $00210e
    plp
rts



table_BG1vscroll:           // BG1 vertical scroll offsets table
    db $3F
    db $01
    db $9F
    db $00



SetHVTimer:
    php
    rep #$20
    sep #$10
    lda #$0064
    sta.l $004207           // H-count timer value set for IRQ
    lda {var_ffe9}
    and #$00ff
    asl
    tax
    lda.l label_dce470,x    // get V-count timer values from table
    sta.l $004209
    plp
rts



label_dce470:               // V-count timer values table
    db $20
    db $00
    db $C0
    db $00

// label ??
//    php                    // unused code snippet (?)
//    sep #$20
//    lda #$00
//    sta.l $002121
//    lda {var_ffe0
//    sta.l $002122
//    lda {var_ffe1
//    sta.l $002122
//    plp
//rts



InitMSU1DataPort:
    php
    sep #$20
    lda #$00
    sta.l {MSU_SEEK}        // reset MSU data port address
    sta.l {MSU_SEEK}+1
    sta.l {MSU_SEEK}+2
    sta.l {MSU_SEEK}+3

-;  lda.l $002000           // wait for data port not busy
    bmi -
    plp
rts



SetAudioTrackAndVol:
    php
    sep #$20
    lda #$00
    sta.l {MSU_TRACK}       // set audio track no. = 0
    sta.l {MSU_TRACK}+1

-;  lda.l {MSU_STATUS}
    bvs -                   // wait for audio port not busy
    lda #$ff
    sta.l {MSU_VOLUME}      // set volume = max
    plp
rts



StartAudio:
    php
    sep #$20
    lda.l {MSU_STATUS}
    and #$10                // audio playing?
    bne +
    lda #$01                // no, play audio (no pause, no repeat)
    sta.l {MSU_CONTROL}
+;  plp
rts



StopAudio:
    php
    sep #$20
    lda.l {MSU_STATUS}
    and #$10                // audio playing?
    beq +
    lda #$00                // yes, pause/stop audio
    sta.l {MSU_CONTROL}
+;  plp
rts



SetAudioVolume:
    asl
    asl
    asl
    asl
    sta.l {MSU_VOLUME}      // set audio volume
rts


// ******************************** EOF *********************************
