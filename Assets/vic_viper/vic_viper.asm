;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk

; Order in VRAM
;   C   = $0F40
;   D1
;   D2
;   D3
;   D4
;   U1
;   U2
;   U3
;   U4

    ; Colour Palette
    include "../Assets/vic_viper/Palette.asm"
    ; Centre Frame
    include "../Assets/vic_viper/C.asm"
    ; Down Frames
    include "../Assets/vic_viper/D1.asm"
    include "../Assets/vic_viper/D2.asm"
    include "../Assets/vic_viper/D3.asm"
    include "../Assets/vic_viper/D4.asm"
    ; Up Frames
    include "../Assets/vic_viper/U1.asm"
    include "../Assets/vic_viper/U2.asm"
    include "../Assets/vic_viper/U3.asm"
    include "../Assets/vic_viper/U4.asm"
