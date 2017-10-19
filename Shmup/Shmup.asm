;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Shmup.asm 
;       - Scrolling Shmup type demo with ripped assets.
;           - PCB - MacOS 7.5
;           - VicViper (Parodius DA)
  
; Includes
    include "../include/Header.asm"
    include "../Shmup/Assets/pcb/pcb.asm"
    include "../Shmup/Assets/vic_viper/vic_viper.asm"
    include "../Shmup/Assets/projectile/projectile.asm"
    include "../Shmup/Intro.asm"
    include "../Shmup/HUD.asm"

__GameMain:
    jsr     _Shmup_Intro

_Shmup_Setup:
    jsr     _Shmup_SetupBG
    jsr     _Shmup_Setup_VicViper
    jsr     _Shmup_Setup_Projectiles
    jsr     _Shmup_InitCounters
    jsr     _Shmup_HUD_Setup

_Shmup_Loop:
    jsr     CtrlReadPad1D0
    move.b  d0,_Shmup_Ctrl_Last_W
    jsr     _Shmup_HandleController_Dpad
    jsr     _Shmup_HandleController_Buttons
    jsr     _Shmup_SetTiltSprite
    ; Wait for VBlank
    jsr     VDP_WaitVBlankStart
    jsr     _Shmup_Update_BG
    jsr     _Shmup_Update_Player
    jsr     _Shmup_Update_Projectiles
    jsr     VDP_WaitVBlankEnd
    jmp     _Shmup_Loop

; Subroutines ------------------------------------------------------------------

_Shmup_Update_Projectiles:
    ; Init Loop Counter
    move.w  #PROJECTILES_MAX,d7
    subq.w  #1,d7
_Shmup_Update_Projectiles_ShouldUpdate_Next:
    ; Stash Loop Counter
    move.w  d7,-(sp)
    ; Get the struct address
    movea.l #_Shmup_Projectile_Array,a0 
    mulu.w  #PROJECTILE_STRUCT_SIZE,d7
    add.w   d7,a0
    ; Check if active
    cmpi.w  #TRUE,PROJECTILE_STRUCT_ACTIVE_W(a0)
    bne     _Shmup_Update_Projectiles_Skip
    ; Get vdp sprite table address from index
    move.w  PROJECTILE_STRUCT_SPRITE_ID_W(a0),d0
    mulu.w  #8,d0
    add.l   #VDP_SPRITE_TABLE,d0
    ; Increment x value and compare
    move.w  PROJECTILE_STRUCT_X_W(a0),d2
    add.w   PROJECTILE_STRUCT_X_VEL_W(a0),d2
    move.w  d2,PROJECTILE_STRUCT_X_W(a0)
    ; Test if off screen
    cmpi.w  #VDP_SPRITE_X_MAX_40,PROJECTILE_STRUCT_X_W(a0)
    blt     _Shmup_Update_Projectiles_XPos
    ; Move off screen and deactivate
    move.w  #0,PROJECTILE_STRUCT_X_W(a0)
    move.w  #0,PROJECTILE_STRUCT_Y_W(a0)
    move.w  #FALSE,PROJECTILE_STRUCT_ACTIVE_W(a0)
_Shmup_Update_Projectiles_XPos:
    ; Stash vram and struct address before function
    movem.l d0/a0,-(sp)
    ; Copy projectile X position to VDP
    move.l  d0,-(sp) 
    move.w  PROJECTILE_STRUCT_X_W(a0),-(sp)
    jsr     VDP_SetSpriteX
    addq.l  #VDP_SET_SPRITE_X_ALIGN,sp
    ; Unstash 
    movem.l (sp)+,d0/a0
    ; Increment y value and compare
    move.w  PROJECTILE_STRUCT_Y_W(a0),d2
    add.w   PROJECTILE_STRUCT_Y_VEL_W(a0),d2
    move.w  d2,PROJECTILE_STRUCT_Y_W(a0)
    ; Test if off screen
    cmpi.w  #VDP_SPRITE_Y_MAX_40,PROJECTILE_STRUCT_Y_W(a0)
    blt     _Shmup_Update_Projectiles_YPos
    ; Move off screen and deactivate
    move.w  #0,PROJECTILE_STRUCT_X_W(a0)
    move.w  #0,PROJECTILE_STRUCT_Y_W(a0)
    move.w  #FALSE,PROJECTILE_STRUCT_ACTIVE_W(a0)
_Shmup_Update_Projectiles_YPos:
    ; Set Y Position
    move.l  d0,-(sp) 
    move.w  PROJECTILE_STRUCT_Y_W(a0),-(sp)
    jsr     VDP_SetSpriteY
    addq.l  #VDP_SET_SPRITE_Y_ALIGN,sp
_Shmup_Update_Projectiles_Skip:
    ; Restore Loop Counter
    move.w  (sp)+,d7
    dbra    d7,_Shmup_Update_Projectiles_ShouldUpdate_Next
    rts

_Shmup_InitCounters:
    move.w  #$0000,_Shmup_HScroll_W
    move.w  #VDP_SPRITE_X_MIN+8,_Shmup_PlayerXPos_W
    move.w  #(VDP_SPRITE_HEIGHT/2)+VDP_SPRITE_Y_MIN-8,_Shmup_PlayerYPos_W
    move.w  #TILT_C,_Shmup_Tilt_W
    move.w  #PROJECTILE_INTERVAL,_Shmup_Projectile_Interval_W
    rts

_Shmup_TiltDecay:
    btst    #CTRL_UP,_Shmup_Ctrl_Last_W
    beq     _Shmup_TiltDecay_Done
    btst    #CTRL_DOWN,_Shmup_Ctrl_Last_W
    beq     _Shmup_TiltDecay_Done
    cmp.w   #TILT_C,_Shmup_Tilt_W    
    bgt     _Shmup_TiltDecay_TooHigh
    blt     _Shmup_TiltDecay_TooLow
    jmp     _Shmup_TiltDecay_Done
_Shmup_TiltDecay_TooHigh:
    subq.w  #1,_Shmup_Tilt_W
    jmp _Shmup_TiltDecay_Done
_Shmup_TiltDecay_TooLow:
    addq.w  #1,_Shmup_Tilt_W
    jmp _Shmup_TiltDecay_Done
_Shmup_TiltDecay_Done:
    rts

_Shmup_SetTiltSprite:

_Shmup_SetTiltSprite_D4:
    cmp.w   #TILT_D4,_Shmup_Tilt_W
    bge     _Shmup_SetTiltSprite_D3
    move.w  #VicViper_D4_TileID,d0
    cmp.w   #TILT_MIN,_Shmup_Tilt_W
    bge     _Shmup_SetTiltSprite_NoMin
    move.w  #TILT_MIN,_Shmup_Tilt_W
_Shmup_SetTiltSprite_NoMin:
    jmp     _Shmup_SetTiltSprite_End
    
_Shmup_SetTiltSprite_D3:
    cmp.w   #TILT_D3,_Shmup_Tilt_W
    bge     _Shmup_SetTiltSprite_D2
    move.w  #VicViper_D3_TileID,d0
    jmp     _Shmup_SetTiltSprite_End

_Shmup_SetTiltSprite_D2:
    cmp.w   #TILT_D2,_Shmup_Tilt_W
    bge     _Shmup_SetTiltSprite_D1
    move.w  #VicViper_D2_TileID,d0
    jmp     _Shmup_SetTiltSprite_End

_Shmup_SetTiltSprite_D1:
    cmp.w   #TILT_D1,_Shmup_Tilt_W
    bge     _Shmup_SetTiltSprite_C
    move.w  #VicViper_D1_TileID,d0
    jmp     _Shmup_SetTiltSprite_End

_Shmup_SetTiltSprite_C:
    cmp.w   #TILT_C,_Shmup_Tilt_W
    bge     _Shmup_SetTiltSprite_U1
    move.w  #VicViper_C_TileID,d0
    jmp     _Shmup_SetTiltSprite_End

_Shmup_SetTiltSprite_U1:
    cmp.w   #TILT_U1,_Shmup_Tilt_W
    bge     _Shmup_SetTiltSprite_U2
    move.w  #VicViper_U1_TileID,d0
    jmp     _Shmup_SetTiltSprite_End

_Shmup_SetTiltSprite_U2:
    cmp.w   #TILT_U2,_Shmup_Tilt_W
    bge     _Shmup_SetTiltSprite_U3
    move.w  #VicViper_U2_TileID,d0
    jmp     _Shmup_SetTiltSprite_End

_Shmup_SetTiltSprite_U3:
    cmp.w   #TILT_U3,_Shmup_Tilt_W
    bge     _Shmup_SetTiltSprite_U4
    move.w  #VicViper_U3_TileID,d0
    jmp     _Shmup_SetTiltSprite_End

_Shmup_SetTiltSprite_U4:
    cmp.w   #TILT_U4,_Shmup_Tilt_W
    ble     _Shmup_SetTiltSprite_NoCap
    move.w  #TILT_MAX,_Shmup_Tilt_W ; Kappa
_Shmup_SetTiltSprite_NoCap:
    move.w  #VicViper_U4_TileID,d0
    jmp     _Shmup_SetTiltSprite_End

_Shmup_SetTiltSprite_End:
    move.l  #VDP_SPRITE_TABLE,-(sp)
    move.w  d0,-(sp)
    jsr     VDP_SetSprite_TileID
    addq.l  #VDP_SET_SPRITE_TILE_ID_ALIGN,sp
    rts

_Shmup_HandleController_Buttons:
    cmpi.w   #0,_Shmup_Projectile_Interval_W
    beq     _Shmup_HandleController_Buttons_ProjectileIntervalPassed
    subq.w   #1,_Shmup_Projectile_Interval_W
    rts 
_Shmup_HandleController_Buttons_ProjectileIntervalPassed:
    btst    #CTRL_A,_Shmup_Ctrl_Last_W
    bne     _Shmup_HandleController_Buttons_End
    ; Setup Counter
    move.w  #PROJECTILES_MAX,d7
    subq.w  #1,d7
_Shmup_HandleController_Buttons_Next:
    ; Activate Projectile
    move.w  d7,d6
    mulu.w  #PROJECTILE_STRUCT_SIZE,d6
    movea.l #_Shmup_Projectile_Array,a0
    add.w   d6,a0
    ; Check if active
    cmp.w   #TRUE,PROJECTILE_STRUCT_ACTIVE_W(a0)
    beq     _Shmup_HandleController_Buttons_IsActive
    ; Not active
    move.w  #TRUE,PROJECTILE_STRUCT_ACTIVE_W(a0)
    ; Update Position
    move.w  _Shmup_PlayerXPos_W,PROJECTILE_STRUCT_X_W(a0)
    add.w   #PLAYER_WIDTH/2,PROJECTILE_STRUCT_X_W(a0)
    move.w  _Shmup_PlayerYPos_W,PROJECTILE_STRUCT_Y_W(a0)
    add.w   #(PLAYER_HEIGHT/2)-4,PROJECTILE_STRUCT_Y_W(a0)
    move.w  #PROJECTILE_DEFAULT_VEL_X,PROJECTILE_STRUCT_X_VEL_W(a0)
    move.w  #PROJECTILE_DEFAULT_VEL_Y,PROJECTILE_STRUCT_Y_VEL_W(a0)
    ; Put projectile interval
    move.w  #PROJECTILE_INTERVAL,_Shmup_Projectile_Interval_W
    jmp _Shmup_HandleController_Buttons_End
_Shmup_HandleController_Buttons_IsActive:
    dbra d7,_Shmup_HandleController_Buttons_Next
_Shmup_HandleController_Buttons_End:
    rts

_Shmup_HandleController_Dpad:
    jsr     _Shmup_TiltDecay
    cmp.w   #VDP_SPRITE_Y_MIN,_Shmup_PlayerYPos_W
    ble     _Shmup_TestController_IsMinY
    jsr     _Shmup_TestController_Up
    
_Shmup_TestController_IsMinY:
    cmp.w  #VDP_SPRITE_Y_MAX_32-PLAYER_HEIGHT,_Shmup_PlayerYPos_W
    bge     _Shmup_TestController_IsMaxY
    jsr     _Shmup_TestController_Down
_Shmup_TestController_IsMaxY:
    cmp.w  #VDP_SPRITE_X_MIN,_Shmup_PlayerXPos_W
    ble     _Shmup_TestController_IsXMin
    jsr     _Shmup_TestController_Left
_Shmup_TestController_IsXMin:
    cmp.w  #VDP_SPRITE_X_MAX_40-PLAYER_WIDTH,_Shmup_PlayerXPos_W
    bge     _Shmup_TestController_IsXMax
    jsr     _Shmup_TestController_Right
_Shmup_TestController_IsXMax:
    rts

_Shmup_TestController_Up
    btst    #CTRL_UP,_Shmup_Ctrl_Last_W
    bne     _Shmup_TestController_Up_End 
    subq.w  #PLAYER_VEL,_Shmup_PlayerYPos_W
    addq.w  #1,_Shmup_Tilt_W
_Shmup_TestController_Up_End:
    rts

_Shmup_TestController_Down:
    btst    #CTRL_DOWN,_Shmup_Ctrl_Last_W
    bne     _Shmup_TestController_Down_End
    addq.w  #PLAYER_VEL,_Shmup_PlayerYPos_W
    subq.w  #1,_Shmup_Tilt_W
_Shmup_TestController_Down_End:
    rts

_Shmup_TestController_Left:
    btst    #CTRL_LEFT,_Shmup_Ctrl_Last_W
    bne     _Shmup_TestController_Left_End
    subq.w  #PLAYER_VEL,_Shmup_PlayerXPos_W
_Shmup_TestController_Left_End:
    rts

_Shmup_TestController_Right:
    btst    #CTRL_RIGHT,_Shmup_Ctrl_Last_W
    bne     _Shmup_TestController_Right_End
    addq.w  #PLAYER_VEL,_Shmup_PlayerXPos_W
_Shmup_TestController_Right_End:
    rts

_Shmup_Update_BG:
    ; Disable Auto Increment
    move.l  #0,-(sp)
    jsr     VDP_SetAutoIncrement
    addq.l  #VDP_SET_AUTO_INCREMENT_ALIGN,sp
    ; Move BG
    ; Update BG
    move.l  #VDP_H_SCROLL_TABLE,-(sp)
    jsr     VDP_WriteVramMode
    addq.l  #VDP_WRITE_VRAM_MODE_ALIGN,sp
    ; Decrement Scroll
    subq.w  #1,_Shmup_HScroll_W
    move.w  _Shmup_HScroll_W,VDP_DATA_PORT
    rts

_Shmup_Update_Player:
    ; Update Player Position
    ; X
    move.l  #VDP_SPRITE_TABLE,-(sp)
    move.w  _Shmup_PlayerXPos_W,-(sp)
    jsr     VDP_SetSpriteX
    addq.l  #VDP_SET_SPRITE_X_ALIGN,sp
    ; Y 
    move.l  #VDP_SPRITE_TABLE,-(sp)
    move.w  _Shmup_PlayerYPos_W,-(sp)
    jsr     VDP_SetSpriteY
    addq.l  #VDP_SET_SPRITE_Y_ALIGN,sp
    rts

_Shmup_SetupBG:
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

_Shmup_Setup_Projectiles:
    ; Send Tiles
    pea     Projectile_Tiles_Start
    move.l  #Projectile_SizeT,-(sp)
    move.l  #Projectile_VRAM,-(sp)
    jsr     VDP_LoadTiles
    add.l   #VDP_LOAD_TILES_ALIGN,sp
    ; Setup for loop
    move.w  #PROJECTILES_MAX,d7
    subq.w  #1,d7
_Shmup_Setup_Projectiles_Next:
    ; Stash Loop Index
    move.w  d7,-(sp)
    move.w  d7,d6   ; Hold working value in d6 for addr
    move.w  d7,d5   ; Hold working value in d5 for ID
    addq.w  #1,d5   ; Go from PROJECTILES_MAX to 1 rather than 0.
    move.w  d5,d4
    addq.w  #1,d4   ; next linked sprite index
    cmp.w   #PROJECTILES_MAX+1,d4
    bne     _Shmup_Setup_Projectiles_Next_Load
    move.w  #0,d4 ; Set link of last sprite to 0
_Shmup_Setup_Projectiles_Next_Load:
    ; Load Sprite Desc
    pea     Projectile_SpriteDescriptor
    move.w  d5,-(sp)
    move.w  d4,-(sp)
    jsr     VDP_LoadSprite
    addq.l  #VDP_LOAD_SPRITE_ALIGN,sp
    ; Setup sprite struct ram address
    movea.l #_Shmup_Projectile_Array,a0 
    mulu.w  #PROJECTILE_STRUCT_SIZE,d6
    add.w   d6,a0
    ; Set Projectile Struct RAM
    move.w  d5,PROJECTILE_STRUCT_SPRITE_ID_W(a0)
    move.w  #0,PROJECTILE_STRUCT_X_W(a0)
    move.w  #0,PROJECTILE_STRUCT_Y_W(a0)
    move.w  #0,PROJECTILE_STRUCT_X_VEL_W(a0)
    move.w  #0,PROJECTILE_STRUCT_Y_VEL_W(a0)
    move.w  #FALSE,PROJECTILE_STRUCT_ACTIVE_W(a0)
    ; Restore Loop Index
    move.w  (sp)+,d7
    dbra    d7,_Shmup_Setup_Projectiles_Next
    rts

_Shmup_Setup_VicViper:
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
    move.w  #0,-(sp)
    move.w  #1,-(sp)
    jsr     VDP_LoadSprite
    addq.l  #VDP_LOAD_SPRITE_ALIGN,sp
    ; Return
    rts

_Shmup_HScroll_W                equ RAM_START
_Shmup_PlayerXPos_W             equ RAM_START+$2
_Shmup_PlayerYPos_W             equ RAM_START+$4
_Shmup_Tilt_W                   equ RAM_START+$6
_Shmup_Ctrl_Last_W              equ RAM_START+$8
_Shmup_Projectile_Interval_W    equ RAM_START+$A
_Shmup_Projectile_Array         equ RAM_START+$C

PROJECTILE_INTERVAL     equ  1
PROJECTILES_MAX         equ  16
PLAYER_WIDTH            equ  24
PLAYER_HEIGHT           equ  16
PLAYER_VEL              equ  2 

TILT_WAIT               equ  3
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
TILT_MAX                equ     TILT_U4

TRUE                    equ $1111
FALSE                   equ $FFFF

PROJECTILE_DEFAULT_VEL_X      equ 16
PROJECTILE_DEFAULT_VEL_Y      equ 0

__end    ; Very last line, end of ROM address
