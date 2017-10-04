;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   PCB.asm 
;      - More fun with the VDP
  
; Includes
    include "../include/Header.asm"
    include "../include/VDP.asm"
    include "../include/Controller.asm"
    include "../include/Text.asm"
    include "../Assets/pcb/pcb.asm"
    include "../Assets/vic_viper/vic_viper.asm"

__GameMain:
    ; Set background colour to palette 0, colour 8
    move.w  #$8700,VDP_CTRL_PORT  
    jsr PCBPushPalette
    jsr PCBLoadTiles

    move.l  #VDP_SCROLL_TABLE_A,a6

    move.l  a6,-(sp)
    jsr     PCBDrawRow
    movea.l  (sp)+,a6

    add.l   #$400,a6
    move.l  a6,-(sp)
    jsr     PCBDrawRow
    movea.l  (sp)+,a6

    add.l   #$400,a6
    move.l  a6,-(sp)
    jsr     PCBDrawRow
    movea.l  (sp)+,a6
    add.l   #$400,a6

    move.l  a6,-(sp)
    jsr     PCBDrawRow
    movea.l  (sp)+,a6

    move.w  #0,HScrollPtr
    move.w  #0,VScrollPtr

Loop:
    jsr     CtrlReadPad1D0

    btst    #CTRL_UP,d0
    bne     Loop_NoUp 
    sub.w   #1,VScrollPtr
Loop_NoUp:
    btst    #CTRL_DOWN,d0
    bne     Loop_NoDown
    add.w   #1,VScrollPtr
Loop_NoDown:
    btst    #CTRL_LEFT,d0
    bne     Loop_NoLeft
    add.w   #1,HScrollPtr
Loop_NoLeft:
    btst    #CTRL_RIGHT,d0
    bne     Loop_NoRight
    sub.w   #1,HScrollPtr
Loop_NoRight:

    ; Disable Auto Increment
    move.l  #0,-(sp)
    jsr     _VDPSetAutoIncrement
    addq.l  #4,sp
    ; Update H
    move.l  #VDP_H_SCROLL_TABLE,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    jsr     _VDPWaitVBlankEnd
    move.w  HScrollPtr,VDP_DATA_PORT
    ; Update V 
    move.l  #0,-(sp)
    jsr     _VDPWriteVSramMode
    addq.l  #4,sp
    jsr     _VDPWaitVBlankEnd
    move.w  VScrollPtr,VDP_DATA_PORT
    ; Wait value
    move.w  #$08FF,d0
Loop_Wait:
    dbra    d0,Loop_Wait
    jmp     Loop

__end    ; Very last line, end of ROM address

HScrollPtr  equ RAM_START
VScrollPtr  equ RAM_START+2
