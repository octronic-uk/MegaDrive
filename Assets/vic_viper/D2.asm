;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

VicViper_D2_Tiles_Start:
	; --- Tiles ---
	dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$9cc50440
	dc.l	$16be5588
	dc.l	$066beb51
	dc.l	$0166beeb
	dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$55400000
	dc.l	$88873500
	dc.l	$bb3df378
	dc.l	$00000000	;	Tile (col 2, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$54000000
	dc.l	$28158bb6	;	Tile (col 0, row 1)
	dc.l	$2b48ce91
	dc.l	$25288886
	dc.l	$00014bbc
	dc.l	$00069cce
	dc.l	$000b5ceb
	dc.l	$00000ee4
	dc.l	$00000000
	dc.l	$be8732bc	;	Tile (col 1, row 1)
	dc.l	$8bbb88bb
	dc.l	$16ccbbcc
	dc.l	$beecab85
	dc.l	$c855a000
	dc.l	$48c00000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$b8888850	;	Tile (col 2, row 1)
	dc.l	$ccccbb80
	dc.l	$b8500000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
VicViper_D2_Tiles_End:


VicViper_D2_VRAM    equ $0020
VicViper_D2_SizeB   equ (VicViper_D2_Tiles_End-VicViper_D2_Tiles_Start) ; Sprite size in bytes
VicViper_D2_SizeW   equ (VicViper_D2_SizeB/2)           ; Sprite size in words
VicViper_D2_SizeL   equ (VicViper_D2_SizeB/4)           ; Sprite size in longs
VicViper_D2_SizeT   equ (VicViper_D2_SizeB/32)          ; Sprite size in tiles
VicViper_D2_TileID  equ (VicViper_D2_VRAM/32)           ; ID of first tile

VicViper_D2_SpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001011    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b VicViper_D2_TileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
