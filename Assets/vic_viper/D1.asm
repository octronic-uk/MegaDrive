;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

VicViper_D1_Tiles_Start:
	; --- Tiles ---
	dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$9cc50000
	dc.l	$16be5500
	dc.l	$066bec55
	dc.l	$0066beec
	dc.l	$28158bb6

	dc.l	$2b48ce91	;	Tile (col 0, row 1)
	dc.l	$25288886
	dc.l	$00014bbc
	dc.l	$00069cee
	dc.l	$000b5ee4
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$54400000
	dc.l	$8b3d0300
	dc.l	$be777378

	dc.l	$888b88bb	;	Tile (col 1, row 1)
	dc.l	$18ccbbcc
	dc.l	$ceecab85
	dc.l	$c855a000
	dc.l	$48c00000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$ccccbb80	;	Tile (col 2, row 1)
	dc.l	$b8540000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

    dc.l	$00000000	;	Tile (col 2, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$54000000
VicViper_D1_Tiles_End:

    nop     0,8

VicViper_D1_VRAM     equ VicViper_C_VRAM_End
VicViper_D1_SizeB    equ (VicViper_D1_Tiles_End-VicViper_D1_Tiles_Start) ; Sprite size in bytes
VicViper_D1_SizeW    equ (VicViper_D1_SizeB/2)           ; Sprite size in words
VicViper_D1_SizeL    equ (VicViper_D1_SizeB/4)           ; Sprite size in longs
VicViper_D1_SizeT    equ (VicViper_D1_SizeB/32)          ; Sprite size in tiles
VicViper_D1_TileID   equ (VicViper_D1_VRAM/32)           ; ID of first tile
VicViper_D1_VRAM_End equ VicViper_C_VRAM+VicViper_D1_SizeB

VicViper_D1_SpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001011    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b VicViper_D1_TileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
