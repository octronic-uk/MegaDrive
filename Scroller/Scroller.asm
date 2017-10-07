;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Scroller.asm 
;       - Scrolling Shmup type demo with ripped assets.
;           - PCB - MacOS 7.5
;           - VicViper (Parodius DA)
  
; Includes
    include "../include/Header.asm"
    include "../Assets/pcb/pcb.asm"
    include "../Assets/vic_viper/vic_viper.asm"

__GameMain:
    jsr     _Scroller_SetupBG
    jsr     _Scroller_SetupVicViper
    jsr     _Scroller_InitCounters

_Scroller_Loop:
    jsr     CtrlReadPad1D0
    move.b  d0,_Scroller_Ctrl_Last
    jsr     _Scroller_HandleController
    jsr     _Scroller_SetTiltSprite
    ; Wait for VBlank
    jsr     VDP_WaitVBlankEnd
    jsr     _Scroller_Update_BG
    jsr     _Scroller_Update_Player
    jmp     _Scroller_Loop


; Subroutines ------------------------------------------------------------------

_Scroller_InitCounters:
    move.w  #$0000,_Scroller_HScroll
    move.w  #$00F0,_Scroller_PlayerXPos
    move.w  #$00F0,_Scroller_PlayerYPos
    move.w  #TILT_C,_Scroller_Tilt
    move.w  #HSCROLL_DELAY,_Scroller_HScroll_Delay
    move.w  #PLAYER_SPEED_DELAY,_Scroller_Player_Speed_Delay
    rts

_Scroller_TiltDecay:
    btst    #CTRL_UP,_Scroller_Ctrl_Last
    beq     _Scroller_TiltDecay_Done
    btst    #CTRL_DOWN,_Scroller_Ctrl_Last
    beq     _Scroller_TiltDecay_Done
    cmp.w   #TILT_C,_Scroller_Tilt    
    bgt     _Scroller_TiltDecay_TooHigh
    blt     _Scroller_TiltDecay_TooLow
    jmp     _Scroller_TiltDecay_Done
_Scroller_TiltDecay_TooHigh:
    subq.w  #1,_Scroller_Tilt
    jmp _Scroller_TiltDecay_Done
_Scroller_TiltDecay_TooLow:
    addq.w  #1,_Scroller_Tilt
    jmp _Scroller_TiltDecay_Done
_Scroller_TiltDecay_Done:
    rts

_Scroller_SetTiltSprite:

_Scroller_SetTiltSprite_D4:
    cmp.w   #TILT_D4,_Scroller_Tilt
    bge     _Scroller_SetTiltSprite_D3
    move.w  #VicViper_D4_TileID,d0
    cmp.w   #TILT_MIN,_Scroller_Tilt
    bge     _Scroller_SetTiltSprite_NoMin
    move.w  #TILT_MIN,_Scroller_Tilt
_Scroller_SetTiltSprite_NoMin:
    jmp     _Scroller_SetTiltSprite_End
    
_Scroller_SetTiltSprite_D3:
    cmp.w   #TILT_D3,_Scroller_Tilt
    bge     _Scroller_SetTiltSprite_D2
    move.w  #VicViper_D3_TileID,d0
    jmp     _Scroller_SetTiltSprite_End

_Scroller_SetTiltSprite_D2:
    cmp.w   #TILT_D2,_Scroller_Tilt
    bge     _Scroller_SetTiltSprite_D1
    move.w  #VicViper_D2_TileID,d0
    jmp     _Scroller_SetTiltSprite_End

_Scroller_SetTiltSprite_D1:
    cmp.w   #TILT_D1,_Scroller_Tilt
    bge     _Scroller_SetTiltSprite_C
    move.w  #VicViper_D1_TileID,d0
    jmp     _Scroller_SetTiltSprite_End

_Scroller_SetTiltSprite_C:
    cmp.w   #TILT_C,_Scroller_Tilt
    bge     _Scroller_SetTiltSprite_U1
    move.w  #VicViper_C_TileID,d0
    jmp     _Scroller_SetTiltSprite_End

_Scroller_SetTiltSprite_U1:
    cmp.w   #TILT_U1,_Scroller_Tilt
    bge     _Scroller_SetTiltSprite_U2
    move.w  #VicViper_U1_TileID,d0
    jmp     _Scroller_SetTiltSprite_End

_Scroller_SetTiltSprite_U2:
    cmp.w   #TILT_U2,_Scroller_Tilt
    bge     _Scroller_SetTiltSprite_U3
    move.w  #VicViper_U2_TileID,d0
    jmp     _Scroller_SetTiltSprite_End

_Scroller_SetTiltSprite_U3:
    cmp.w   #TILT_U3,_Scroller_Tilt
    bge     _Scroller_SetTiltSprite_U4
    move.w  #VicViper_U3_TileID,d0
    jmp     _Scroller_SetTiltSprite_End

_Scroller_SetTiltSprite_U4:
    cmp.w   #TILT_U4,_Scroller_Tilt
    ble     _Scroller_SetTiltSprite_NoCap
    move.w  #TILT_MAX,_Scroller_Tilt ; Kappa
_Scroller_SetTiltSprite_NoCap:
    move.w  #VicViper_U4_TileID,d0
    jmp     _Scroller_SetTiltSprite_End

_Scroller_SetTiltSprite_End:
    move.l  #VDP_SPRITE_TABLE,-(sp)
    move.w  d0,-(sp)
    jsr     VDP_SetSprite_TileID
    addq.l  #VDP_SET_SPRITE_TILE_ID_ALIGN,sp

    rts

_Scroller_HandleController:
    subq.w  #1,_Scroller_Player_Speed_Delay
    cmpi.w  #0,_Scroller_Player_Speed_Delay
    beq     _Scroller_HandleController_ShouldUpdate
    rts
_Scroller_HandleController_ShouldUpdate:

    jsr     _Scroller_TiltDecay

    move.w  #PLAYER_SPEED_DELAY,_Scroller_Player_Speed_Delay
    cmp.w   #VDP_SPRITE_Y_MIN,_Scroller_PlayerYPos
    ble     _Scroller_TestController_IsMinY
    jsr     _Scroller_TestController_Up
    
_Scroller_TestController_IsMinY:
    cmp.w  #VDP_SPRITE_Y_MAX_32-PLAYER_HEIGHT,_Scroller_PlayerYPos
    bge     _Scroller_TestController_IsMaxY
    jsr     _Scroller_TestController_Down
_Scroller_TestController_IsMaxY:
    cmp.w  #VDP_SPRITE_X_MIN,_Scroller_PlayerXPos
    ble     _Scroller_TestController_IsXMin
    jsr     _Scroller_TestController_Left
_Scroller_TestController_IsXMin:
    cmp.w  #VDP_SPRITE_X_MAX_40-PLAYER_WIDTH,_Scroller_PlayerXPos
    bge     _Scroller_TestController_IsXMax
    jsr     _Scroller_TestController_Right
_Scroller_TestController_IsXMax:
    rts

_Scroller_TestController_Up
    btst    #CTRL_UP,_Scroller_Ctrl_Last
    bne     _Scroller_TestController_Up_End 
    subq.w  #1,_Scroller_PlayerYPos
    addq.w  #1,_Scroller_Tilt
_Scroller_TestController_Up_End:
    rts

_Scroller_TestController_Down:
    btst    #CTRL_DOWN,_Scroller_Ctrl_Last
    bne     _Scroller_TestController_Down_End
    addq.w  #1,_Scroller_PlayerYPos
    subq.w  #1,_Scroller_Tilt
_Scroller_TestController_Down_End:
    rts

_Scroller_TestController_Left:
    btst    #CTRL_LEFT,_Scroller_Ctrl_Last
    bne     _Scroller_TestController_Left_End
    subq.w  #1,_Scroller_PlayerXPos
_Scroller_TestController_Left_End:
    rts

_Scroller_TestController_Right:
    btst    #CTRL_RIGHT,_Scroller_Ctrl_Last
    bne     _Scroller_TestController_Right_End
    addq.w  #1,_Scroller_PlayerXPos
_Scroller_TestController_Right_End:
    rts

_Scroller_Update_BG:
    ; Disable Auto Increment
    move.l  #0,-(sp)
    jsr     VDP_SetAutoIncrement
    addq.l  #VDP_SET_AUTO_INCREMENT_ALIGN,sp
    ; Move BG
    subq.w  #1,_Scroller_HScroll_Delay
    cmpi.w  #0,_Scroller_HScroll_Delay
    bne     _Scroller_Update_HScroll_Skip
    ; Update BG
    move.l  #VDP_H_SCROLL_TABLE,-(sp)
    jsr     VDP_WriteVramMode
    addq.l  #VDP_WRITE_VRAM_MODE_ALIGN,sp
    ; Decrement Scroll
    subq.w  #1,_Scroller_HScroll
    move.w  _Scroller_HScroll,VDP_DATA_PORT
    ; Reset Delay
    move.w  #HSCROLL_DELAY,_Scroller_HScroll_Delay
_Scroller_Update_HScroll_Skip:
    rts

_Scroller_Update_Player:
    ; Update Player Position
    ; Ecks
    move.l  #VDP_SPRITE_TABLE,-(sp)
    move.w  _Scroller_PlayerXPos,-(sp)
    jsr     VDP_SetSpriteX
    addq.l  #VDP_SET_SPRITE_X_ALIGN,sp
    ; Why
    move.l  #VDP_SPRITE_TABLE,-(sp)
    move.w  _Scroller_PlayerYPos,-(sp)
    jsr     VDP_SetSpriteY
    addq.l  #VDP_SET_SPRITE_Y_ALIGN,sp
    rts

_Scroller_SetupBG:
    ; Load the palette
    pea     PCB_Palette
    move.l  #$0020,-(sp)
    jsr     VDP_LoadPalette
    addq.l  #VDP_LOAD_PALETTE_ALIGN,sp
    ; Load Tiles
    pea     PCB_TilesStart
    move.l  #PCB_TilesSizeT,-(sp)
    move.l  #PCB_TilesVRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Draw onto Plane A 
    move.l  #VDP_SCROLL_TABLE_A,-(sp)
    jsr     PCB_DrawRow
    addq.l  #4,sp
    move.l  #VDP_SCROLL_TABLE_A+$400,-(sp)
    jsr     PCB_DrawRow
    addq.l  #4,sp
    move.l  #VDP_SCROLL_TABLE_A+$800,-(sp)
    jsr     PCB_DrawRow
    addq.l  #4,sp
    move.l  #VDP_SCROLL_TABLE_A+$C00,-(sp)
    jsr     PCB_DrawRow
    addq.l  #4,sp
    rts

_Scroller_SetupVicViper:
    ; Send Palette
    pea     VicViper_Palette
    move.l  #$0040,-(sp) 
    jsr     VDP_LoadPalette
    addq.l  #VDP_LOAD_PALETTE_ALIGN,sp
    ; Send C Tiles
    pea     VicViper_C_Tiles_Start
    move.l  #VicViper_C_SizeT,-(sp)
    move.l  #VicViper_C_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Send D1 Tiles
    pea     VicViper_D1_Tiles_Start
    move.l  #VicViper_D1_SizeT,-(sp)
    move.l  #VicViper_D1_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Send D2 Tiles
    pea     VicViper_D2_Tiles_Start
    move.l  #VicViper_D2_SizeT,-(sp)
    move.l  #VicViper_D2_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Send D3 Tiles
    pea     VicViper_D3_Tiles_Start
    move.l  #VicViper_D3_SizeT,-(sp)
    move.l  #VicViper_D3_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Send D4 Tiles
    pea     VicViper_D4_Tiles_Start
    move.l  #VicViper_D4_SizeT,-(sp)
    move.l  #VicViper_D4_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Send U1 Tiles
    pea     VicViper_U1_Tiles_Start
    move.l  #VicViper_U1_SizeT,-(sp)
    move.l  #VicViper_U1_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Send U2 Tiles
    pea     VicViper_U2_Tiles_Start
    move.l  #VicViper_U2_SizeT,-(sp)
    move.l  #VicViper_U2_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Send U3 Tiles
    pea     VicViper_U3_Tiles_Start
    move.l  #VicViper_U3_SizeT,-(sp)
    move.l  #VicViper_U3_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Send U4 Tiles
    pea     VicViper_U4_Tiles_Start
    move.l  #VicViper_U4_SizeT,-(sp)
    move.l  #VicViper_U4_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Load Sprite Desc
    pea     VicViper_C_SpriteDescriptor
    jsr     VDP_LoadSprite
    addq.l  #VDP_LOAD_SPRITE_ALIGN,sp
    ; Return
    rts

_Scroller_HScroll               equ RAM_START
_Scroller_PlayerXPos            equ RAM_START+2
_Scroller_PlayerYPos            equ RAM_START+4
_Scroller_Tilt                  equ RAM_START+8
_Scroller_Ctrl_Last             equ RAM_START+12
_Scroller_HScroll_Delay         equ RAM_START+16
_Scroller_Player_Speed_Delay    equ RAM_START+20

HSCROLL_DELAY           equ  $000F
PLAYER_SPEED_DELAY      equ  $000A
PLAYER_WIDTH            equ  24
PLAYER_HEIGHT           equ  16

TILT_WAIT               equ  8
TILT_MIN                equ  1

TILT_D4                 equ  1*TILT_WAIT
TILT_D3                 equ  2*TILT_WAIT
TILT_D2                 equ  3*TILT_WAIT
TILT_D1                 equ  4*TILT_WAIT
TILT_C                  equ  5*TILT_WAIT
TILT_U1                 equ  6*TILT_WAIT
TILT_U2                 equ  7*TILT_WAIT
TILT_U3                 equ  8*TILT_WAIT
TILT_U4                 equ  9*TILT_WAIT
TILT_MAX                equ TILT_U4

__end    ; Very last line, end of ROM address
