;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Sprites.asm 
;      - Fun with the VDP Sprites
  
; Includes
    include "../include/Header.asm"
    include "../include/VDP.asm"
    include "../include/Controller.asm"
    include "../include/Text.asm"

    org     $1000
__GameMain:

_PushPallete:

    ; Setup VRAM write to $C000
    ;move.l  #$C000,-(sp)
    ;jsr     _VDPWriteVramMode
    ;addq.l  #4,sp

    ; Set autoincrement to 2 bytes
    move.l  #2,-(sp)
    jsr     _VDPSetAutoIncrement
	addq.l  #4,sp

    ; Set up VDP to write to CRAM address $0000
    move.l  #$0000,-(sp)
    jsr     _VDPWriteCramMode
    addq.l  #4,sp

    ; Load address of Palette into a0
    lea     _SimplePalette,a0               
    ; 32 bytes of data (8 longwords, minus 1 for counter) in palette
    move.l  #8,d0                  
    subq.l  #1,d0                  

_PushPaletteLoop:
    ; Move data to VDP data port, and increment source address
    move.l  (a0)+,VDP_DATA_PORT        
    dbra    d0,_PushPaletteLoop

    ; Set background colour to palette 0, colour 8
    move.w  #$8700,VDP_CTRL_PORT  

    jsr     _TextLoadFont

;   $1042
    pea     MSG_STRING              ; String
    move.l  #_PixelFontTileID,-(sp) ; First font tile
    move.l  #$0504,-(sp)            ; X,Y
    move.l  #$3,-(sp)               ; Palette Index
    jsr     _TextOnPlaneA
    addq.l  #8,sp
    addq.l  #8,sp

; End of ROM Loop

_finished:
    jmp     _finished

_SimplePalette:
   dc.w $0000 ; Colour 0 - Transparent
   dc.w $000E ; Colour 1 - Red
   dc.w $00E0 ; Colour 2 - Green
   dc.w $0E00 ; Colour 3 - Blue
   dc.w $0000 ; Colour 4 - Black
   dc.w $0EEE ; Colour 5 - White
   dc.w $00EE ; Colour 6 - Yellow
   dc.w $008E ; Colour 7 - Orange
   dc.w $0E0E ; Colour 8 - Pink
   dc.w $0808 ; Colour 9 - Purple
   dc.w $0444 ; Colour A - Dark grey
   dc.w $0888 ; Colour B - Light grey
   dc.w $0EE0 ; Colour C - Turquoise
   dc.w $000A ; Colour D - Maroon
   dc.w $0600 ; Colour E - Navy blue
   dc.w $0060 ; Colour F - Dark green

MSG_STRING:
    dc.b    "THIS IS A TEST!",0

__end    ; Very last line, end of ROM address
