;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk
;
; VDP.asm - Useful VDP Definitions
;
;   See http://md.squee.co/VDP
;


; Read the VDP status register into d0
_VDPReadStatusD0:
    andi.l  #00000000,d0
    move.w  VDP_CTRL_PORT,d0
    rts
    
; VDP Set Auto Increment Value
;   move.l #AI_VALUE,-(sp) 
;   jsr _VDPSetAutoIncrement
_VDPSetAutoIncrement:
    move.l   #VDP_REG_AUTO_INCREMENT,-(sp)   ; AI Register
    move.l   8(sp),-(sp) ; AI Value ( 8(sp) as we jump over return address)
    jsr _VDPWriteRegister
    addq.l   #8,sp
    rts

; VDP Write Register
;
; Data Format
;   1, 0, ?, R4,R3,R2,R1,R0
;   D7,D6,D5,D4,D3,D2,D1,D0
; Usage
;    move.l #register,-(sp)
;    move.l #data,-(sp)
;
_VDPWriteRegister:
    move.l  4(sp),d0           ; VDP Data
    move.l  8(sp),d1           ; VDP Register
    ori.b   #$80,d1            ; Register mask
    lsl     #8,d1              ; Shift to byte 2
    or.w    d1,d0              ; Or Register with Data
    move.w  d0,VDP_CTRL_PORT   ; Write to VDP
    rts

; Calculates the correct command word for RAM access
;   move.l  #Command,-(sp)
;   move.l  #Address,-(sp)
;   jsr     _VDPCreateCmdWord
;   addi.l  #8,sp
;   
;   Result in d0
_VDPCreateCmdWord:
    ; Store Args
    move.l  4(sp),d0        ; Address in d0
    move.l  8(sp),d1        ; Command in d1
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
;   jsr     _VDPWriteVramMode
;   addq.l  #4,sp
_VDPWriteVramMode:
    move.l  4(sp),d0
    move.l  #VDP_VRAM_WRITE,-(sp)
    move.l  d0,-(sp)
    jsr     _VDPCreateCmdWord
    addq.l  #8,sp
    move.l  d0,VDP_CTRL_PORT
    rts

; Setup for a write to Colour RAM at the given address
;   move.l  #ADDRESS,-(sp)
;   jsr     _VDPWriteCRAM
;   addq.l  #4,sp
_VDPWriteCramMode:
    move.l  4(sp),d0
    move.l  #VDP_CRAM_WRITE,-(sp)
    move.l  d0,-(sp)
    jsr     _VDPCreateCmdWord
    move.l  d0,VDP_CTRL_PORT
    addq.l  #8,sp
    rts

; Create an RGB word from args
;
; +-----------------------------------------------+
; |15|14|13|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
; +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
; |x |x | x| x|	B| B| B| x| G| G| G| x| R| R| R| x|
; +-----------------------------------------------+
;
; Usage
;   move.w  #RED,-(sp)
;   move.w  #GREEN,-(sp)
;   move.w  #BLUE,-(sp)
;   jsr     _VDPRedGreenBlueD0
;   addq.l  #6,sp 
;   Result in d0.w
;
_VDPCreateRgbD0:
    move.w  4(sp),d2 ; Blue
    rol.w   #7,d2
    rol.w	#2,d2 
    move.w  6(sp),d1 ; Green
    rol.w   #5,d1 
    move.w  8(sp),d0 ; Red
    rol.w   #1,d0
    or.w    d1,d0
    or.w    d2,d0
    rts

; Usage
;   pea     SPRITE_DATA_ADDRESS
;   jsr     _VDPLoadSpriteTable
;   addq.l  #4,sp
_VDPLoadSpriteTable:
    movea.l 4(sp),a0
    move.l  (a0)+,VDP_DATA_PORT
    move.l  (a0)+,VDP_DATA_PORT
    rts

; Usage
;   move.l  #SPRITE_DEF_ADDRESS,-(sp)
;   move.l  #X,-(sp)
;   move.l  #Y,-(sp)
;   jsr     _VDPSetSpriteXY
;   addq.l  #$C,sp
_VDPSetSpriteXY:
    ; Args
    move.l  8(sp),d0  ; X
    move.l  12(sp),d2 ; Sprite Address
    ; Set X
    move.l  d2,-(sp)
    move.l  d0,-(sp)
    jsr     _VDPSetSpriteX
    addq.l  #8,sp
    move.l  4(sp),d1  ; Y
    move.l  12(sp),d2 ; Sprite Address
    ; Set Y
    move.l  d2,-(sp) ; Set Y 
    move.l  d1,-(sp) ; Set Y 
    jsr     _VDPSetSpriteY
    addq.l  #8,sp
    rts

; Usage
;   move.l  #SPRITE_DEF_ADDRESS,-(sp)
;   move.l  #X,-(sp)
;   jsr     _VDPSetSpriteX
;   addq.l  #$C,sp
_VDPSetSpriteX:
    move.l  8(sp),d0
    addq.l  #$6,d0
    move.l  d0,-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    move.l  4(sp),d1
    move.w  d1,VDP_DATA_PORT
    rts

; Usage
;   move.l  #SPRITE_DEF_ADDRESS,-(sp)
;   move.l  #Y,-(sp)
;   jsr     _VDPSetSpriteY
;   addq.l  #$C,sp
_VDPSetSpriteY:
    move.l  8(sp),-(sp)
    jsr     _VDPWriteVramMode
    addq.l  #4,sp
    move.l  4(sp),d1
    move.w  d1,VDP_DATA_PORT
    rts

_VDPWaitVBlankStart:
   move.w   VDP_CTRL_PORT,d0    ; Move VDP status word to d0
   andi.w   #$0008,d0           ; AND with bit 4 (vblank), result in status register
   bne      _VDPWaitVBlankStart ; Branch if not equal (to zero)
   rts
 
_VDPWaitVBlankEnd:
   move.w   VDP_CTRL_PORT,d0     ; Move VDP status word to d0
   andi.w   #$0008,d0            ; AND with bit 4 (vblank), result in status register
   beq       _VDPWaitVBlankEnd   ; Branch if equal (to zero)
   rts

