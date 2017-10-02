Sprite2:

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000008
	dc.l	$00000008
	dc.l	$00000008
	dc.l	$00000009

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000003
	dc.l	$0000000A
	dc.l	$0000000B
	dc.l	$0000000B

	dc.l	$0000003B
	dc.l	$0000006B
	dc.l	$000000AB
	dc.l	$000006AB
	dc.l	$000036BA
	dc.l	$000036B9
	dc.l	$000003BA
	dc.l	$000000AB

	dc.l	$0000000A
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$88800000
	dc.l	$9A980000
	dc.l	$C4C80000
	dc.l	$A8A00999

	dc.l	$A98A9888
	dc.l	$9A89A888
	dc.l	$3B889998
	dc.l	$BA89AB88
	dc.l	$B98AB878
	dc.l	$B9869667
	dc.l	$A8648666
	dc.l	$98634643

	dc.l	$98642332
	dc.l	$99643223
	dc.l	$9A964336
	dc.l	$AB876468
	dc.l	$BB998785
	dc.l	$99BBB955
	dc.l	$88777555
	dc.l	$A8888775

	dc.l	$BBBA9888
	dc.l	$00ABBBAA
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000888
	dc.l	$000089A9
	dc.l	$00008C4C
	dc.l	$99981988

	dc.l	$88899988
	dc.l	$88888989
	dc.l	$88788890
	dc.l	$88878898
	dc.l	$88688899
	dc.l	$8744789A
	dc.l	$7434789A
	dc.l	$6434488A

	dc.l	$6333489A
	dc.l	$22637899
	dc.l	$44748999
	dc.l	$74848898
	dc.l	$88588889
	dc.l	$65788899
	dc.l	$55578889
	dc.l	$578889AA

	dc.l	$8899AA90
	dc.l	$AAAA6600
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$80000000
	dc.l	$80000000
	dc.l	$80000000
	dc.l	$00000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$80000000
	dc.l	$80000000

	dc.l	$80000000
	dc.l	$83000000
	dc.l	$98000000
	dc.l	$99600000
	dc.l	$99630000
	dc.l	$99630000
	dc.l	$A9600000
	dc.l	$90000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

Sprite2End								 ; Sprite end address
Sprite2SizeB: equ (Sprite2End-Sprite2)	 ; Sprite size in bytes
Sprite2SizeW: equ (Sprite2SizeB/2)		 ; Sprite size in words
Sprite2SizeL: equ (Sprite2SizeB/4)		 ; Sprite size in longs
Sprite2SizeT: equ (Sprite2SizeB/32)		 ; Sprite size in tiles
Sprite2TileID: equ (Sprite2VRAM/32)		 ; ID of first tile
