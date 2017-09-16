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

_VDPReadStatusIntoD0:
    andi.l  #00000000,d0
    move.w  VDP_CTRL_PORT,d0
    rts

_VDPDisplayEnablePAL:
    rts

_VDPDisplayDisable:
    rts

_VDPSetDisplayMode:
    rts

; VDP Set Auto Increment Value
;   move.l #AI_VALUE,-(sp) 
;   jsr _VDPSetAutoIncrement
_VDPSetAutoIncrement:
    move.l   #VDPREG_AUTO_INCREMENT,-(sp)   ; AI Register
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
    move.l  d0,d2           ; Temporarily store in d2
    rol.l   #2,d2           ; Shift bits 31,30 into 1,0
    andi.l  #$3FFF0000,d0   ; zero out bits 31,30
    andi.l  #00000003,d2    ; Zero out every other bit 
    or.l   d2,d0           ; & result to get address layout
    ; Format Command
    move.l  d1,d2           ; Temp store in d2
    ror.l   #2,d2           ; Shift bits 1,0 into 31,30
    andi.l  #$C0000000,d2   ; Zero out every other bit 
    rol.l   #2,d1           ; Shift Left by 2 places
    andi.l  #$000000F0,d2   ; Zero out unwanted bits
    or.l   d2,d1            ; Combine Command bits
    or.l   d1,d0            ; Combine command and address bits
    rts
