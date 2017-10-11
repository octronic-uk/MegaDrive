;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

VicViper_U2_Tiles_Start:
	; --- Tiles ---
	dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$68b54000
	dc.l	$068b5855
	dc.l	$01581cbb
	dc.l	$00119ec8
	dc.l	$285855bb

    dc.l	$2b241244	;	Tile (col 0, row 1)
	dc.l	$25422214
	dc.l	$00044525
	dc.l	$00016444
	dc.l	$00044455
	dc.l	$00000440
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$44000000
	dc.l	$bb577300
	dc.l	$558bacb8
	dc.l	$58c4a8bb

	dc.l	$45888555	;	Tile (col 1, row 1)
	dc.l	$44444445
	dc.l	$55555555
	dc.l	$55554400
	dc.l	$54400000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

    dc.l	$00000000	;	Tile (col 2, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$54000000
	dc.l	$ccccbb80

	dc.l	$55555540	;	Tile (col 2, row 1)
	dc.l	$45440000
	dc.l	$40000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

VicViper_U2_Tiles_End:

    even

VicViper_U2_VRAM     equ VicViper_U1_VRAM_End
VicViper_U2_SizeB    equ (VicViper_U2_Tiles_End-VicViper_U2_Tiles_Start)    ; Sprite size in bytes
VicViper_U2_SizeW    equ (VicViper_U2_SizeB/2)                              ; Sprite size in words
VicViper_U2_SizeL    equ (VicViper_U2_SizeB/4)                              ; Sprite size in longs
VicViper_U2_SizeT    equ (VicViper_U2_SizeB/32)                             ; Sprite size in tiles
VicViper_U2_TileID   equ (VicViper_U2_VRAM/32)                              ; ID of first tile
VicViper_U2_VRAM_End equ VicViper_U2_VRAM+VicViper_U2_SizeB

VicViper_U2_SpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001011    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b VicViper_U2_TileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
