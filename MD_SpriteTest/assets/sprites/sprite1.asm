Sprite1:

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000012
	dc.l	$00000234
	dc.l	$000014AC
	dc.l	$00002942

	dc.l	$00002812
	dc.l	$00002802
	dc.l	$00000202
	dc.l	$00000002
	dc.l	$00000002
	dc.l	$00000001
	dc.l	$00000001
	dc.l	$00000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000022
	dc.l	$000003AE
	dc.l	$00003AE8
	dc.l	$00004E83
	dc.l	$00004A82

	dc.l	$00003A88
	dc.l	$000004AA
	dc.l	$00000032
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$01112444
	dc.l	$2249A9A9
	dc.l	$49AA8ADA
	dc.l	$C9C89DED
	dc.l	$8CC89CDC

	dc.l	$49C89AC9
	dc.l	$44DA89C9
	dc.l	$48ADA8D8
	dc.l	$488ADAD9
	dc.l	$3888AEEE
	dc.l	$38842333
	dc.l	$38927222
	dc.l	$2493FF60

	dc.l	$13A4FFB0
	dc.l	$028A4FFB
	dc.l	$1248A444
	dc.l	$349A9844
	dc.l	$EEA98888
	dc.l	$98843222
	dc.l	$10110000
	dc.l	$03830000

	dc.l	$88310000
	dc.l	$A2100000
	dc.l	$20000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$42200000
	dc.l	$59842222
	dc.l	$95984234
	dc.l	$958944AA
	dc.l	$959C8AA4

	dc.l	$95ACAA84
	dc.l	$89ACA843
	dc.l	$9ADA8884
	dc.l	$AD848888
	dc.l	$D8434984
	dc.l	$33224A84
	dc.l	$22724A83
	dc.l	$F6734A43

	dc.l	$06439A42
	dc.l	$B844AA31
	dc.l	$4448A831
	dc.l	$4489A432
	dc.l	$9AAE8443
	dc.l	$234AEE84
	dc.l	$002348AA
	dc.l	$00002248

	dc.l	$00000033
	dc.l	$00000000
	dc.l	$00000224
	dc.l	$000028AA
	dc.l	$00001111
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$22000000
	dc.l	$43200000
	dc.l	$A8420000
	dc.l	$33842000

	dc.l	$11282000
	dc.l	$31282000
	dc.l	$31020000
	dc.l	$31000000
	dc.l	$31000000
	dc.l	$31000000
	dc.l	$21000000
	dc.l	$10000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$10000000
	dc.l	$11000000
	dc.l	$31000000
	dc.l	$83100000
	dc.l	$AA410000

	dc.l	$4A830000
	dc.l	$3A840000
	dc.l	$A8410000
	dc.l	$41100000
	dc.l	$10000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

Sprite1End								 ; Sprite end address
Sprite1SizeB: equ (Sprite1End-Sprite1)	 ; Sprite size in bytes
Sprite1SizeW: equ (Sprite1SizeB/2)		 ; Sprite size in words
Sprite1SizeL: equ (Sprite1SizeB/4)		 ; Sprite size in longs
Sprite1SizeT: equ (Sprite1SizeB/32)		 ; Sprite size in tiles
Sprite1TileID: equ (Sprite1VRAM/32)		 ; ID of first tile
