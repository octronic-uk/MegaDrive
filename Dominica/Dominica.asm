;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Dominica.asm 
;      - More fun with the VDP
  
; Includes
    include "../include/Header.asm"
    include "../include/VDP.asm"
    include "../include/Controller.asm"
    include "../include/Text.asm"
    include "../Assets/dominica/dominica.asm"

__GameMain:

_SetBGColour:
    ; Set background colour to palette 0, colour 8
    move.w  #$8700,VDP_CTRL_PORT  
    jsr DomPushPalette
    jsr DomLoadTiles
    jsr DomOnPlaneA

; End of ROM Loop

_finished:
    jmp _finished

__end    ; Very last line, end of ROM address
