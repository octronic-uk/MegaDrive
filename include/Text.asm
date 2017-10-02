;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \  
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
; Text.asm - Ascii Constant Definitions

ASCII_NUL           equ	$00 ;   NULL
ASCII_SOH           equ	$01 ;   Start of Heading
ASCII_STX           equ	$02 ;   Start of Text
ASCII_ETX           equ	$03 ;   End of Text
ASCII_EOT           equ	$04 ;   End of Transmission
ASCII_ENQ           equ	$05 ;   Enquiry
ASCII_ACK           equ	$06 ;   Acknowledge
ASCII_BEL           equ	$07 ;   Bell    
ASCII_BS            equ	$08 ;   BackSpace
ASCII_TAB           equ	$09 ;   Horizontal Tab    
ASCII_LF            equ	$0a ;   Line Feed
ASCII_VT            equ	$0b ;   Vertical Tab
ASCII_FF            equ	$0c ;   New Page
ASCII_CR	        equ	$0d ;   Carriage Return
ASCII_SO	        equ	$0e ;   Shift Out
ASCII_SI   	        equ	$0f ;   Shift In
ASCII_DLE           equ	$10 ;   Data Link Escape
ASCII_DC1	        equ	$11 ;   Device Control 1
ASCII_DC2	        equ	$12 ;   Device Control 2
ASCII_DC3	        equ	$13 ;   Device Control 3 
ASCII_DC4	        equ	$14 ;   Device Control 4 
ASCII_NAK	        equ	$15 ;   Negative Acknowledge
ASCII_SYN	        equ	$16 ;   Synchronous Idle
ASCII_ETB	        equ	$17 ;   End of Transmission Block
ASCII_CAN   	    equ	$18 ;   Cancel
ASCII_EM    	    equ	$19 ;   End of Medium
ASCII_SUB   	    equ	$1a ;   Substitute
ASCII_ESC	        equ	$1b ;   Escape
ASCII_FS	        equ	$1c ;   File Separator
ASCII_GS	        equ	$1d ;   Group Separator
ASCII_RS	        equ	$1e ;   Record Separator
ASCII_US	        equ	$1f ;   Unit Separator
ASCII_SPACE 	    equ	$20
ASCII_EXCLAMATION	equ	$21
ASCII_DOUBLE_QUOTE	equ	$22
ASCII_HASH	        equ	$23
ASCII_DOLLAR	    equ	$24
ASCII_PERCENT	    equ	$25
ASCII_AMPERSAND	    equ	$26
ASCII_SINGLE_QUOTE	equ	$27
ASCII_PAREN_L	    equ	$28
ASCII_PAREN_R	    equ	$29
ASCII_ASTERISK	    equ	$2a
ASCII_PLUS	        equ	$2b
ASCII_COMMA	        equ	$2c
ASCII_MINUS	        equ	$2d
ASCII_FULL_STOP	    equ	$2e
ASCII_FWD_SLASH	    equ	$2f
ASCII_0	            equ	$30
ASCII_1	            equ	$31
ASCII_2             equ	$32
ASCII_3	            equ	$33
ASCII_4	            equ	$34
ASCII_5	            equ	$35
ASCII_6	            equ	$36
ASCII_7	            equ	$37
ASCII_8	            equ	$38
ASCII_9	            equ	$39
ASCII_COLON	        equ	$3a
ASCII_SEMI_COLON	equ	$3b
ASCII_LESS_THAN	    equ	$3c
ASCII_EQUALS	    equ	$3d
ASCII_GREATER_THAN	equ	$3e
ASCII_QUESTION_MARK	equ	$3f
ASCII_AT_SYMBOL	    equ	$40
ASCII_A	            equ	$41
ASCII_B	            equ	$42
ASCII_C	            equ	$43
ASCII_D	            equ	$44
ASCII_E	            equ	$45
ASCII_F	            equ	$46
ASCII_G	            equ	$47
ASCII_H	            equ	$48
ASCII_I	            equ	$49
ASCII_J	            equ	$4a
ASCII_K	            equ	$4b
ASCII_L	            equ	$4c
ASCII_M	            equ	$4d
ASCII_N	            equ	$4e
ASCII_O	            equ	$4f
ASCII_P	            equ	$50
ASCII_Q	            equ	$51
ASCII_R	            equ	$52
ASCII_S	            equ	$53
ASCII_T	            equ	$54
ASCII_U	            equ	$55
ASCII_V	            equ	$56
ASCII_W	            equ	$57
ASCII_X	            equ	$58
ASCII_Y	            equ	$59
ASCII_Z	            equ	$5a
ASCII_SQ_BRKT_L     equ	$5b
ASCII_BACK_SLASH	equ	$5c
ASCII_SQ_BRKT_R 	equ	$5d
ASCII_CARAT	        equ	$5e
ASCII_UNDERSCORE	equ	$5f
ASCII_BACK_TICK 	equ	$60
ASCII_a         	equ	$61
ASCII_b	        	equ	$62
ASCII_c	        	equ	$63
ASCII_d	        	equ	$64
ASCII_e	        	equ	$65
ASCII_f	        	equ	$66
ASCII_g	        	equ	$67
ASCII_h	        	equ	$68
ASCII_i	        	equ	$69
ASCII_j	        	equ	$6a
ASCII_k        		equ	$6b
ASCII_l	        	equ	$6c
ASCII_m	        	equ	$6d
ASCII_n	        	equ	$6e
ASCII_o	        	equ	$6f
ASCII_p	        	equ	$70
ASCII_q	        	equ	$71
ASCII_r	        	equ	$72
ASCII_s	        	equ	$73
ASCII_t	        	equ	$74
ASCII_u	        	equ	$75
ASCII_v	        	equ	$76
ASCII_w	        	equ	$77
ASCII_x	        	equ	$78
ASCII_y	        	equ	$79
ASCII_z	        	equ	$7a
ASCII_CURLY_L      	equ	$7b
ASCII_V_BAR         equ	$7c
ASCII_CURLY_R       equ	$7d
ASCII_TILDE         equ	$7e
ASCII_DEL           equ	$7f

CharOffsetStart     equ $20 ; First ASCII code in table

CharOffsetMap:
	dc.b $00	; SPACE (ASCII code $20)
	dc.b $28    ; ! Exclamation mark
	dc.b $2B    ; " Double quotes
	dc.b $2E    ; # Hash
	dc.b $00	; UNUSED
	dc.b $00	; UNUSED
	dc.b $00	; UNUSED
	dc.b $2C    ; ' Single quote
	dc.b $29    ; ( Open parenthesis
	dc.b $2A    ; ) Close parenthesis
	dc.b $00	; UNUSED
	dc.b $2F    ; + Plus
	dc.b $26    ; , Comma
	dc.b $30    ; - Minus
	dc.b $25    ; . Full stop
	dc.b $31    ; / Slash or divide
	dc.b $1B    ; 0 Zero
	dc.b $1C    ; 1 One
	dc.b $1D    ; 2 Two
	dc.b $1E    ; 3 Three
	dc.b $1F    ; 4 Four
	dc.b $20    ; 5 Five
	dc.b $21    ; 6 Six
	dc.b $22    ; 7 Seven
	dc.b $23    ; 8 Eight
	dc.b $24    ; 9 Nine
	dc.b $2D    ; : Colon
	dc.b $00	; UNUSED
	dc.b $00	; UNUSED
	dc.b $00	; UNUSED
	dc.b $00	; UNUSED
	dc.b $27    ; ? Question mark
	dc.b $00	; UNUSED
	dc.b $01	; A
	dc.b $02    ; B
	dc.b $03	; C
	dc.b $04    ; D
	dc.b $05	; E
	dc.b $06	; F
	dc.b $07	; G
	dc.b $08	; H
	dc.b $09	; I
	dc.b $0A	; J
	dc.b $0B	; K
	dc.b $0C	; L
	dc.b $0D	; M
	dc.b $0E	; N
	dc.b $0F	; O
	dc.b $10	; P
	dc.b $11	; Q
	dc.b $12	; R
	dc.b $13	; S
	dc.b $14	; T
	dc.b $15	; U
	dc.b $16	; V
	dc.b $17	; W
	dc.b $18	; X
	dc.b $19	; Y
	dc.b $1A	; Z (ASCII code $5A)

    nop     0,8

_PixelFontStart: ; Font start address
	; Space
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	; A
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$10000010
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$11101110
	dc.l	$00000000
	; B
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	; C
	dc.l	$01111110
	dc.l	$11000010
	dc.l	$10111110
	dc.l	$10100000
	dc.l	$10111110
	dc.l	$11000010
	dc.l	$01111110
	dc.l	$00000000
	; D
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	; E
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$10111110
	dc.l	$10001000
	dc.l	$10111110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	; F
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$10111110
	dc.l	$10001000
	dc.l	$10111000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	; G
	dc.l	$01111110
	dc.l	$11000010
	dc.l	$10111110
	dc.l	$10100010
	dc.l	$10111010
	dc.l	$11000010
	dc.l	$01111110
	dc.l	$00000000
	; H
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10000010
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$11101110
	dc.l	$00000000
	; I
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11101110
	dc.l	$00101000
	dc.l	$11101110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	; J
	dc.l	$00001110
	dc.l	$00001010
	dc.l	$00001010
	dc.l	$11101010
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	; K
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$10110110
	dc.l	$10001100
	dc.l	$10110110
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000
	; L
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$10111110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	; M
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$10010010
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$11101110
	dc.l	$00000000
	; N
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$10011010
	dc.l	$10101010
	dc.l	$10110010
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000
	; O
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	; P
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$10111100
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	; Q
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$10110110
	dc.l	$11001010
	dc.l	$01111110
	dc.l	$00000000
	; R
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$10110110
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000
	; S
	dc.l	$01111110
	dc.l	$11000010
	dc.l	$10111110
	dc.l	$11000110
	dc.l	$11111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	; T
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11101110
	dc.l	$00101000
	dc.l	$00101000
	dc.l	$00101000
	dc.l	$00111000
	dc.l	$00000000
	; U
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10101010
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	; V
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$11010110
	dc.l	$01010100
	dc.l	$01101100
	dc.l	$00111000
	dc.l	$00000000
	; W
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$10010010
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000
	; X
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$11010110
	dc.l	$01101100
	dc.l	$11010110
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000
	; Y
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$11010110
	dc.l	$01101100
	dc.l	$00101000
	dc.l	$00101000
	dc.l	$00111000
	dc.l	$00000000
	; Z
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11110110
	dc.l	$01101100
	dc.l	$11011110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	; 0
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10110010
	dc.l	$10101010
	dc.l	$10011010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	; 1
	dc.l	$01111000
	dc.l	$01001000
	dc.l	$01101000
	dc.l	$00101000
	dc.l	$01101100
	dc.l	$01000100
	dc.l	$01111100
	dc.l	$00000000
	; 2
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$11111010
	dc.l	$11000110
	dc.l	$10111110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	; 3
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$11111010
	dc.l	$00100110
	dc.l	$11111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	; 4
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10000010
	dc.l	$11111010
	dc.l	$00001010
	dc.l	$00001110
	dc.l	$00000000
	; 5
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$10111110
	dc.l	$10000110
	dc.l	$11111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	; 6
	dc.l	$01111100
	dc.l	$11000100
	dc.l	$10111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	; 7
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11111010
	dc.l	$00110110
	dc.l	$01101100
	dc.l	$01011000
	dc.l	$01110000
	dc.l	$00000000
	; 8
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	; 9
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$11000010
	dc.l	$01111010
	dc.l	$01000110
	dc.l	$01111100
	dc.l	$00000000
	; .
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$11000000
	dc.l	$11000000
	dc.l	$00000000
	; ,
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$11100000
	; ?
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$11100110
	dc.l	$00111100
	dc.l	$00101000
	dc.l	$00111000
	dc.l	$00000000
	; !
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	; (
	dc.l	$01110000
	dc.l	$11010000
	dc.l	$10110000
	dc.l	$10100000
	dc.l	$10110000
	dc.l	$11010000
	dc.l	$01110000
	dc.l	$00000000
	; )
	dc.l	$11100000
	dc.l	$10110000
	dc.l	$11010000
	dc.l	$01010000
	dc.l	$11010000
	dc.l	$10110000
	dc.l	$11100000
	dc.l	$00000000
	; "
	dc.l	$11111000
	dc.l	$10101000
	dc.l	$10101000
	dc.l	$11111000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	; '
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	; :
	dc.l	$00000000
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	dc.l	$00000000
	; #
	dc.l	$01111100
	dc.l	$11010110
	dc.l	$10000010
	dc.l	$11010110
	dc.l	$10000010
	dc.l	$11010110
	dc.l	$01111100
	dc.l	$00000000
	; +
	dc.l	$00111000
	dc.l	$00101000
	dc.l	$11101110
	dc.l	$10000010
	dc.l	$11101110
	dc.l	$00101000
	dc.l	$00111000
	dc.l	$00000000
	; -
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	; /
	dc.l	$00011100
	dc.l	$00110100
	dc.l	$01101100
	dc.l	$11011000
	dc.l	$10110000
	dc.l	$11100000
	dc.l	$00000000
	dc.l	$00000000
_PixelFontEnd:   ; Font end address

_PixelFontSizeB	    equ (_PixelFontEnd-_PixelFontStart) ; Font size in bytes
_PixelFontSizeW	    equ (_PixelFontSizeB/2)             ; Font size in words
_PixelFontSizeL	    equ (_PixelFontSizeB/4)             ; Font size in longs
_PixelFontSizeT	    equ (_PixelFontSizeB/32)            ; Font size in tiles
_PixelFontVRAM	    equ $0100                           ; Dest address in VRAM
_PixelFontTileID	equ (_PixelFontVRAM/32)             ; ID of first tile

    nop     0,8

_TextLoadFont:

    ; Set autoincrement to 2 bytes
    move.l  #2,-(sp)
    jsr     _VDPSetAutoIncrement
	addq.l  #4,sp

    ; Set up VDP to write to CRAM address $0000
    move.l  #$0000,-(sp)
    jsr     _VDPWriteCramMode
    addq.l  #4,sp

    ; Load address of Palette into a0
    lea     _TextPalette,a0               
    ; 32 bytes of data (8 longwords, minus 1 for counter) in palette
    move.l  #8,d0                  
    subq.l  #1,d0                  

_PushPaletteLoop:
    ; Move data to VDP data port, and increment source address
    move.l  (a0)+,VDP_DATA_PORT        
    dbra    d0,_PushPaletteLoop


    move.l  #_PixelFontVRAM,-(sp) ; d0 - VRAM address
    jsr     _VDPWriteVramMode
    addq.l  #4,sp

    move.l  #_PixelFontSizeT,d1   ; d1 - Num chars in tiles
    subq.b  #1,d1                 ; Num chars - 1
    lea     _PixelFontStart,a0    ; a0 - Font address

_TextLoadFontCharCopy:
    move.w  #8,d2                 ; 8 longwords in tile
    subq.b  #1,d2                 ; - 1 for loop
_TextLoadFontLongCopy:
    move.l  (a0)+,VDP_DATA_PORT   ; Copy one line of tile to VDP data port
    dbra    d2,_TextLoadFontLongCopy
    dbra    d1,_TextLoadFontCharCopy
    rts

; Usage
;   pea     STRING_ADDR
;   move.l  #FirstTileID,-(sp)
;   move.l  #XY,-(sp)
;   move.l  #PALETTE,-(sp)
;   jsr     _TextOnPlaneA
;   addq.l  #8,sp
;   addq.l  #8,sp
;
_TextOnPlaneA:
    movea.l 16(sp),a0          ; a0 (l) - String address
    move.l  12(sp),d0          ; d0 (w) - First tile ID of font
    move.l  8(sp),d1           ; d1 (bb)- XY coord (in tiles)
    move.l  4(sp),d2           ; d2 (b) - Palette

    clr.l    d3                ; Clear d3 ready to work with
	move.b   d1,d3             ; Move Y coord (lower byte of d1) to d3
	mulu.w   #$0040,d3         ; Multiply Y by line width (H40 mode - 64 lines horizontally) to get Y offset
	ror.l    #$8,d1            ; Shift X coord from upper to lower byte of d1
	add.b    d1,d3             ; Add X coord to offset
	mulu.w   #$2,d3            ; Convert to words

	;swap     d3                ; Shift address offset to upper word
	;add.l    #$40000003,d3     ; Add PlaneA write cmd + address
	;move.l   d3,VDP_CTRL_PORT  ; Send to VDP control port

    add.l   #$C000,d3 
    movem.l d0-d3/a0,-(sp)
    move.l  d3,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    movem.l (sp)+,d0-d3/a0

	clr.l    d3                ; Clear d3 ready to work with again
	move.b   d2,d3             ; Move palette ID (lower byte of d2) to d3
	rol.l    #$8,d3            ; Shift palette ID to bits 14 and 15 of d3
	rol.l    #$5,d3            ; Can only rol bits up to 8 places in one instruction
	lea      CharOffsetMap,a1  ; Load address of ASCII map into a1
_TextOnPlaneA_CharCopy:
	move.b   (a0)+,d2               ; Move ASCII byte to lower byte of d2
	cmp.b    #$0,d2                 ; Test if byte is zero (string terminator)
	beq.b    _TextOnPlaneA_End      ; If byte was zero, branch to end
	sub.b    #CharOffsetStart,d2    ; Subtract first ASCII code to get table entry index
	move.b   (a1,d2.w),d3           ; Move tile ID from table (index in lower word of d2) to lower byte of d3
	add.w    d0,d3                  ; Offset tile ID by first tile ID in font
	move.w   d3,VDP_DATA_PORT       ; Move palette and pattern IDs to VDP data port
	jmp      _TextOnPlaneA_CharCopy ; Next character
_TextOnPlaneA_End:
	rts

_TextPalette:
   dc.w $0000 ; Colour 0 - Transparent
   dc.w $0EEE ; Colour 1 - White
   dc.w $0EEE ; Colour 2 - White
   dc.w $0EEE ; Colour 3 - White
   dc.w $0EEE ; Colour 4 - White
   dc.w $0EEE ; Colour 5 - White
   dc.w $0EEE ; Colour 6 - White
   dc.w $0EEE ; Colour 7 - White
   dc.w $0EEE ; Colour 8 - White
   dc.w $0EEE ; Colour 9 - White
   dc.w $0EEE ; Colour A - White
   dc.w $0EEE ; Colour B - White
   dc.w $0EEE ; Colour C - White
   dc.w $0EEE ; Colour D - White
   dc.w $0EEE ; Colour E - White
   dc.w $0EEE ; Colour F - White

   ;dc.w $008E ; Colour 7 - Orange
   ;dc.w $000E ; Colour 1 - Red
   ;dc.w $00E0 ; Colour 2 - Green
   ;dc.w $0E00 ; Colour 3 - Blue
   ;dc.w $0000 ; Colour 4 - Black
   ;dc.w $00EE ; Colour 6 - Yellow
   ;dc.w $0E0E ; Colour 8 - Pink
   ;dc.w $0808 ; Colour 9 - Purple
   ;dc.w $0444 ; Colour A - Dark grey
   ;dc.w $0888 ; Colour B - Light grey
   ;dc.w $0EE0 ; Colour C - Turquoise
   ;dc.w $000A ; Colour D - Maroon
   ;dc.w $0600 ; Colour E - Navy blue
   ;dc.w $0060 ; Colour F - Dark green

