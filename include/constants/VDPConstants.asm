;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk
;
; VDPConstants.asm - Useful VDP Definitions
;
;   See http://md.squee.co/VDP
;

VDP_DATA_PORT                    equ $00C00000
VDP_CTRL_PORT                    equ $00C00004
VDP_HV_COUNTER                   equ $00C00008
VDP_SN76489_PSG                  equ $00C00011

VDP_REG_MODE_1                   equ $00
VDP_REG_MODE_2                   equ $01
VDP_REG_PLN_A_NAME_TBL_LOC       equ $02
VDP_REG_WINDOW_NAME_TBL_LOC      equ $03
VDP_REG_PLN_B_NAME_TBL_LOC       equ $04
VDP_REG_SPRITE_TBL_LOC           equ $05
VDP_REG_SPRITE_PTN_GEN_BASE_ADDR equ $06
VDP_REG_BG_COLOUR                equ $07
VDP_REG_UNUSED_1                 equ $08
VDP_REG_UNUSED_2                 equ $09
VDP_REG_H_INT_CNTR               equ $0A
VDP_REG_MODE_REG_3               equ $0B
VDP_REG_MODE_REG_4               equ $0C
VDP_REG_H_SCROLL_DATA_LOC        equ $0D
VDP_REG_NAME_TBL_PTRN_GEN_BASE   equ $0E
VDP_REG_AUTO_INCREMENT           equ $0F
VDP_REG_PLANE_SIZE               equ $10
VDP_REG_WINDOW_PLANE_H_POS       equ $11
VDP_REG_WINDOW_PLANE_V_POS       equ $12
VDP_REG_DMA_LENGTH_1             equ $13
VDP_REG_DMA_LENGTH_2             equ $14
VDP_REG_DMA_SRC_1                equ $15
VDP_REG_DMA_SRC_2                equ $16
VDP_REG_DMA_SRC_3                equ $17

VDP_VRAM_READ                    equ $00
VDP_VRAM_WRITE                   equ $01
VDP_CRAM_READ                    equ $08
VDP_CRAM_WRITE                   equ $03
VDP_VSRAM_READ                   equ $04
VDP_VSRAM_WRITE                  equ $05

VDP_SPRITE_X_MIN                 equ $80
VDP_SPRITE_X_MAX_32              equ $17F
VDP_SPRITE_X_MAX_40              equ $1BF
VDP_SPRITE_WIDTH                 equ VDP_SPRITE_X_MAX_40-VDP_SPRITE_X_MIN

VDP_SPRITE_Y_MIN                 equ $80
VDP_SPRITE_Y_MAX_32              equ $15F
VDP_SPRITE_Y_MAX_40              equ $16F
VDP_SPRITE_HEIGHT                equ VDP_SPRITE_Y_MAX_40-VDP_SPRITE_Y_MIN

VDP_FIRST_SPRITE                 equ $60000003

; VDP Tables
VDP_SCROLL_TABLE_A               equ $C000
VDP_SCROLL_TABLE_B               equ $E000
VDP_WINDOW_TABLE                 equ $0000
VDP_SPRITE_TABLE                 equ $F000
VDP_H_SCROLL_TABLE               equ $FC00

; Palette offsets
VDP_PALETTE_0   equ $0000
VDP_PALETTE_1   equ $0020
VDP_PALETTE_2   equ $0040
VDP_PALETTE_3   equ $0060
