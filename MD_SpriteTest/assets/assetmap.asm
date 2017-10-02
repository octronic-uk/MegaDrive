
    ; ************************************
    ; Art asset VRAM mapping
    ; ************************************
PixelFontVRAM:  equ $0000
Sprite1VRAM:    equ PixelFontVRAM+PixelFontSizeB
Sprite2VRAM:    equ Sprite1VRAM+Sprite1SizeB

    ; ************************************
    ; Include all art assets
    ; ************************************
    include 'assets\fonts\pixelfont.asm'
    include 'assets\sprites\sprite1.asm'
    include 'assets\sprites\sprite2.asm'

    ; ************************************
    ; Include all palettes
    ; ************************************
    include 'assets\palettes\paletteset1.asm'
