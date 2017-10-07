;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk
;
; VDP.asm - Useful VDP Routines
;
;   See http://md.squee.co/VDP

; Read the VDP status register into d0
;   Usage
;       jsr VDPReadStatusD0
;   Uses
;       d0
;   Returns
;       d0: VDP Status
VDP_ReadStatus_D0:
    andi.l  #00000000,d0
    move.w  VDP_CTRL_PORT,d0
    rts
    
; VDP Set Auto Increment Value
;   Usage
;       move.l #AI_VALUE,-(sp) 
;       jsr VDP_SetAutoIncrement
;       addq.l  #VDP_SET_AUTO_INCREMENT_ALIGN,sp

VDP_SET_AUTO_INCREMENT_ALIGN  equ 4
VDP_SET_AUTO_INCREMENT_ARG    equ 4

VDP_SetAutoIncrement:
    move.l  VDP_SET_AUTO_INCREMENT_ARG(sp),d0
    move.l  #VDP_REG_AUTO_INCREMENT,-(sp)   ; AI Register
    move.l  d0,-(sp) ; AI Value ( 8(sp) as we jump over return address)
    jsr     VDP_WriteRegister
    addq.l  #VDP_WRITE_REGISTER_ALIGN,sp
    rts

; VDP Write Register
;
;   Data Format
;       1, 0, ?, R4,R3,R2,R1,R0
;       D7,D6,D5,D4,D3,D2,D1,D0
;   Usage
;       move.l #register,-(sp)
;       move.l #data,-(sp)
;       jsr VDP_WriteRegister
;       addq.l  #VDP_WRITE_REGISTER_ALIGN,sp
;   Uses
;       d0,d1

VDP_WRITE_REGISTER_ALIGN    equ 8
VDP_WRITE_REG_REG_ARG       equ 8
VDP_WRITE_REG_DATA_ARG      equ 4 

VDP_WriteRegister:
    move.l  VDP_WRITE_REG_DATA_ARG(sp),d0   ; VDP Data
    move.l  VDP_WRITE_REG_REG_ARG(sp),d1    ; VDP Register
    ori.b   #$80,d1                         ; Register mask
    lsl     #8,d1                           ; Shift to byte 2
    or.w    d1,d0                           ; Or Register with Data
    move.w  d0,VDP_CTRL_PORT                ; Write to VDP
    rts

; Calculates the correct command word for RAM access
;   Usage
;       move.l  #Command,-(sp)
;       move.l  #Address,-(sp)
;       jsr     VDP_CreateCmdWord
;       addq.l  #VDP_CREATE_CMD_WORD_ALIGN ,sp
;   Uses
;       d0,d1,d2   
;   Returns
;       d0: Formatted VDP Command Word

VDP_CREATE_CMD_WORD_ALIGN   equ 8
VDP_CREATE_CMD_WORD_CMD     equ 8
VDP_CREATE_CMD_WORD_ADDR    equ 4

VDP_CreateCmdWord:
    ; Store Args
    move.l  VDP_CREATE_CMD_WORD_ADDR(sp),d0 ; Address in d0
    move.l  VDP_CREATE_CMD_WORD_CMD(sp),d1  ; Command in d1
    ; Format Adderss
    swap    d0              ; Move address to upper word
                            ; Create bits 1,0 in d2
    move.l  d0,d2           ; Temporarily store in d2
    andi.l  #$C0000000,d2   ; Zero out every bit other than 31,30
    rol.l   #2,d2           ; Shift bits 31,30 into 1,0
    andi.l  #$3FFF0000,d0   ; Zero out bits 31,30
    or.l    d2,d0           ; Or result to get address layout
    ; Format Command
    move.l  d1,d2           ; Temp store in d2
    ror.l   #2,d2           ; Shift bits 1,0 into 31,30
    andi.l  #$C0000000,d2   ; Zero out every other bit 
    rol.l   #2,d1           ; Shift Left by 2 places
    andi.b  #$F0,d1         ; Zero out unwanted bits
    or.l    d2,d0           ; Combine Command bits
    or.l    d1,d0           ; Combine command and address bits
    rts

; Setup for a write to Video RAM at the given address
;   move.l  #ADDRESS,-(sp)
;   jsr     VDP_WriteVramMode
;   addq.l  #VDP_WRITE_VRAM_MODE_ALIGN,sp

VDP_WRITE_VRAM_MODE_ALIGN equ 4
VDP_WRITE_VRAM_MODE_ADDR  equ 4

VDP_WriteVramMode:
    move.l  VDP_WRITE_VRAM_MODE_ADDR(sp),d0
    move.l  #VDP_VRAM_WRITE,-(sp)
    move.l  d0,-(sp)
    jsr     VDP_CreateCmdWord
    addq.l  #VDP_CREATE_CMD_WORD_ALIGN,sp
    move.l  d0,VDP_CTRL_PORT
    rts

; Setup for a read from Video RAM at the given address
;   move.l  #ADDRESS,-(sp)
;   jsr     VDP_ReadVramMode
;   addq.l  #VDP_READ_VRAM_MODE_ALIGN,sp

VDP_READ_VRAM_MODE_ALIGN equ 4
VDP_READ_VRAM_MODE_ADDR  equ 4

VDP_ReadVramMode:
    move.l  VDP_READ_VRAM_MODE_ADDR(sp),d0
    move.l  #VDP_VRAM_READ,-(sp)
    move.l  d0,-(sp)
    jsr     VDP_CreateCmdWord
    addq.l  #VDP_CREATE_CMD_WORD_ALIGN,sp
    move.l  d0,VDP_CTRL_PORT
    
    rts


; Setup for a write to VertivalScroll RAM at the given address
;   Usage
;       move.l  #ADDRESS,-(sp)
;       jsr     VDP_WriteVramMode
;       addq.l  #VDP_WRITE_VSRAM_MODE_ALIGN4,sp
;   Uses
;       d0

VDP_WRITE_VSRAM_MODE_ALIGN  equ 4
VDP_WRITE_VSRAM_MODE_ADDR   equ 4

VDP_WriteVSramMode:
    move.l  VDP_WRITE_VSRAM_MODE_ADDR(sp),d0
    move.l  #VDP_VSRAM_WRITE,-(sp)
    move.l  d0,-(sp)
    jsr     VDP_CreateCmdWord
    addq.l  #VDP_CREATE_CMD_WORD_ALIGN,sp
    move.l  d0,VDP_CTRL_PORT
    rts

; Setup for a write to Colour RAM at the given address
;   Usage
;       move.l  #ADDRESS,-(sp)
;       jsr     VDP_WriteCRAM
;       addq.l  #VDP_WRITE_CRAM_MODE_ALIGN,sp
;   Uses
;       d0

VDP_WRITE_CRAM_MODE_ALIGN   equ 4
VDP_WRITE_CRAM_MODE_ADDR    equ 4

VDP_WriteCramMode:
    move.l  VDP_WRITE_CRAM_MODE_ADDR(sp),d0
    move.l  #VDP_CRAM_WRITE,-(sp)
    move.l  d0,-(sp)
    jsr     VDP_CreateCmdWord
    move.l  d0,VDP_CTRL_PORT
    addq.l  #VDP_CREATE_CMD_WORD_ALIGN,sp
    rts

; Create an RGB word from args
;
; +-----------------------------------------------+
; |15|14|13|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
; +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
; |x |x | x| x|	B| B| B| x| G| G| G| x| R| R| R| x|
; +-----------------------------------------------+
;
;   Usage
;       move.w  #RED,-(sp)
;       move.w  #GREEN,-(sp)
;       move.w  #BLUE,-(sp)
;       jsr     VDP_CreateRGB_D0
;       addq.l  #VDP_CREATE_RGB_ALIGN,sp 
;   Uses
;       d2,d1,d0
;   Reurns 
;       d0: Formatted RGB Word

VDP_CREATE_RGB_ALIGN    equ 6
VDP_CREATE_RGB_RED      equ 8 
VDP_CREATE_RGB_GREEN    equ 6 
VDP_CREATE_RGB_BLUE     equ 4 

VDP_CreateRGB_D0:
    move.w  VDP_CREATE_RGB_BLUE(sp),d2 ; Blue
    rol.w   #7,d2
    rol.w	#2,d2 
    move.w  VDP_CREATE_RGB_GREEN(sp),d1 ; Green
    rol.w   #5,d1 
    move.w  VDP_CREATE_RGB_RED(sp),d0 ; Red
    rol.w   #1,d0
    or.w    d1,d0
    or.w    d2,d0
    rts

; Usage
;       move.l  #SPRITE_DEF_ADDRESS,-(sp)
;       move.w  #TileID,-(sp)
;       jsr     VDP_SetSprite_TileID
;       addq.l  #VDP_SET_SPRITE_TILE_ID_ALIGN,sp
;   Uses
;       d0,d1

VDP_SET_SPRITE_TILE_ID_ALIGN  equ 6 
VDP_SET_SPRITE_TILE_ID_ADDR   equ 6 
VDP_SET_SPRITE_TILE_ID_VAL    equ 4

VDP_SetSprite_TileID:
    move.l  VDP_SET_SPRITE_TILE_ID_ADDR(sp),d0
    addq.l  #4,d0
    move.l  d0,-(sp)
    jsr     VDP_WriteVramMode
    addq.l  #VDP_WRITE_VRAM_MODE_ALIGN,sp
    move.w  VDP_SET_SPRITE_TILE_ID_VAL(sp),d0
    ori.w   #$4000,d0
    move.w  d0,VDP_DATA_PORT
    rts

; Usage
;       move.l  #SPRITE_DEF_ADDRESS,-(sp)
;       jsr     VDP_SetSpriteX
;       addq.l  #VDP_SET_SPRITE_X_ALIGN,sp
;   Uses
;       d0,d1

VDP_GET_SPRITE_X_ALIGN  equ 4 
VDP_GET_SPRITE_X_ADDR   equ 4 

VDP_GetSpriteX_D0:
    move.l  VDP_GET_SPRITE_X_ADDR(sp),d0
    addq.l  #6,d0
    move.l  d0,-(sp)
    jsr     VDP_ReadVramMode
    addq.l  #VDP_READ_VRAM_MODE_ALIGN,sp
    andi.l  #0,d0
    move.b  VDP_DATA_PORT,d0
    rts

; Usage
;       move.l  #SPRITE_DEF_ADDRESS,-(sp)
;       move.w  #X,-(sp)
;       jsr     VDP_SetSpriteX
;       addq.l  #VDP_SET_SPRITE_X_ALIGN,sp
;   Uses
;       d0,d1

VDP_SET_SPRITE_X_ALIGN  equ 6 
VDP_SET_SPRITE_X_ADDR   equ 6 
VDP_SET_SPRITE_X_VAL    equ 4

VDP_SetSpriteX:
    move.l  VDP_SET_SPRITE_X_ADDR(sp),d0
    addq.l  #6,d0
    move.l  d0,-(sp)
    jsr     VDP_WriteVramMode
    addq.l  #VDP_WRITE_VRAM_MODE_ALIGN,sp
    move.w  VDP_SET_SPRITE_X_VAL(sp),VDP_DATA_PORT
    rts

;   Usage
;       move.l  #SPRITE_DEF_ADDRESS,-(sp)
;       move.l  #Y,-(sp)
;       jsr     VDP_SetSpriteY
;       addq.l  #VDP_SET_SPRITE_Y_ALIGN,sp
;   Uses
;      d1 

VDP_SET_SPRITE_Y_ALIGN  equ 6 
VDP_SET_SPRITE_Y_ADDR   equ 6 
VDP_SET_SPRITE_Y_VAL    equ 4

VDP_SetSpriteY:
    move.l  VDP_SET_SPRITE_Y_ADDR(sp),-(sp)
    jsr     VDP_WriteVramMode
    addq.l  #VDP_WRITE_VRAM_MODE_ALIGN,sp
    move.w  VDP_SET_SPRITE_Y_VAL(sp),VDP_DATA_PORT
    rts

;   Usage
;       jsr     VDP_WaitVBlankStart
;   Uses
;

VDP_WaitVBlankStart:
   move.w   VDP_CTRL_PORT,d0    ; Move VDP status word to d0
   andi.w   #$0008,d0           ; AND with bit 4 (vblank), result in status register
   bne      VDP_WaitVBlankStart ; Branch if not equal (to zero)
   rts
 
;   Usage
;       jsr     VDP_WaitVBlankEnd
;   Uses
;       d0
VDP_WaitVBlankEnd:
   move.w   VDP_CTRL_PORT,d0    ; Move VDP status word to d0
   andi.w   #$0008,d0           ; AND with bit 4 (vblank), result in status register
   beq      VDP_WaitVBlankEnd    ; Branch if equal (to zero)
   rts

;   Usage
;       pea     YOUR_PALETTE
;       move.l  #PALETTE_VRAM_DEST,-(sp)
;       jsr     VDP_LoadPalette
;       addq.l  #VDP_LOAD_PALETTE_ALIGN,sp
;   Uses
;       d0/a0

VDP_LOAD_PALETTE_ALIGN    equ 8
VDP_LOAD_PALETTE_SRC      equ 8
VDP_LOAD_PALETTE_DEST     equ 4

VDP_LoadPalette:
    ; Set autoincrement to 2 bytes
    move.l  #2,-(sp)
    jsr     VDP_SetAutoIncrement
	addq.l  #VDP_SET_AUTO_INCREMENT_ALIGN,sp
    ; Set up VDP to write to CRAM address
    move.l  VDP_LOAD_PALETTE_DEST(sp),-(sp)
    jsr     VDP_WriteCramMode
    addq.l  #VDP_WRITE_CRAM_MODE_ALIGN,sp
    ; Load address of Palette into a0
    movea.l VDP_LOAD_PALETTE_SRC(sp),a0               
    ; 32 bytes of data (8 longwords, minus 1 for counter) in palette
    move.l  #$07,d0                  
_VDP_LoadPalette_Loop:
    ; Move data to VDP data port, and increment source address
    move.l  (a0)+,VDP_DATA_PORT        
    dbra    d0,_VDP_LoadPalette_Loop
    rts

;   Usage
;       pea     Tiles Source
;       move.l  Number Of Tiles
;       move.l  Tiles VRam Destination
;       jsr     LoadSprite
;       add.l   #LOAD_SPRITE_STACK_ALIGN,sp

VDP_LOAD_TILES_ALIGN  equ 12
VDP_LOAD_TILES_SRC    equ 12
VDP_LOAD_TILES_COUNT  equ 8 
VDP_LOAD_TILES_DEST   equ 4 

VDP_LoadTiles:
    ; Set autoincrement to 2 bytes
    move.l  #2,-(sp)
    jsr     VDP_SetAutoIncrement
	addq.l  #VDP_SET_AUTO_INCREMENT_ALIGN,sp
    ; Set up VDP to write to VRAM address argued
    move.l  VDP_LOAD_TILES_DEST(sp),-(sp)
    jsr     VDP_WriteVramMode
    addq.l  #VDP_WRITE_VRAM_MODE_ALIGN,sp
    ; Load address of tiles into a0
    movea.l VDP_LOAD_TILES_SRC(sp),a0
    ; (NumTiles*8), -1 for counter
    move.l  VDP_LOAD_TILES_COUNT(sp),d0
    mulu.w  #8,d0
    subq.l  #1,d0               
_VDP_LoadTiles_Loop:
    ; Move data to VDP data port, and increment source address
    move.l (a0)+,VDP_DATA_PORT     
    dbra d0,_VDP_LoadTiles_Loop
    rts

;   Usage
;       pea     Sprite Descriptor Address
;       jsr     VDP_LoadSprite
;       add.l   #VDP_LOAD_SPRITE_ALIGN,sp

VDP_LOAD_SPRITE_ALIGN equ 4
VDP_LOAD_SPRITE_DESCRIPTOR equ 4

VDP_LoadSprite:
    move.l  #VDP_SPRITE_TABLE,-(sp)
    jsr     VDP_WriteVramMode
    addq.l  #VDP_WRITE_VRAM_MODE_ALIGN,sp
    move.l  VDP_LOAD_SPRITE_DESCRIPTOR(sp),a0
    move.l  (a0)+,VDP_DATA_PORT
    move.l  (a0)+,VDP_DATA_PORT
    rts
