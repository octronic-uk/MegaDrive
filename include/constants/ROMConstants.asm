;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
; Sega Megadrive ROM header and Initialisation.

; System Constants
INITIAL_SP      equ $FFE000
ROM_START       equ $000000
RAM_START       equ $FF0000
RAM_END         equ $FFFFFF
SRAM_START      equ $000000
SRAM_END        equ $000000
RESET_BUTTON    equ $A1000C
RESET_AUX       equ $A10008
HW_VERSION      equ $A10001
TMSS_SIG        equ $A14000
CTRL_PORT_1     equ $A10009      
CTRL_PORT_2     equ $A1000B      
CTRL_PORT_EXP   equ $A1000D    
SEGA_STR        equ 'SEGA'

