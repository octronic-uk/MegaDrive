;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Intro.asm 

_Intro:
    ; Setup X and Y
    move.w  #40-_Intro_String_Length,d0
    move.w  #$1B,d1
    lsl.w   #8,d0
    or.w    d1,d0

    pea     _Intro_String           ; String
    move.l  #_PixelFontTileID,-(sp) ; First font tile
    move.l  d0,-(sp)                ; X,Y
    move.l  #$0,-(sp)               ; Palette Index
    jsr     _TextOnPlaneA
    add.l   #16,sp
    move.l  #INTRO_WAIT_FRAMES,d0
_Intro_Wait:
    move.l  d0,-(sp)
    jsr     VDP_WaitVBlankStart
    move.l  (sp)+,d0
    move.l  d0,-(sp)
    jsr     VDP_WaitVBlankEnd
    move.l  (sp)+,d0
    dbra    d0,_Intro_Wait
    rts

INTRO_WAIT_FRAMES equ 5*50

_Intro_String:
    dc.b    "[ LOVE FROM, OCTRONIC. 2017 ]"
_Intro_String_End:
    dc.b    0,0
    even

_Intro_String_Length equ _Intro_String_End-_Intro_String
