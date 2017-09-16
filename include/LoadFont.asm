; ------------------------------------------------------------------------------
;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   LoadFont.asm - Load a font into VDP memory.
;   Shoutouts to: BigEvilCorporation
;
; ------------------------------------------------------------------------------
;
; LoadFontFn Setup
;
; Stack:
;   #$4(sp) - Font address (l)
;   #$8(sp) - VRAM address 
;   #$C(sp) - Num chars 
;
; Registers:
;   Unused
;
LoadFontFn:
    movea.l #$4(sp),a0
    move.l  #$8(sp),d0
    move.l  #$c(sp),d1

    swap    d0                  ; Shift VRAM addr to upper word
    add.l   #vdp_write_tiles,d0 ; VRAM write cmd + VRAM destination address
    move.l  d0,vdp_control      ; Send address to VDP cmd port
    subq.b  #0x1, d1            ; Num chars - 1
_LoadFontCharCopy:
    move.w   #0x07,d2           ; 8 longwords in tile
_LoadFontLongCopy:
    move.l   (a0)+,vdp_data      ; Copy one line of tile to VDP data port
    dbra     d2,_LoadFontLongCopy
    dbra     d1,_LoadFontCharCopy
 
    rts
