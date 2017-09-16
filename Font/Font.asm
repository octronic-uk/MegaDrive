    include "../include/Header.asm"
    include "../include/VDP.asm"
    include "../include/Ascii.asm"


__GameMain:
    move.l  #$40000003,$00C00004
    move.w  #$8F02,$00C00004     ; Set autoincrement to 2 bytes
    move.l  #$C0000003,$00C00004 ; Set up VDP to write to CRAM address $0000
    lea     Palette,a0           ; Load address of Palette into a0
    move.l  #$07,d0              ; 32 bytes of data (8 longwords, minus 1 for counter) in palette

_GameMainLoop:
    move.l  (a0)+,$00C00000      ; Move data to VDP data port, and increment source address
    dbra    d0,_GameMainLoop
    move.w  #$8700,PALETTE_0     ; Set background colour to palette 0, colour 8

_PushChars:
    move.l #$40200000,$00C00004  ; Set up VDP to write to VRAM address $0020
    lea Characters,a0            ; Load address of Characters into a0
    move.l #$37,d0               ; 32*7 bytes of data (56 longwords, minus 1 for counter) in the font

_PushCharsLoop:
    move.l (a0)+,$00C00000       ; Move data to VDP data port, and increment source 
                                 ; address
    dbra d0,_PushCharsLoop

_DrawChars:
    move.l  #$40000003,$00C00004  ; Set up VDP to write to VRAM address $C000 (Plane A)
                                  ; Low plane, palette 0, no flipping, plus tile ID...
    move.w  #$0000,$00C00000      ; Pattern ID 0 - Blank space
    move.w  #$0001,$00C00000      ; Pattern ID 1 - H
    move.w  #$0002,$00C00000      ; Pattern ID 2 - E
    move.w  #$0003,$00C00000      ; Pattern ID 3 - L
    move.w  #$0003,$00C00000      ; Pattern ID 3 - L
    move.w  #$0004,$00C00000      ; Pattern ID 4 - O
    move.w  #$0000,$00C00000      ; Pattern ID 0 - Blank space
    move.w  #$0005,$00C00000      ; Pattern ID 5 - W
    move.w  #$0004,$00C00000      ; Pattern ID 4 - O
    move.w  #$0006,$00C00000      ; Pattern ID 6 - R
    move.w  #$0003,$00C00000      ; Pattern ID 3 - L
    move.w  #$0007,$00C00000      ; Pattern ID 7 - D

    jmp     _DrawChars

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
   dc.l $10000010
   dc.l $10010010
   dc.l $10101010
   dc.l $11000110
   dc.l $00000000
; Character 5 - R
   dc.l $11111100 
   dc.l $10000010
   dc.l $10000010
   dc.l $11111100
   dc.l $10000100
   dc.l $10000010
   dc.l $10000010
   dc.l $00000000
; Character 6 - D
   dc.l $11111000
   dc.l $10000100
   dc.l $10000010
   dc.l $10000010
   dc.l $10000010
   dc.l $10000100
   dc.l $11111000
   dc.l $00000000

__end    ; Very last line, end of ROM address
