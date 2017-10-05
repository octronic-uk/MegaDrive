;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

VicViper_U3_Tiles_Start:
	; --- Tiles ---
	dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000885
	dc.l	$000858b8
	dc.l	$00001445
	dc.l	$16819455
	dc.l	$01416222
	dc.l	$00141288
	dc.l	$25444528
	dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$00000000
	dc.l	$58c00000
	dc.l	$54000000
	dc.l	$8888a500
	dc.l	$558babcb
	dc.l	$5555588b
	dc.l	$88885555
	dc.l	$00000000	;	Tile (col 2, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$84000000
	dc.l	$bbccbb80
	dc.l	$55500000
	dc.l	$28222462	;	Tile (col 0, row 1)
	dc.l	$25424464
	dc.l	$00044525
	dc.l	$00016255
	dc.l	$00054222
	dc.l	$00000255
	dc.l	$00000440
	dc.l	$00000000
	dc.l	$22225112	;	Tile (col 1, row 1)
	dc.l	$44442445
	dc.l	$55555554
	dc.l	$5555a000
	dc.l	$55400000
	dc.l	$40000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$558bb850	;	Tile (col 2, row 1)
	dc.l	$55400000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
VicViper_U3_Tiles_End:

VicViper_U3_VRAM        equ VicViper_U2_VRAM_End
VicViper_U3_SizeB       equ (VicViper_U3_Tiles_End-VicViper_U3_Tiles_Start) ; Sprite size in bytes
VicViper_U3_SizeW       equ (VicViper_U3_SizeB/2)                           ; Sprite size in words
VicViperS_U3_izeL       equ (VicViper_U3_SizeB/4)                           ; Sprite size in longs
VicViper_U3_SizeT       equ (VicViper_U3_SizeB/32)                          ; Sprite size in tiles
VicViper_U3_TileID      equ (VicViper_U3_VRAM/32)                           ; ID of first tile
VicViper_U3_VRAM_End    equ VicViper_U3_VRAM+VicViper_U3_SizeB

VicViper_U3_SpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001011    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b VicViper_U3_TileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
