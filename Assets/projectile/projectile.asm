Projectile_Tiles_Start:
	dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000000
	dc.l	$00077000
	dc.l	$007aa700
	dc.l	$007aa700
	dc.l	$00077000
	dc.l	$00000000
	dc.l	$00000000
Projectile_Tiles_End:

    nop     0,8

Projectile_VRAM        equ VicViper_U4_VRAM_End
Projectile_SizeB       equ (Projectile_Tiles_End-Projectile_Tiles_Start)    ; Sprite size in bytes
Projectile_SizeW       equ (Projectile_SizeB/2)                             ; Sprite size in words
Projectile_SizeL       equ (Projectile_SizeB/4)                             ; Sprite size in longs
Projectile_SizeT       equ (Projectile_SizeB/32)                            ; Sprite size in tiles
Projectile_TileID      equ (Projectile_VRAM/32)                             ; ID of first tile
Projectile_VRAM_End    equ Projectile_VRAM+Projectile_SizeB

Projectile_SpriteDescriptor:
    dc.w $0000              ; Y coord (+ 128)
    dc.b %00000000          ; Width (bits 0-1) and height (bits 2-3)
    dc.b $00                ; Index of next sprite (linked list)
    dc.b $40                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b Projectile_TileID  ; Index of first tile
    dc.w $0000              ; X Coordinate (+128)

PROJECTILE_STRUCT_SPRITE_ID_W equ $00 
PROJECTILE_STRUCT_X_W         equ $02
PROJECTILE_STRUCT_Y_W         equ $04
PROJECTILE_STRUCT_X_VEL_W     equ $06 
PROJECTILE_STRUCT_Y_VEL_W     equ $08
PROJECTILE_STRUCT_ACTIVE_W    equ $0A

PROJECTILE_STRUCT_SIZE        equ $0C

PROJECTILE_DEFAULT_VEL_X      equ 1
PROJECTILE_DEFAULT_VEL_Y      equ 0


