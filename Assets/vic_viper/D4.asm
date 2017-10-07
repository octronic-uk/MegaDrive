;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

VicViper_D4_Tiles_Start:
	; --- Tiles ---
	dc.l	$00000440	;	Tile (col 0, row 0)
	dc.l	$00000554
	dc.l	$00081455
	dc.l	$00016588
	dc.l	$00016558
	dc.l	$001445b6
	dc.l	$6eccbbc1
	dc.l	$246bcccc

    dc.l	$28158cc9	;	Tile (col 0, row 1)
	dc.l	$2528bbb6
	dc.l	$0005ce91
	dc.l	$00014886
	dc.l	$00069bbe
	dc.l	$00019cce
	dc.l	$000b5ceb
	dc.l	$00000ee4

	dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$00000000
	dc.l	$45800000
	dc.l	$54400000
	dc.l	$8855a540
	dc.l	$168bb888
	dc.l	$9b87378c
	dc.l	$bc3df37e

	dc.l	$bb87378e	;	Tile (col 1, row 1)
	dc.l	$bebb88cc
	dc.l	$9bceeccb
	dc.l	$11bcabb4
	dc.l	$ecb5a000
	dc.l	$b5000000
	dc.l	$48c00000
	dc.l	$00000000

    dc.l	$00000000	;	Tile (col 2, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$85400000
	dc.l	$cccccb80
	dc.l	$c8400000

	dc.l	$c8400000	;	Tile (col 2, row 1)
	dc.l	$cccccb80
	dc.l	$b8400000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

VicViper_D4_Tiles_End:

    nop     0,8

VicViper_D4_VRAM        equ VicViper_D3_VRAM_End
VicViper_D4_SizeB       equ (VicViper_D4_Tiles_End-VicViper_D4_Tiles_Start) ; Sprite size in bytes
VicViper_D4_SizeW       equ (VicViper_D4_SizeB/2)                           ; Sprite size in words
VicViper_D4_SizeL       equ (VicViper_D4_SizeB/4)                           ; Sprite size in longs
VicViper_D4_SizeT       equ (VicViper_D4_SizeB/32)                          ; Sprite size in tiles
VicViper_D4_TileID      equ (VicViper_D4_VRAM/32)                           ; ID of first tile
VicViper_D4_VRAM_End    equ VicViper_D4_VRAM+VicViper_D4_SizeB

VicViper_D4_SpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001011    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b VicViper_D4_TileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
