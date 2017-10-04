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

__GameMain:
    ; Set background colour to palette 0, colour 8
    move.w  #$8700,VDP_CTRL_PORT  
    jsr PCBPushPalette
    jsr PCBLoadTiles

    move.l  #$C000,-(sp)
    jsr     DrawPcbRow
    addq.l  #4,sp
    
    move.l  #$C400,-(sp)
    jsr     DrawPcbRow
    addq.l  #4,sp

    move.l  #$C800,-(sp)
    jsr     DrawPcbRow
    addq.l  #4,sp

    move.l  #$CC00,-(sp)
    jsr     DrawPcbRow
    addq.l  #4,sp


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
    move.w  #$02FF,d0
Loop_Wait:
    dbra    d0,Loop_Wait
    jmp     Loop

DrawPcbRow:
    move.l  4(sp),a0 ; Get start address into a0
    move.l  a0,a1    ; Setup End Address in a1
    add.l   #$80,a1  ; to be a0 + $60
DrawPcbRowLoop:
    movem.l  d0/a0-a1,-(sp) ; Cache Registers
    move.l  a0,-(sp)        ; Push Address Param
    jsr     PCBOnPlaneA     ; Draw PCB
    addq.l  #4,sp           ; Correct Stack
    movem.l  (sp)+,d0/a0-a1 ; Restore Registers
    add.l   #$10,a0         ; Add 16 to draw address
    cmp.l   a0,a1           ; Compare with limit
    bgt     DrawPcbRowLoop  ; Are we there yet?
    rts

DrawOnPlaneB:
    move.l  #2,-(sp)
    jsr     _VDPSetAutoIncrement
    addq.l  #4,sp
    pea     EXCEPTION_STRING        ; String
    move.l  #_PixelFontTileID,-(sp) ; First font tile
    move.l  #$0000,-(sp)            ; X,Y
    move.l  #$0,-(sp)               ; Palette Index
    jsr     _TextOnPlaneB
    add.l   #16,sp
    rts  

__end    ; Very last line, end of ROM address

HScrollPtr  equ RAM_START
VScrollPtr  equ RAM_START+2
