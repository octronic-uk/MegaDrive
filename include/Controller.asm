;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
; Controller.asm

    include "../include/constants/ControllerConstants.asm"

; Returned Word format
;   |00SA0000|00CBRLDU|

; Usage
;   jsr     _CtrlrReadPad1D0
;
CtrlReadPad1D0:
    move.l #0,d0
    move.b #$00,CTRL_DATA_A  ; Put data port back to normal
    move.b CTRL_DATA_A,d0    ; Read upper byte from data port
    rol.w  #$8,d0            ; Move to upper byte of d0
    move.b #$40,CTRL_DATA_A  ; Write bit 7 to data port
    move.b CTRL_DATA_A,d0    ; Read lower byte from data port
    move.b #$00,CTRL_DATA_A  ; Put data port back to normal
    rts

; Usage
;   jsr     _CtrlrReadPad2D0
;
CtrlReadPad2D0:
    move.l #0,d0
    move.b #$00,CTRL_DATA_B  ; Put data port back to normal
    move.b CTRL_DATA_B,d0    ; Read upper byte from data port
    rol.w  #$8,d0            ; Move to upper byte of d0
    move.b #$40,CTRL_DATA_B  ; Write bit 7 to data port
    move.b CTRL_DATA_B,d0    ; Read lower byte from data port
    move.b #$00,CTRL_DATA_B   ; Put data port back to normal
    rts

