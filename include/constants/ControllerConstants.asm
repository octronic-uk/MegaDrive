;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
; ControllerConstants.asm

; Port Addresses
CTRL_DATA_A equ $00A10003 
CTRL_DATA_B equ $00A10005
 
; Bit number of button in data word
CTRL_UP     equ $0
CTRL_DOWN   equ $1
CTRL_LEFT   equ $2
CTRL_RIGHT  equ $3
CTRL_B      equ $4
CTRL_C      equ $5
CTRL_A      equ $C
CTRL_START  equ $D

