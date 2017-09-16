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

VDP_DATA_PORT           equ $00C00000
VDP_CTRL_PORT           equ $00C00004
VDP_HV_COUNTER          equ $00C00008
VDP_SN76489_PSG         equ $00C00011

VDPREG_MODE_1                   equ $00
VDPREG_MODE_2                   equ $01
VDPREG_PLN_A_NAME_TBL_LOC       equ $02
VDPREG_WINDOW_NAME_TBL_LOC      equ $03
VDPREG_PLN_B_NAME_TBL_LOC       equ $04
VDPREG_SPRITE_TBL_LOC           equ $05
VDPREG_SPRITE_PTN_GEN_BASE_ADDR equ $06
VDPREG_BG_COLOUR                equ $07
VDPREG_UNUSED_1                 equ $08
VDPREG_UNUSED_2                 equ $09
VDPREG_H_INT_CNTR               equ $0A
VDPREG_MODE_REG_3               equ $0B
VDPREG_MODE_REG_4               equ $0C
VDPREG_H_SCROLL_DATA_LOC        equ $0D
VDPREG_NAME_TBL_PTRN_GEN_BASE   equ $0E
VDPREG_AUTO_INCREMENT           equ $0F
VDPREG_PLANE_SIZE               equ $10
VDPREG_WINDOW_PLANE_H_POS       equ $11
VDPREG_WINDOW_PLANE_V_POS       equ $12
VDPREG_DMA_LENGTH_1             equ $13
VDPREG_DMA_LENGTH_2             equ $14
VDPREG_DMA_SRC_1                equ $15
VDPREG_DMA_SRC_2                equ $16
VDPREG_DMA_SRC_3                equ $17

