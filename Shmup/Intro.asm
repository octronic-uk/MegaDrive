;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Intro.asm 

_Shmup_Intro:
    ; Setup X and Y
    move.w  #40-_Shmup_Intro_Msg_String_Length,d0
    move.w  #$1A,d1
    lsl.w   #8,d0
    or.w    d1,d0

    pea     _Shmup_Intro_Msg_String ; String
    move.l  #_PixelFontTileID,-(sp) ; First font tile
    move.l  d0,-(sp)                ; X,Y
    move.l  #$0,-(sp)               ; Palette Index
    jsr     _TextOnPlaneA
    add.l   #16,sp

    ; Setup X and Y
    move.w  #40-_Shmup_Intro_Year_String_Length,d0
    move.w  #$1B,d1
    lsl.w   #8,d0
    or.w    d1,d0

    pea     _Shmup_Intro_Year_String    ; String
    move.l  #_PixelFontTileID,-(sp)     ; First font tile
    move.l  d0,-(sp)                    ; X,Y
    move.l  #$0,-(sp)                   ; Palette Index
    jsr     _TextOnPlaneA
    add.l   #16,sp

    move.l  #SHMUP_INTRO_WAIT_FRAMES,d0
_Shmup_Intro_Wait:
    move.l  d0,-(sp)
    jsr     VDP_WaitVBlankStart
    move.l  (sp)+,d0
    move.l  d0,-(sp)
    jsr     VDP_WaitVBlankEnd
    move.l  (sp)+,d0
    dbra    d0,_Shmup_Intro_Wait
    rts

SHMUP_INTRO_WAIT_FRAMES equ 5*50

_Shmup_Intro_Msg_String:
    dc.b    "OCTRONIC     "
_Shmup_Intro_Msg_String_End:
    dc.b    0,0

_Shmup_Intro_Year_String:
    dc.b    "2017 "
_Shmup_Intro_Year_String_End:
    dc.b    0,0

    even

_Shmup_Intro_Msg_String_Length    equ  _Shmup_Intro_Msg_String_End-_Shmup_Intro_Msg_String
_Shmup_Intro_Year_String_Length   equ  _Shmup_Intro_Year_String_End-_Shmup_Intro_Year_String
