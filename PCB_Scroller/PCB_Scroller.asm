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

_lewp:
    jsr PlaneA_Scroller
    jmp     _lewp

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

PlaneA_Scroller:
    ; Disable Auto Increment
    move.l  #0,-(sp)
    jsr     _VDPSetAutoIncrement
    addq.l  #4,sp
    ; Setup to write to D000, HScroll Table
    move.l  #$D000,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    move.w  #$FFF,d0

PlaneA_Scroller_Next:
    move.l  d0,-(sp)
    jsr     _VDPWaitVBlankEnd
    move.l  (sp)+,d0
    move.w  d0,VDP_DATA_PORT

    move.w  #$06FF,d1
PlaneA_Scroller_Wait:
    dbra    d1,PlaneA_Scroller_Wait
    dbra    d0,PlaneA_Scroller_Next
    rts

__end    ; Very last line, end of ROM address
