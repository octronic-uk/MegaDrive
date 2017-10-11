;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk
;
_Shmup_HUD_Setup:
    move.w  #0,_Shmup_HUD_Score_W
_Shmup_HUD_Setup_Sprites:
    move.l  #VDP_SPRITE_Y_MIN,-(sp)             ; Y
    move.l  #$0000,-(sp)                        ; Size 
    move.l  #PROJECTILES_MAX+2,-(sp)            ; Link
    move.l  #0000,-(sp)                         ; HVPP
    move.l  #_PixelFontTileID,-(sp)             ; First Tile
    move.l  #VDP_SPRITE_X_MIN,-(sp)             ; X
    move.l  #_Shmup_HUD_Sprite_Scratch_2L,-(sp) ; Address
    jsr     VDP_CreateSprite
    add.l   #VDP_CREATE_SPRITE_ALIGN,sp
    rts

_Shmup_HUD_Score_W            equ    _Shmup_Projectile_Array+(PROJECTILE_STRUCT_SIZE*PROJECTILES_MAX)
_Shmup_HUD_Sprite_Scratch_2L  equ    _Shmup_HUD_Score_W+2 ; this is 32 bytes (2long)

