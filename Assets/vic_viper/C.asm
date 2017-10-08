;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

VicViper_C_Tiles_Start:
    dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000000
	dc.l	$9cc50000
	dc.l	$16bc5000
	dc.l	$066bc500
	dc.l	$0166bcb5
	dc.l	$00158bb6
	dc.l	$2858bc91
	dc.l	$2b488886	;	Tile (col 0, row 1)
	dc.l	$25214bcc
	dc.l	$00069cee
	dc.l	$000b5ee4
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$bb3d0300
	dc.l	$88872378
	dc.l	$18ccbbcc	;	Tile (col 1, row 1)
	dc.l	$ceecacb8
	dc.l	$c855a500
	dc.l	$58c00000
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
	dc.l	$40000000
	dc.l	$ccccbb80	;	Tile (col 2, row 1)
	dc.l	$54400000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
VicViper_C_Tiles_End:

    nop     0,8

VicViper_C_VRAM     equ $0F40
VicViper_C_SizeB    equ (VicViper_C_Tiles_End-VicViper_C_Tiles_Start) ; Sprite size in bytes
VicViper_C_SizeW    equ (VicViper_C_SizeB/2)           ; Sprite size in words
VicViper_C_SizeL    equ (VicViper_C_SizeB/4)           ; Sprite size in longs
VicViper_C_SizeT    equ (VicViper_C_SizeB/32)          ; Sprite size in tiles
VicViper_C_TileID   equ (VicViper_C_VRAM/32)           ; ID of first tile
VicViper_C_VRAM_End equ VicViper_C_VRAM+VicViper_C_SizeB

VicViper_C_SpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001001    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $01          ; Index of next sprite (linked list)
    dc.b $40          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b VicViper_C_TileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
