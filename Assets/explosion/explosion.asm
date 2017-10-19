ExplosionPalette:
	dc.w	$0000	;	Color $0 is transparent (so the actual value doesn't matter)
	dc.w	$0006	;	Color $1
	dc.w	$002a	;	Color $2
	dc.w	$024c	;	Color $3
	dc.w	$026c	;	Color $4
	dc.w	$008e	;	Color $5
	dc.w	$00ae	;	Color $6
	dc.w	$00ce	;	Color $7
	dc.w	$0aee	;	Color $8
ExplosionPaletteEnd:

    even

Explosion_Frame1_Start:
    dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000000
	dc.l	$00020000
	dc.l	$00003401
	dc.l	$00000322
	dc.l	$00001244
	dc.l	$00002344
	dc.l	$00123335

    dc.l	$00000000	;	Tile (col 1, row 0)
	dc.l	$00000000
	dc.l	$20001000
	dc.l	$30234000
	dc.l	$44430000
	dc.l	$54320000
	dc.l	$54321000
	dc.l	$65432310

	dc.l	$00002444	;	Tile (col 0, row 1)
	dc.l	$00002354
	dc.l	$00003424
	dc.l	$00022013
	dc.l	$00100002
	dc.l	$00000002
	dc.l	$00000000
	dc.l	$00000000

    dc.l	$54433000	;	Tile (col 1, row 1)
	dc.l	$34522000
	dc.l	$23341000
	dc.l	$02302000
	dc.l	$00100200
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
Explosion_Frame1_End:

    even

Explosion_Frame1_VRAM     equ Projectile_VRAM_End
Explosion_Frame1_SizeB    equ (Explosion_Frame1__End-Explosion_Frame1_Start) ; Sprite size in bytes
Explosion_Frame1_SizeW    equ (Explosion_Frame1_SizeB/2)           ; Sprite size in words
Explosion_Frame1_SizeL    equ (Explosion_Frame1_SizeB/4)           ; Sprite size in longs
Explosion_Frame1_SizeT    equ (Explosion_Frame1_SizeB/32)          ; Sprite size in tiles
Explosion_Frame1_TileID   equ (Explosion_Frame1_VRAM/32)           ; ID of first tile
Explosion_Frame1_VRAM_End equ Explosion_Frame1_VRAM+Explosion_Frame1_SizeB


Explosion_Frame2_Start:
    dc.l	$00000000	;	Tile (col 2, row 0)
	dc.l	$00000002
	dc.l	$00010033
	dc.l	$00233252
	dc.l	$00022334
	dc.l	$00323444
	dc.l	$00034456
	dc.l	$01033456

	dc.l	$00000000	;	Tile (col 3, row 0)
	dc.l	$00000000
	dc.l	$22021000
	dc.l	$33330200
	dc.l	$43342000
	dc.l	$55433210
	dc.l	$65533000
	dc.l	$76533520

    dc.l	$00253456	;	Tile (col 2, row 1)
	dc.l	$00033345
	dc.l	$00223433
	dc.l	$00002325
	dc.l	$00202203
	dc.l	$00010020
	dc.l	$00000100
	dc.l	$00000000

	dc.l	$65443200	;	Tile (col 3, row 1)
	dc.l	$44433000
	dc.l	$43350100
	dc.l	$23432000
	dc.l	$33250000
	dc.l	$20001000
	dc.l	$00000000
	dc.l	$00000000
Explosion_Frame2_End:

Explosion_Frame3_Start:
	dc.l	$00000000	;	Tile (col 4, row 0)
	dc.l	$00102030
	dc.l	$00033443
	dc.l	$02343455
	dc.l	$00344566
	dc.l	$02335677
	dc.l	$00346778
	dc.l	$03546788

	dc.l	$00346778	;	Tile (col 4, row 1)
	dc.l	$03445677
	dc.l	$01234566
	dc.l	$00244444
	dc.l	$00344444
	dc.l	$00013334
	dc.l	$00000230
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 5, row 0)
	dc.l	$32020000
	dc.l	$34333100
	dc.l	$54443000
	dc.l	$65453320
	dc.l	$76554300
	dc.l	$77644330
	dc.l	$87554300

	dc.l	$77655430	;	Tile (col 5, row 1)
	dc.l	$76543420
	dc.l	$55444200
	dc.l	$54443000
	dc.l	$44433100
	dc.l	$22032000
	dc.l	$30200000
	dc.l	$00000000
Explosion_Frame3_End:

Explosion_Frame4_Start:
	dc.l	$00000000	;	Tile (col 6, row 0)
	dc.l	$00000023
	dc.l	$00203555
	dc.l	$00022667
	dc.l	$02356755
	dc.l	$00357553
	dc.l	$03264532
	dc.l	$00575532

	dc.l	$03567532	;	Tile (col 6, row 1)
	dc.l	$02256532
	dc.l	$00246655
	dc.l	$00034667
	dc.l	$00223444
	dc.l	$00023022
	dc.l	$00000203
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 7, row 0)
	dc.l	$03020200
	dc.l	$54423000
	dc.l	$76452320
	dc.l	$55665300
	dc.l	$33565320
	dc.l	$22357300
	dc.l	$02356530

	dc.l	$22356300	;	Tile (col 7, row 1)
	dc.l	$23356430
	dc.l	$33565020
	dc.l	$76644200
	dc.l	$44442300
	dc.l	$33032000
	dc.l	$03200000
	dc.l	$00000000
Explosion_Frame4_End:

Explosion_Frame5_Start:
	dc.l	$00000000	;	Tile (col 8, row 0)
	dc.l	$00002030
	dc.l	$00010445
	dc.l	$02005636
	dc.l	$00354343
	dc.l	$02063432
	dc.l	$00344321
	dc.l	$03043310

	dc.l	$00364210	;	Tile (col 8, row 1)
	dc.l	$03463321
	dc.l	$02054432
	dc.l	$00040643
	dc.l	$00103404
	dc.l	$00020003
	dc.l	$00000030
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 9, row 0)
	dc.l	$32020000
	dc.l	$05500100
	dc.l	$43652000
	dc.l	$33644320
	dc.l	$23346300
	dc.l	$12334030
	dc.l	$01246500

	dc.l	$01246530	;	Tile (col 9, row 1)
	dc.l	$12344020
	dc.l	$23464200
	dc.l	$43363000
	dc.l	$40430000
	dc.l	$02001000
	dc.l	$30200000
	dc.l	$00000000
Explosion_Frame5_Etart:

Explosion_Frame6_Start:
	dc.l	$00000000	;	Tile (col 10, row 0)
	dc.l	$00000023
	dc.l	$00000500
	dc.l	$00021403
	dc.l	$01304030
	dc.l	$00343431
	dc.l	$03014310
	dc.l	$00043100

	dc.l	$00534200	;	Tile (col 10, row 1)
	dc.l	$01003310
	dc.l	$00240431
	dc.l	$00030304
	dc.l	$00000404
	dc.l	$00010010
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 11, row 0)
	dc.l	$03020000
	dc.l	$54401000
	dc.l	$42450020
	dc.l	$31305300
	dc.l	$13334010
	dc.l	$01304300
	dc.l	$00134000

	dc.l	$00130300	;	Tile (col 11, row 1)
	dc.l	$01330400
	dc.l	$13315020
	dc.l	$14404000
	dc.l	$40430100
	dc.l	$30002000
	dc.l	$00000000
	dc.l	$00000000
Explosion_Frame6_Etart:

Explosion_Frame7_Start:
	dc.l	$00000000	;	Tile (col 12, row 0)
	dc.l	$00000000
	dc.l	$00030403
	dc.l	$00003000
	dc.l	$00300302
	dc.l	$00043320
	dc.l	$00340200
	dc.l	$00042100

	dc.l	$00302000	;	Tile (col 12, row 1)
	dc.l	$00403200
	dc.l	$00030321
	dc.l	$00040032
	dc.l	$00003400
	dc.l	$00000003
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 13, row 0)
	dc.l	$02000000
	dc.l	$00300000
	dc.l	$30402000
	dc.l	$12040000
	dc.l	$02404300
	dc.l	$00240000
	dc.l	$00024000

	dc.l	$00020300	;	Tile (col 13, row 1)
	dc.l	$01230000
	dc.l	$02404200
	dc.l	$20303000
	dc.l	$40000000
	dc.l	$02000000
	dc.l	$00000000
	dc.l	$00000000
Explosion_Frame7_End:

Explosion_Frame8_Start:
	dc.l	$00000000	;	Tile (col 14, row 0)
	dc.l	$00000010
	dc.l	$00000300
	dc.l	$00020003
	dc.l	$00004000
	dc.l	$00340000
	dc.l	$01000000
	dc.l	$00040000

	dc.l	$00300000	;	Tile (col 14, row 1)
	dc.l	$00000000
	dc.l	$00200000
	dc.l	$00030300
	dc.l	$00010004
	dc.l	$00000020
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000	;	Tile (col 15, row 0)
	dc.l	$01000000
	dc.l	$30403000
	dc.l	$00030100
	dc.l	$00000300
	dc.l	$00000000
	dc.l	$00000300
	dc.l	$00000010

	dc.l	$00000300	;	Tile (col 15, row 1)
	dc.l	$00000400
	dc.l	$00000000
	dc.l	$03004000
	dc.l	$00430100
	dc.l	$30000000
	dc.l	$01000000
	dc.l	$00000000
Explosion_Frame8_End:
