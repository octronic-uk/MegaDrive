	include 'init.asm'
	include 'globals.asm'
	include 'text.asm'
	include 'sprites.asm'

__main:

	move.w #$8F02,vdp_control     ; Set autoincrement to 2 bytes

	; ************************************
	; Move palettes to CRAM
	; ************************************
	move.l #vdp_write_palettes,vdp_control ; Set up VDP to write to CRAM address $0000

	lea Palettes,a0  ; Load address of Palettes into a0
	move.l #$0F,d0  ; 64 bytes of data (2 palettes,16 longwords,minus 1 for counter) in palettes

@mainColourLoop:
	move.l (a0)+,vdp_data ; Move data to VDP data port,and increment source address
	dbra d0,@mainColourLoop

	; ************************************
	; Load sprite tiles
	; ************************************
    lea      Sprite1,a0         ; Move sprite address to a0
    move.l   #Sprite1VRAM,d0    ; Move VRAM dest address to d0
    move.l   #Sprite1SizeT,d1   ; Move number of tiles to d1
	jsr      LoadTiles           ; Jump to subroutine
	
	lea      Sprite2,a0         ; Move sprite address to a0
    move.l   #Sprite2VRAM,d0    ; Move VRAM dest address to d0
    move.l   #Sprite2SizeT,d1   ; Move number of tiles to d1
	jsr      LoadTiles           ; Jump to subroutine
	
	; ************************************
	; Load sprite descriptors
	; ************************************
	lea     SpriteDescs,a0		; Sprite table data
	move.w  #$2,d0			; 2 sprites
	jsr     LoadSpriteTables

	; ************************************
	; Set sprite positions
	; ************************************
	move.w  #$0,d0	  ; Sprite ID
	move.w  #$B0,d1	  ; X coord
	jsr     SetSpritePosX ; Set X pos
	move.w  #$B0,d1	  ; Y coord
	jsr     SetSpritePosY ; Set Y pos

	move.w  #$1,d0	  ; Sprite ID
	move.w  #$A0,d1	  ; X coord
	jsr     SetSpritePosX ; Set X pos
	move.w  #$90,d1	  ; Y coord
	jsr     SetSpritePosY ; Set Y pos

	stop #$2700 ; Halt CPU

	; ************************************
	; Sprite descriptor structs
	; ************************************
SpriteDescs:
    dc.w $0000        ; Y coord (+ 128)
    dc.b %00001111     ; Width (bits 0-1) and height (bits 2-3) in tiles
    dc.b $01          ; Index of next sprite (linked list)
    dc.b $00          ; H/V flipping (bits 3/4),palette index (bits 5-6),priority (bit 7)
    dc.b Sprite1TileID ; Index of first tile
    dc.w $0000        ; X coord (+ 128)
	
    dc.w $0000        ; Y coord (+ 128)
    dc.b %00001111     ; Width (bits 0-1) and height (bits 2-3) in tiles
    dc.b $00          ; Index of next sprite (linked list)
    dc.b $20          ; H/V flipping (bits 3/4),palette index (bits 5-6),priority (bit 7)
    dc.b Sprite2TileID ; Index of first tile
    dc.w $0000        ; X coord (+ 128)

	; Include art assets
	include 'assets\assetmap.asm'

__end    ; Very last line,end of ROM address
