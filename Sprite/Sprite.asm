;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Sprites.asm 
;      - Fun with the VDP Sprites
  
    include "../include/Header.asm"
    include "../include/VDP.asm"
    include "../Assets/dude.asm"   

    org $600
__GameMain:

_PushPallete:

    ; Setup VRAM write to $C000
    ;move.l  #$C000,-(sp)
    ;jsr     _VDPWriteVramMode
    ;addq.l  #4,sp

    ; Set autoincrement to 2 bytes
    move.l  #2,-(sp)
    jsr     _VDPSetAutoIncrement
	addq.l  #4,sp

    ; Set up VDP to write to CRAM address $0000
    move.l  #$0000,-(sp)
    jsr     _VDPWriteCramMode
    addq.l  #4,sp

    ; Load address of Palette into a0
    lea     DudePalette,a0               
    ; 32 bytes of data (8 longwords, minus 1 for counter) in palette
    move.l  #8,d0                  
    subq.l  #1,d0                  

_PushPaletteLoop:
    ; Move data to VDP data port, and increment source address
    move.l  (a0)+,VDP_DATA_PORT        
    dbra    d0,_PushPaletteLoop

    ; Set background colour to palette 0, colour 8
    move.w  #$8700,VDP_CTRL_PORT  

_PushTiles:
    ; Set up VDP to write to VRAM address $0020
    move.l  #$0020,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    ; Load address of Characters into a0
    lea     DudeTiles,a0         
    ; (32bytes/4(longs)) * Num tiles - 1 for counter
    move.l  #$48,d0               
    subq.l  #1,d0               

_PushTilesLoop:
    ; Move data to VDP data port, and increment source address
    move.l (a0)+,VDP_DATA_PORT     
    dbra d0,_PushTilesLoop

_DrawSprite:
    move.l  #VDP_SPRITE_TABLE,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    pea     DudeSpriteDescriptor
    jsr     _VDPLoadSpriteTable
    addq.l  #4,sp
    jmp     _MoveSpriteStart
    
    move.l  #VDP_SPRITE_X_MIN,d6
    move.l  #VDP_SPRITE_Y_MIN,d7
    move.l  #1,d3 ; X DIR
    move.l  #1,d4 ; Y DIR
    jmp _MoveSpriteStart

    org     $800
_MoveSpriteStart:
    move.l  #$F,d5
_MoveSpriteWait:
    dbra    d5,_MoveSpriteWait

    ; Check X Direction
    cmpi.l  #1,d3
    bne     _MoveSpriteLeft

_MoveSpriteRight:
    addq.l  #1,d6
    cmpi.l  #VDP_SPRITE_X_MAX_40-24,d6
    blt     _MoveSpriteXDone
    move.l  #0,d3 ; Toggle X Direction to Left
    jmp     _MoveSpriteXDone

_MoveSpriteLeft:
    subq.l  #1,d6
    cmpi.l  #VDP_SPRITE_X_MIN,d6
    bgt     _MoveSpriteXDone
    move.l  #$1,d3 ; Toggle X Direction to Right

_MoveSpriteXDone:    

    ; Check Y Direction
    cmpi.l  #1,d4
    bne     _MoveSpriteUp

_MoveSpriteDown:
    addq.l  #1,d7
    cmpi.l  #VDP_SPRITE_Y_MAX_32-24,d7
    blt     _MoveSpriteYDone
    move.l  #0,d4 ; Toggle Y Direction to Up
    jmp     _MoveSpriteYDone

_MoveSpriteUp:
    subq.l  #1,d7
    cmpi.l  #VDP_SPRITE_Y_MIN,d7
    bgt     _MoveSpriteYDone
    move.l  #1,d4 ; Toggle Y Direction to Down

_MoveSpriteYDone:

_MoveSpriteDoMove:    
    move.l  #VDP_SPRITE_TABLE,-(sp)
    move.l  d6,-(sp)
    move.l  d7,-(sp)
    jsr     _VDPSetSpriteXY
    addq.l  #8,sp   
    addq.l  #4,sp   
    jmp     _MoveSpriteStart

_finished:
    jmp     _finished

__end    ; Very last line, end of ROM address
