;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

VicViper_U1_Tiles_Start:
	; --- Tiles ---
	dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$6bc50000
	dc.l	$069cb500
	dc.l	$0169ccb5
	dc.l	$001588bb
	dc.l	$2858c961

    dc.l	$2b444cbc	;	Tile (col 0, row 1)
	dc.l	$25269cc5
	dc.l	$00085544
	dc.l	$00001455
	dc.l	$00000444
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$8c37d300
	dc.l	$58855555

    dc.l	$ccb8abbc	;	Tile (col 1, row 1)
	dc.l	$8855a888
	dc.l	$58c55540
	dc.l	$54400000
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
	dc.l	$55540000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

VicViper_U1_Tiles_End:

    even

VicViper_U1_VRAM     equ VicViper_D4_VRAM_End
VicViper_U1_SizeB    equ (VicViper_U1_Tiles_End-VicViper_U1_Tiles_Start)    ; Sprite size in bytes
VicViper_U1_SizeW    equ (VicViper_U1_SizeB/2)                              ; Sprite size in words
VicViper_U1_SizeL    equ (VicViper_U1_SizeB/4)                              ; Sprite size in longs
VicViper_U1_SizeT    equ (VicViper_U1_SizeB/32)                             ; Sprite size in tiles
VicViper_U1_TileID   equ (VicViper_U1_VRAM/32)                              ; ID of first tile
VicViper_U1_VRAM_End equ VicViper_U1_VRAM+VicViper_U1_SizeB

VicViper_U1_SpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001011    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b VicViper_U1_TileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
