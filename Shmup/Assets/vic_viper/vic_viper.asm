;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

; Order in VRAM
;   C   = $0F40
;   D1
;   D2
;   D3
;   D4
;   U1
;   U2
;   U3
;   U4

    ; Colour Palette
    include "../Shmup/Assets/vic_viper/Palette.asm"
    ; Centre Frame
    include "../Shmup/Assets/vic_viper/C.asm"
    ; Down Frames
    include "../Shmup/Assets/vic_viper/D1.asm"
    include "../Shmup/Assets/vic_viper/D2.asm"
    include "../Shmup/Assets/vic_viper/D3.asm"
    include "../Shmup/Assets/vic_viper/D4.asm"
    ; Up Frames
    include "../Shmup/Assets/vic_viper/U1.asm"
    include "../Shmup/Assets/vic_viper/U2.asm"
    include "../Shmup/Assets/vic_viper/U3.asm"
    include "../Shmup/Assets/vic_viper/U4.asm"

VicViper_Load_Asset:
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


