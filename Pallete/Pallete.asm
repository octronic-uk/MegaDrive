;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Palette.asm 
;      - Fun with the VDP Palette
  
    include "../include/Header.asm"
    include "../include/VDPLib.asm"

__GameMain:

_PushPallete:

    ; Setup VRAM write to $C000
    move.l  #$C000,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp

    ; Set autoincrement to 2 bytes
    move.l  #2,-(sp)
    jsr     _VDPSetAutoIncrement
	addq.l  #4,sp

    ; Set up VDP to write to CRAM address $0000
    move.l  #$0000,-(sp)
    jsr     _VDPWriteCramMode
    addq.l  #4,sp

    ; Load address of Palette into a0
    lea     Palette,a0               
    ; 32 bytes of data (8 longwords, minus 1 for counter) in palette
    move.l  #$07,d0                  

_PushPaletteLoop:
    ; Move data to VDP data port, and increment source address
    move.l  (a0)+,VDP_DATA_PORT        
    dbra    d0,_PushPaletteLoop
    ; Set background colour to palette 0, colour 8
    move.w  #$8700,VDP_CTRL_PORT  

_PushChars:
    ; Set up VDP to write to VRAM address $0020
    ;move.l  #$40200000,VDP_CTRL_PORT  
    move.l  #$0020,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    ; Load address of Characters into a0
    lea     Characters,a0         
    ; 32*8 bytes of data (64 longwords, minus 1 for counter) in the font
    move.l  #$3F,d0               

_PushCharsLoop:
    ; Move data to VDP data port, and increment source address
    move.l (a0)+,VDP_DATA_PORT     
    dbra d0,_PushCharsLoop

_DrawChars:
    ; Set up VDP to write to VRAM address $C000 (Plane A)
    ; Low plane, palette 0, no flipping, plus tile ID...
    ;move.l  #$40000003,VDP_CTRL_PORT  
    move.l  #$C000,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp

    move.w  #$0001,VDP_DATA_PORT      ; Pattern ID 1 - H
    move.w  #$0002,VDP_DATA_PORT      ; Pattern ID 2 - E
    move.w  #$0003,VDP_DATA_PORT      ; Pattern ID 3 - L
    move.w  #$0003,VDP_DATA_PORT      ; Pattern ID 3 - L
    move.w  #$0004,VDP_DATA_PORT      ; Pattern ID 4 - O
    move.w  #$0000,VDP_DATA_PORT      ; Pattern ID 0 - Blank space
    move.w  #$0005,VDP_DATA_PORT      ; Pattern ID 5 - W
    move.w  #$0004,VDP_DATA_PORT      ; Pattern ID 4 - O
    move.w  #$0006,VDP_DATA_PORT      ; Pattern ID 6 - R
    move.w  #$0003,VDP_DATA_PORT      ; Pattern ID 3 - L
    move.w  #$0007,VDP_DATA_PORT      ; Pattern ID 7 - D
    move.w  #$0000,VDP_DATA_PORT      ; Pattern ID 0 - Blank space
    move.w  #$0008,VDP_DATA_PORT      ; Pattern ID 7 - Smiley

_finito:
    jmp     _finito

Palette:
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

Characters:
   ; Character 0 - H
   dc.l $10000010 
   dc.l $10000010 
   dc.l $10000010 
   dc.l $11111110
   dc.l $10000010 
   dc.l $10000010 
   dc.l $10000010 
   dc.l $00000000
   ; Character 1 - E
   dc.l $11111110 
   dc.l $10000000
   dc.l $10000000
   dc.l $11111000
   dc.l $10000000
   dc.l $10000000
   dc.l $11111110
   dc.l $00000000
   ; Character 2 - L
   dc.l $10000000 
   dc.l $10000000
   dc.l $10000000
   dc.l $10000000
   dc.l $10000000
   dc.l $10000000
   dc.l $11111110
   dc.l $00000000
   ; Character 3 - O
   dc.l $11111110 
   dc.l $10000010
   dc.l $10000010
   dc.l $10000010
   dc.l $10000010
   dc.l $10000010
   dc.l $11111110
   dc.l $00000000
   ; Character 4 - W
   dc.l $10000010 
   dc.l $10000010
   dc.l $10000010
   dc.l $10010010
   dc.l $10111010
   dc.l $11101110
   dc.l $11000110
   dc.l $00000000
   ; Character 5 - R
   dc.l $11111110
   dc.l $10000010
   dc.l $10000010
   dc.l $11111100
   dc.l $10000010
   dc.l $10000010
   dc.l $10000010
   dc.l $00000000
   ; Character 6 - D
   dc.l $11111100 
   dc.l $10000010
   dc.l $10000010
   dc.l $10000010
   dc.l $10000010
   dc.l $10000010
   dc.l $11111100
   dc.l $00000000
   ; Character 6 - :D
   dc.l $02000020
   dc.l $21200212
   dc.l $02000020
   dc.l $00000000
   dc.l $10000001
   dc.l $01000010
   dc.l $00111100
   dc.l $00000000


__end    ; Very last line, end of ROM address
