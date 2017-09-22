;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
; Sega Megadrive ROM header and Initialisation.

; System Constants
INITIAL_SP      equ $00FFE000
ROM_START       equ $00000000
RAM_START       equ $00FF0000
RAM_END         equ $00FFFFFF
SRAM_START      equ $00000000
SRAM_END        equ $00000000
RESET_BUTTON    equ $00A1000C
RESET_AUX       equ $00A10008
HW_VERSION      equ $00A10001
TMSS_SIG        equ $00A14000
CTRL_PORT_1     equ $00A10009      
CTRL_PORT_2     equ $00A1000B      
CTRL_PORT_EXP   equ $00A1000D    
SEGA_STR        equ 'SEGA'


