; ------------------------------------------------------------------------------
;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   FontHeader.asm - Load a font into VDP memory.
;   Shoutouts to: BigEvilCorporation
;
; ------------------------------------------------------------------------------

FontLoaderFn:
; Usage
;   move.l #PixelFontSizeInTiles,-(sp)  ; Number of characters (font size in tiles) to stack
;   move.l #PixelFontVRAM,-(sp)         ; VRAM dest address to stack
;   pea     PixelFontAddr,a0            ; Font address to a0
;   jsr     LoadFont                    ; Jump to subroutine

; Parameter Setup
    moveal. (sp)+,a1    ; Grab Return Address
    movea.l (sp)+,a0    ; Get font address from stack
    move.l  (sp)+,d0    ; Get VRAM Address from stack
    move.l  (sp)+,d1    ; Get Number of chars in font from stack
    add.l   #16,sp      ; Correct SP
    pea     a1          ; Set return addres
; Work
    swap    d0                  ; Shift VRAM addr to upper word
    add.l   #vdp_write_tiles,d0 ; VRAM write cmd + VRAM destination address
    move.l  d0,vdp_control      ; Send address to VDP cmd port
    subq.b  #$1, d1             ; Num chars - 1
_FontLoaderCharCopy:
    move.w   #$07,d2            ; 8 longwords in tile
_FontLoaderLongCopy:
    move.l   (a0)+,vdp_data     ; Copy one line of tile to VDP data port
    dbra     d2,_FontLoaderLongCopy
    dbra     d1,_FontLoaderCharCopy
    rts

FontDrawTextPlaneA:
; Usage
;   move.l  #Palette,-(sp)
;   move.l  #XY Position,-(sp)
;   move.l  #FirstTileID,-(sp)
;   pea     StringAddress

; Setup Parameters
    movea.l (sp)+,a1    ; Grab Return Address
    movea.l (sp)+,a0    ; String Address
    move.l  (sp)+,d0    ; First Font Tile ID
    move.l  (sp)+,d1    ; XY Coordinate
    move.l  (sp)+,d2    ; Palette
    add.l   #-20,sp     ; Correct Stack
    pea     a1          ; Push return address back onto stack

; Work
    clr.l   d3                     ; Clear d3 ready to work with
    move.b  d1,d3                  ; Move Y coord (lower byte of d1) to d3
    mulu.w  #$0040,d3              ; Multiply Y by line width (H40 mode - 64 lines horizontally) to get Y offset
    ror.l   #$8,d1                 ; Shift X coord from upper to lower byte of d1
    add.b   d1,d3                  ; Add X coord to offset
    mulu.w  #$2,d3                 ; Convert to words
    swap    d3                     ; Shift address offset to upper word
    add.l   #vdp_write_plane_a,d3  ; Add PlaneA write cmd + address
    move.l  d3,vdp_control         ; Send to VDP control port
    clr.l    d3                    ; Clear d3 ready to work with again
    move.b   d2, d3                ; Move palette ID (lower byte of d2) to d3
    rol.l    #$8, d3              ; Shift palette ID to bits 14 and 15 of d3
    rol.l    #$5, d3              ; Can only rol bits up to 8 places in one instruction
    lea      FontASCIIMap, a1      ; Load address of ASCII map into a1
     
_FontCharCopy:
    move.b   (a0)+, d2             ; Move ASCII byte to lower byte of d2
    cmp.b    #$0, d2              ; Test if byte is zero (string terminator)
    beq.b    _FontCopyEnd                  ; If byte was zero, branch to end
     
    sub.b    #ASCIIStart, d2       ; Subtract first ASCII code to get table entry index
    move.b   (a1,d2.w), d3         ; Move tile ID from table (index in lower word of d2) to lower byte of d3
    add.w    d0, d3                ; Offset tile ID by first tile ID in font
    move.w   d3, vdp_data          ; Move palette and pattern IDs to VDP data port
    jmp      _FontCharCopy             ; Next character

_FontCopyEnd:
    rts

FontASCIIStart: equ $20 ; First ASCII code in table
 
FontASCIIMap:
    dc.b $00   ; SPACE (ASCII code $20)
    dc.b $28   ; ! Exclamation mark
    dc.b $2B   ; " Double quotes
    dc.b $2E   ; # Hash
    dc.b $00   ; UNUSED
    dc.b $00   ; UNUSED
    dc.b $00   ; UNUSED
    dc.b $2C   ; ' Single quote
    dc.b $29   ; ( Open parenthesis
    dc.b $2A   ; ) Close parenthesis
    dc.b $00   ; UNUSED
    dc.b $2F   ; + Plus
    dc.b $26   ; , Comma
    dc.b $30   ; - Minus
    dc.b $25   ; . Full stop
    dc.b $31   ; / Slash or divide
    dc.b $1B   ; 0 Zero
    dc.b $1C   ; 1 One
    dc.b $1D   ; 2 Two
    dc.b $1E   ; 3 Three
    dc.b $1F   ; 4 Four
    dc.b $20   ; 5 Five
    dc.b $21   ; 6 Six
    dc.b $22   ; 7 Seven
    dc.b $23   ; 8 Eight
    dc.b $24   ; 9 Nine
    dc.b $2D   ; : Colon
    dc.b $00   ; UNUSED
    dc.b $00   ; UNUSED
    dc.b $00   ; UNUSED
    dc.b $00   ; UNUSED
    dc.b $27   ; ? Question mark
    dc.b $00   ; UNUSED
    dc.b $01   ; A
    dc.b $02   ; B
    dc.b $03   ; C
    dc.b $04   ; D
    dc.b $05   ; E
    dc.b $06   ; F
    dc.b $07   ; G
    dc.b $08   ; H
    dc.b $09   ; I
    dc.b $0A   ; J
    dc.b $0B   ; K
    dc.b $0C   ; L
    dc.b $0D   ; M
    dc.b $0E   ; N
    dc.b $0F   ; O
    dc.b $10   ; P
    dc.b $11   ; Q
    dc.b $12   ; R
    dc.b $13   ; S
    dc.b $14   ; T
    dc.b $15   ; U
    dc.b $16   ; V
    dc.b $17   ; W
    dc.b $18   ; X
    dc.b $19   ; Y
    dc.b $1A   ; Z (ASCII code $5A)

; Example Font Data
PixelFont: ; Font start address
    dc.l    $01111100
    dc.l    $11000110
    dc.l    $10111010
    dc.l    $10000010
    dc.l    $10111010
    dc.l    $10101010
    dc.l    $11101110
    dc.l    $00000000
; Rest of font data...
PixelFontEnd:                                ; Font end address

PixelFontSizeB  equ (PixelFontEnd-PixelFont) ; Font size in bytes
PixelFontSizeW  equ (PixelFontSizeB/2)       ; Font size in words
PixelFontSizeL  equ (PixelFontSizeB/4)       ; Font size in longs
PixelFontSizeT  equ (PixelFontSizeB/32)      ; Font size in tiles
PixelFontVRAM   equ $0100                   ; Dest address in VRAM
PixelFontTileID equ (PixelFontVRAM/32)      ; ID of first tile


