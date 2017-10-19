;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

VicViper_D3_Tiles_Start:
	; --- Tiles ---
	dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000440
	dc.l	$00051455
	dc.l	$00016588
	dc.l	$9ceb5586
	dc.l	$169ceb81
	dc.l	$0169ceec
	dc.l	$25158bbb
	
    dc.l	$2b48bbc6	;	Tile (col 0, row 1)
	dc.l	$2528ce91
	dc.l	$00014886
	dc.l	$00069bbe
	dc.l	$00016cce
	dc.l	$000b5ceb
	dc.l	$00000ee4
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$00000000
	dc.l	$44500000
	dc.l	$55400000
	dc.l	$1588a540
	dc.l	$6bb73588
	dc.l	$cb7df37c
	dc.l	$bb8737be

	dc.l	$bebb88bc	;	Tile (col 1, row 1)
	dc.l	$8bceeccb
	dc.l	$11ccacb4
	dc.l	$ec85a000
	dc.l	$b5000000
	dc.l	$48c00000
	dc.l	$00000000
	dc.l	$00000000

    dc.l	$00000000	;	Tile (col 2, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$54000000
	dc.l	$cccccb80
	dc.l	$c8400000

	dc.l	$cccccb80	;	Tile (col 2, row 1)
	dc.l	$b8400000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

VicViper_D3_Tiles_End:

    even

VicViper_D3_VRAM     equ VicViper_D2_VRAM_End
VicViper_D3_SizeB    equ (VicViper_D3_Tiles_End-VicViper_D3_Tiles_Start)    ; Sprite size in bytes
VicViper_D3_SizeW    equ (VicViper_D3_SizeB/2)                              ; Sprite size in words
VicViper_D3_SizeL    equ (VicViper_D3_SizeB/4)                              ; Sprite size in longs
VicViper_D3_SizeT    equ (VicViper_D3_SizeB/32)                             ; Sprite size in tiles
VicViper_D3_TileID   equ (VicViper_D3_VRAM/32)                              ; ID of first tile
VicViper_D3_VRAM_End equ VicViper_D3_VRAM+VicViper_D3_SizeB

VicViper_D3_SpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001011    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b VicViper_D3_TileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
