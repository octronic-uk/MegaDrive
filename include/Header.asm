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
SEGA_STR        equ 'SEGA'
TMSS_SIG        equ $00A14000
CTRL_PORT_1     equ $000A10009      
CTRL_PORT_2     equ $000A1000B      
CTRL_PORT_EXP   equ $000A1000D    

    include "../include/VDPConstants.asm"
    include "../include/Z80Constants.asm"
    include "../include/PSGConstants.asm"

; Exception Table --------------------------------------------------------------
	dc.l   INITIAL_SP      ; Initial stack pointer value
	dc.l   _EntryPoint     ; Start of program
	dc.l   Exception       ; Bus error
	dc.l   Exception       ; Address error
	dc.l   Exception       ; Illegal instruction
	dc.l   Exception       ; Division by zero
	dc.l   Exception       ; CHK exception
	dc.l   Exception       ; TRAPV exception
	dc.l   Exception       ; Privilege violation
	dc.l   Exception       ; TRACE exception
	dc.l   Exception       ; Line-A emulator
	dc.l   Exception       ; Line-F emulator
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Spurious exception
	dc.l   Exception       ; IRQ level 1
	dc.l   Exception       ; IRQ level 2
	dc.l   Exception       ; IRQ level 3
	dc.l   HBlankInterrupt ; IRQ level 4 (horizontal retrace interrupt)
	dc.l   Exception       ; IRQ level 5
	dc.l   VBlankInterrupt ; IRQ level 6 (vertical retrace interrupt)
	dc.l   Exception       ; IRQ level 7
	dc.l   Exception       ; TRAP #00 exception
	dc.l   Exception       ; TRAP #01 exception
	dc.l   Exception       ; TRAP #02 exception
	dc.l   Exception       ; TRAP #03 exception
	dc.l   Exception       ; TRAP #04 exception
	dc.l   Exception       ; TRAP #05 exception
	dc.l   Exception       ; TRAP #06 exception
	dc.l   Exception       ; TRAP #07 exception
	dc.l   Exception       ; TRAP #08 exception
	dc.l   Exception       ; TRAP #09 exception
	dc.l   Exception       ; TRAP #10 exception
	dc.l   Exception       ; TRAP #11 exception
	dc.l   Exception       ; TRAP #12 exception
	dc.l   Exception       ; TRAP #13 exception
	dc.l   Exception       ; TRAP #14 exception
	dc.l   Exception       ; TRAP #15 exception
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
	dc.l   Exception       ; Unused (reserved)
; Header Section ---------------------------------------------------------------
	dc.b    'SEGA GENESIS    '                                 ; Console name
	dc.b    '(C)SEGA 1992.SEP'                                 ; Copyrght / Release
	dc.b    'Ashs Game                                       ' ; Domestic name
	dc.b    'Ashs Game                                       ' ; International name
	dc.b    'GM XXXXXXXX-XX'                                   ; Version number
	dc.w    $0000                                              ; Checksum
	dc.b    'J               '                                 ; I/O support
	dc.l    ROM_START                                          ; Start address of ROM
	dc.l    __end                                              ; End address of ROM
	dc.l    RAM_START                                          ; Start address of RAM
	dc.l    RAM_END                                            ; End address of RAM
	dc.l    $00000000                                          ; SRAM enabled
	dc.l    $00000000                                          ; Unused
	dc.l    SRAM_START                                         ; Start address of SRAM
	dc.l    SRAM_END                                           ; End address of SRAM
	dc.l    $00000000                                          ; Unused
	dc.l    $00000000                                          ; Unused
	dc.b    '                                        '         ; Notes (unused)
	dc.b    'JUE             '                                 ; Country codes
_EntryPoint: ; -----------------------------------------------------------------
    tst.w    RESET_AUX          ; Test mystery reset (expansion port reset?)
    bne      Main               ; Branch if Not Equal (to zero) - to Main
    tst.w    RESET_BUTTON       ; Test reset button
    bne      Main               ; Branch if Not Equal (to zero) - to Main

_SystemInit:
    move.l  #$00000000,d0       ; Place a 0 into d0, ready to copy to each longword of RAM
    move.l  #$00000000,a0       ; Starting from address $0, clearing backwards
    move.l  #$00003FFF,d1       ; Clearing 64k's worth of longwords (minus 1, for the loop 
                                ; to be correct)
_SystemInitClear:
    move.l  d0,-(a0)            ; Decrement the address by 1 longword, before moving the zero 
                                ; into it
    dbra    d1,_SystemInitClear ; Decrement d0, repeat until depleted

    move.b  HW_VERSION,d0       ; Move Megadrive hardware version to d0
    andi.b  #$0F,d0             ; The version is stored in last four bits, so mask it with 0F
    beq     _SkipTMSS           ; If version is equal to 0, skip TMSS signature
    move.l  #SEGA_STR,TMSS_SIG  ; Move the string 'SEGA' to $A14000

_SkipTMSS:
_Z80Init:
    move.w  #$0100,Z80_BUSREQ   ; Request access to the Z80 bus, by writing $0100 into the 
                                ; BUSREQ port
    move.w  #$0100,Z80_RESET    ; Hold the Z80 in a reset state, by writing $0100 into the 
                                ; RESET port
     
_Z80InitWait:
    btst    #$00,Z80_BUSREQ     ; Test bit 0 of A11100 to see if the 68k has access to the 
                                ; Z80 bus yet
    bne     _Z80InitWait        ; If we don't yet have control, branch back up to Wait

_Z80InitWrite:
    move.l #Z80Data,a0          ; Load address of data into a0
    move.l #Z80_RAM_BASE,a1     ; Copy Z80 RAM address to a1
    move.l #$29,d0              ; 42 bytes of init data (minus 1 for counter)

_Z80InitCopy:
    move.b  (a0)+,(a1)+         ; Copy data, and increment the source/dest addresses
    dbra    d0,_Z80InitCopy
    move.w  #Z80_BUS_DISABLE,Z80_RESET    ; Release reset state
    move.w  #Z80_BUS_DISABLE,Z80_BUSREQ   ; Release control of bus

_PSGInit:
    move.l  #PSGData,a0         ; Load address of PSG data into a0
    move.l  #$03,d0             ; 4 bytes of data

_PSGInitCopy:
    move.b (a0)+,PSG_RAM_BASE   ; Copy data to PSG RAM
    dbra d0,_PSGInitCopy

_VDPInit:
    move.l #VDPRegisters,a0     ; Load address of register table into a0
    move.l #$18,d0              ; 24 registers to write
    move.l #$00008000,d1        ; 'Set register 0' command (and clear the rest of d1 ready)
     
_VDPInitCopy:
    move.b (a0)+,d1             ; Move register value to lower byte of d1
    move.w  d1,VDP_CTRL_PORT    ; Write command and value to VDP control port
    add.w   #$0100,d1           ; Increment register #
    dbra    d0,_VDPInitCopy

_ControllerInit:                ; Set IN I/O direction, interrupts off, on all ports
    move.b #$00,CTRL_PORT_1     ; Controller port 1 CTRL
    move.b #$00,CTRL_PORT_2     ; Controller port 2 CTRL
    move.b #$00,CTRL_PORT_EXP   ; EXP port CTRL

_InitCleanup:
    move.l  #$00000000,a0       ; Move 0x0 to a0
    movem.l (a0),d0-d7/a1-a7    ; Multiple move 0 to all registers
    move    #$2700,sr           ; Init status register (no trace, A7 is Interrupt Stack 
Main:
    jmp __GameMain

; Interrupt Handlers -----------------------------------------------------------

HBlankInterrupt:
VBlankInterrupt:
   rte   ; Return from Exception
 
; Exception Handlers -----------------------------------------------------------

Exception:
   rte   ; Return from Exception

; Z80 Sample Program -----------------------------------------------------------
Z80Data:
    dc.w $af01, $d91f
    dc.w $1127, $0021
    dc.w $2600, $f977
    dc.w $edb0, $dde1
    dc.w $fde1, $ed47
    dc.w $ed4f, $d1e1
    dc.w $f108, $d9c1
    dc.w $d1e1, $f1f9
    dc.w $f3ed, $5636
    dc.w $e9e9, $8104
    dc.w $8f01
; PSG Sample Program -----------------------------------------------------------
PSGData:
   dc.w $9fbf, $dfff

; VDP Initial Values -----------------------------------------------------------
VDPRegisters:
    dc.b $20 ; $00: Horiz. interrupt on, plus bit 2 (unknown, but docs say it needs to be on)
    dc.b $74 ; $01: Vert. interrupt on, display on, DMA on, V28 mode (28 cells vertically), + bit 2
    dc.b $30 ; $02: Pattern table for Scroll Plane A at $C000 (bits 3-5)
    dc.b $40 ; $03: Pattern table for Window Plane at $10000 (bits 1-5)
    dc.b $05 ; $04: Pattern table for Scroll Plane B at $A000 (bits 0-2)
    dc.b $70 ; $05: Sprite table at $E000 (bits 0-6)
    dc.b $00 ; $06: Unused
    dc.b $00 ; $07: Background colour - bits 0-3 = colour, bits 4-5 = palette
    dc.b $00 ; $08: Unused
    dc.b $00 ; $09: Unused
    dc.b $00 ; $0A: Frequency of Horiz. interrupt in Rasters (number of lines travelled by the beam)
    dc.b $08 ; $0B: External interrupts on, V/H scrolling on
    dc.b $81 ; $0C: Shadows and highlights off, interlace off, H40 mode (40 cells horizontally)
    dc.b $34 ; $0D: Horiz. scroll table at $D000 (bits 0-5)
    dc.b $00 ; $0E: Unused
    dc.b $00 ; $0F: Autoincrement off
    dc.b $01 ; $10: Vert. scroll 32, Horiz. scroll 64
    dc.b $00 ; $11: Window Plane X pos 0 left (pos in bits 0-4, left/right in bit 7)
    dc.b $00 ; $12: Window Plane Y pos 0 up (pos in bits 0-4, up/down in bit 7)
    dc.b $00 ; $13: DMA length lo byte
    dc.b $00 ; $14: DMA length hi byte
    dc.b $00 ; $15: DMA source address lo byte
    dc.b $00 ; $16: DMA source address mid byte
    dc.b $00 ; $17: DMA source address hi byte, memory-to-VRAM mode (bits 6-7)
