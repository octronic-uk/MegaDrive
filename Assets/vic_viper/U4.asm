;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

VicViper_U4_Tiles_Start:
	dc.l	$00000885	;	Tile (col 0, row 0)
	dc.l	$000858bb
	dc.l	$00001445
	dc.l	$00019458
	dc.l	$00016222
	dc.l	$00001288
	dc.l	$16552528
	dc.l	$24425462

    dc.l	$28222462	;	Tile (col 0, row 1)
	dc.l	$25424462
	dc.l	$00054528
	dc.l	$00004288
	dc.l	$00016222
	dc.l	$00054255
	dc.l	$00000455
	dc.l	$00000444

	dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$58c00000
	dc.l	$44000000
	dc.l	$bb85a000
	dc.l	$5588a850
	dc.l	$5555558b
	dc.l	$88885555
	dc.l	$22225225
	

    dc.l	$55552662	;	Tile (col 1, row 1)
	dc.l	$22225225
	dc.l	$88885555
	dc.l	$55555440
	dc.l	$5554a000
	dc.l	$55400000
	dc.l	$40000000
	dc.l	$00000000

    dc.l	$00000000	;	Tile (col 2, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$85400000
	dc.l	$588bbb80
	dc.l	$58400000

	dc.l	$58400000	;	Tile (col 2, row 1)
	dc.l	$558bb850
	dc.l	$54400000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
VicViper_U4_Tiles_End:

    nop     0,8

VicViper_U4_VRAM        equ VicViper_U3_VRAM_End
VicViper_U4_SizeB       equ (VicViper_U4_Tiles_End-VicViper_U4_Tiles_Start) ; Sprite size in bytes
VicViper_U4_SizeW       equ (VicViper_U4_SizeB/2)                           ; Sprite size in words
VicViper_U4_SizeL       equ (VicViper_U4_SizeB/4)                           ; Sprite size in longs
VicViper_U4_SizeT       equ (VicViper_U4_SizeB/32)                          ; Sprite size in tiles
VicViper_U4_TileID      equ (VicViper_U4_VRAM/32)                           ; ID of first tile
VicViper_U4_VRAM_End    equ VicViper_U4_VRAM+VicViper_U4_SizeB

VicViper_U4_SpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001011    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b VicViper_U4_TileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
