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

__VDPSetDisplayMode:
    rts

; VDP Set Auto Increment Value
;   move.l #AI_VALUE,-(sp) 
;   jsr _VDPSetAutoIncrement
__VDPSetAutoIncrement:
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
__VDPWriteRegister:
    move.l  4(sp),d0           ; VDP Data
    move.l  8(sp),d1           ; VDP Register
    ori.b   #$80,d1            ; Register mask
    lsl     #8,d1              ; Shift to byte 2
    or.w    d1,d0              ; Or Register with Data
    move.w  d0,VDP_CTRL_PORT   ; Write to VDP
    rts
