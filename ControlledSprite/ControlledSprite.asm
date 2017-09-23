;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Sprites.asm 
;      - Fun with the VDP Sprites
  
; Includes
    include "../include/Header.asm"
    include "../include/VDP.asm"
    include "../include/Controller.asm"
; Assets
    include "../Assets/dude.asm"   

__GameMain:

_PushPallete:

    ; Setup VRAM write to $C000
    move.l  #$C000,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp

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
    
    move.l  #VDP_SPRITE_X_MIN,d6
    move.l  #VDP_SPRITE_Y_MIN,d7

_SetSpritePos:    

    move.l  #VDP_SPRITE_TABLE,-(sp)
    move.l  d6,-(sp)
    move.l  d7,-(sp)
    jsr     _VDPSetSpriteXY
    addq.l  #8,sp   
    addq.l  #4,sp

    move.w  #$FFF,d5
_CheckCtrlDelay:
    dbra    d5,_CheckCtrlDelay
    
_CheckCtrl:
    jsr     _CtrlReadPad1D0

_CheckCtrlUp:
    btst    #CTRL_UP,d0
    bne     _CheckCtrlDown
    jsr     _MoveSpriteUp

_CheckCtrlDown:
    btst    #CTRL_DOWN,d0
    bne     _CheckCtrlLeft
    jsr     _MoveSpriteDown

_CheckCtrlLeft:
    btst    #CTRL_LEFT,d0
    bne     _CheckCtrlRight
    jsr     _MoveSpriteLeft

_CheckCtrlRight:
    btst    #CTRL_RIGHT,d0
    bne     _CheckCtrlDone
    jsr     _MoveSpriteRight

_CheckCtrlDone:
    jmp     _SetSpritePos

_MoveSpriteUp:
    cmpi.l  #VDP_SPRITE_Y_MIN,d7
    ble     _MoveSpriteUpDone
    subq.l  #1,d7
_MoveSpriteUpDone:
    rts

_MoveSpriteDown:
    cmpi.l  #VDP_SPRITE_Y_MAX_32-24,d7
    bge     _MoveSpriteDownDone
    addq.l  #1,d7
_MoveSpriteDownDone:
    rts

_MoveSpriteLeft:
    cmpi.l  #VDP_SPRITE_X_MIN,d6
    ble     _MoveSpriteLeftDone
    subq.l  #1,d6
_MoveSpriteLeftDone:
    rts

_MoveSpriteRight:
    cmpi.l  #VDP_SPRITE_X_MAX_40-24,d6
    bge    _MoveSpriteRightDone
    addq.l  #1,d6
_MoveSpriteRightDone:
    rts

; End of ROM Loop

_finished:
    jmp     _finished

__end    ; Very last line, end of ROM address
