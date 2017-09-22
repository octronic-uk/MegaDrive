DudePalette:
	dc.w	$0000	;	Color $0 is transparent (so the actual value doesn't matter)
	dc.w	$0000	;	Color $1
	dc.w	$0422	;	Color $2
	dc.w	$0444	;	Color $3
	dc.w	$042a	;	Color $4
	dc.w	$0644	;	Color $5
	dc.w	$0860	;	Color $6
	dc.w	$0284	;	Color $7
	dc.w	$0ea4	;	Color $8
	dc.w	$048c	;	Color $9
	dc.w	$0888	;	Color $a
	dc.w	$02ca	;	Color $b
	dc.w	$0eca	;	Color $c
	dc.w	$06ce	;	Color $d
	dc.w	$0eee	;	Color $e
DudeTiles:
	dc.l	$11111111	;	Tile (col 0, row 0)
	dc.l	$12222525
	dc.l	$12221111
	dc.l	$1221eeee
	dc.l	$121eeeee
	dc.l	$11eeeee6
	dc.l	$1aeeae68
	dc.l	$15aaae22
	dc.l	$15aaae12	;	Tile (col 0, row 1)
	dc.l	$15aaae12
	dc.l	$15aaae12
	dc.l	$155aae12
	dc.l	$15aeaee1
	dc.l	$1555aaee
	dc.l	$15aeaaae
	dc.l	$1555aaae
	dc.l	$15aeaaae	;	Tile (col 0, row 2)
	dc.l	$12225aaa
	dc.l	$1344325a
	dc.l	$13344432
	dc.l	$14449943
	dc.l	$149d9d94
	dc.l	$19999494
	dc.l	$11111111
	dc.l	$11111111	;	Tile (col 1, row 0)
	dc.l	$55557577
	dc.l	$11112122
	dc.l	$eeeeeeea
	dc.l	$66666666
	dc.l	$c8888888
	dc.l	$ccc88888
	dc.l	$268ccccc
	dc.l	$22266666	;	Tile (col 1, row 1)
	dc.l	$22262222
	dc.l	$22262222
	dc.l	$22262222
	dc.l	$22262222
	dc.l	$12262222
	dc.l	$12262222
	dc.l	$22262222
	dc.l	$52622222	;	Tile (col 1, row 2)
	dc.l	$e5222222
	dc.l	$aeeeeeee
	dc.l	$aaeaeeee
	dc.l	$5aaeeeee
	dc.l	$2555aaaa
	dc.l	$35aaaeee
	dc.l	$11111111
	dc.l	$11111111	;	Tile (col 2, row 0)
	dc.l	$7777bbd1
	dc.l	$77777bb1
	dc.l	$5777b7b1
	dc.l	$62777771
	dc.l	$88677771
	dc.l	$88867771
	dc.l	$ccc82751
	dc.l	$66681571	;	Tile (col 2, row 1)
	dc.l	$66681551
	dc.l	$66681551
	dc.l	$66681551
	dc.l	$26681251
	dc.l	$22681521
	dc.l	$22661221
	dc.l	$22661221
	dc.l	$22611221	;	Tile (col 2, row 2)
	dc.l	$255ea121
	dc.l	$eeeee211
	dc.l	$eeeae231
	dc.l	$eeeea541
	dc.l	$aaa55391
	dc.l	$eeea5341
	dc.l	$11111111
DudeEnd:    ; Sprite end address

DudeVRAM    equ $0020
DudeSizeB   equ (DudeEnd-DudeTiles) ; Sprite size in bytes
DudeSizeW   equ (DudeSizeB/2)       ; Sprite size in words
DudeSizeL   equ (DudeSizeB/4)       ; Sprite size in longs
DudeSizeT   equ (DudeSizeB/32)      ; Sprite size in tiles
DudeTileID  equ (DudeVRAM/32)       ; ID of first tile

DudeSpriteDescriptor:
    dc.w $00F0        ; Y coord (+ 128)
    dc.b %00001010    ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b DudeTileID   ; Index of first tile
    dc.w $00F0        ; X Coordinate (+128)
