;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   SpriteLoader.asm 
;      - Fun with the VDP Sprites

LOAD_SPRITE_STACK_ALIGN equ     24
LOAD_SPRITE_DESCRIPTOR  equ     24
LOAD_SPRITE_PALETTE_SRC equ     20
LOAD_SPRITE_CRAM_DEST   equ     16
LOAD_SPRITE_TILES_SRC   equ     12
LOAD_SPRITE_TILES_DEST  equ      8
LOAD_SPRITE_NUM_TILES   equ      4
;   Usage
;       pea     Sprite Descriptor Address
;       pea     Palette Source Address
;       move.l  Palettes CRAM Destination
;       pea     Tiles Tiles Source
;       move.l  Tiles VRam Destination
;       move.l  Number Of Tiles
;       jsr     LoadSprite
;       add.l   #LOAD_SPRITE_STACK_ALIGN,sp
LoadSprite:
    ; Set autoincrement to 2 bytes
    move.l  #2,-(sp)
    jsr     _VDPSetAutoIncrement
	addq.l  #4,sp
    ; Set up VDP to write to CRAM address argued
    move.l  LOAD_SPRITE_ARG_CRAM_ADDR(sp),-(sp)
    jsr     _VDPWriteCramMode
    addq.l  #4,sp
    ; Load address of Palette into a0
    movea.l LOAD_SPRITE_ARG_PALETTE_SRC(sp),a0               
    ; 32 bytes of data (8 longwords, minus 1 for counter) in palette
    move.l  #8,d0                  
    subq.l  #1,d0                  
_LoadSprite_PushPaletteLoop:
    ; Move data to VDP data port, and increment source address
    move.l  (a0)+,VDP_DATA_PORT        
    dbra    d0,_LoadSprite_PushPaletteLoop
_LoadSprite_PushTiles:
    ; Set up VDP to write to VRAM address argued
    move.l  LOAD_SPRITE_ARG_VRAM_ADDR(sp),-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    ; Load address of tiles into a0
    movea.l LOAD_SPRITE_ARG_TILES_ADDR(sp),a0         
    ; (32bytes/4(longs)) * Num tiles - 1 for counter
    move.l  LOAD_SPRITE_NUM_TILES(sp),d0               
    mul.l   #8,d0
    subq.l  #1,d0               

_LoadSprite_PushTilesLoop:
    ; Move data to VDP data port, and increment source address
    move.l (a0)+,VDP_DATA_PORT     
    dbra d0,_LoadSprite_PushTilesLoop

_LoadSprite_DrawSprite:
    move.l  #VDP_SPRITE_TABLE,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    move.l  LOAD_SPRITE_DESCRIPTOR(sp),a0
    move.l  (a0)+,VDP_DATA_PORT
    move.l  (a0)+,VDP_DATA_PORT
    rts
    

