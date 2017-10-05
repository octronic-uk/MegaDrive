;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
; Sega Megadrive ROM header and Initialisation.

; Include Constants ONLY
    include "../include/constants/ROMConstants.asm"
    include "../include/constants/VDPConstants.asm"
    include "../include/constants/Z80Constants.asm"
    include "../include/constants/PSGConstants.asm"

; Exception Table --------------------------------------------------------------
	dc.l   INITIAL_SP               ; Initial stack pointer value
	dc.l   _EntryPoint              ; Start of program
	dc.l   E_Bus                    ; Bus error
	dc.l   E_Address                ; Address error
	dc.l   E_IllegalInstruction     ; Illegal instruction
	dc.l   E_DivisionByZero         ; Division by zero
	dc.l   E_Chk                    ; CHK exception
	dc.l   E_TrapV                  ; TRAPV exception
	dc.l   E_PrivilegeViolation     ; Privilege violation
	dc.l   E_Trace                  ; TRACE exception
	dc.l   E_Line_A_Emulator        ; Line-A emulator
	dc.l   E_Line_F_Emulator        ; Line-F emulator
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   E_Spurious               ; Spurious exception
	dc.l   E_IRQ                    ; IRQ level 1
	dc.l   E_IRQ                    ; IRQ level 2
	dc.l   E_IRQ                    ; IRQ level 3
	dc.l   HBlankInterrupt          ; IRQ level 4 (horizontal retrace interrupt)
	dc.l   E_IRQ                    ; IRQ level 5
	dc.l   VBlankInterrupt          ; IRQ level 6 (vertical retrace interrupt)
	dc.l   E_IRQ                    ; IRQ level 7
	dc.l   E_Trap                   ; TRAP #00 exception
	dc.l   E_Trap                   ; TRAP #01 exception
	dc.l   E_Trap                   ; TRAP #02 exception
	dc.l   E_Trap                   ; TRAP #03 exception
	dc.l   E_Trap                   ; TRAP #04 exception
	dc.l   E_Trap                   ; TRAP #05 exception
	dc.l   E_Trap                   ; TRAP #06 exception
	dc.l   E_Trap                   ; TRAP #07 exception
	dc.l   E_Trap                   ; TRAP #08 exception
	dc.l   E_Trap                   ; TRAP #09 exception
	dc.l   E_Trap                   ; TRAP #10 exception
	dc.l   E_Trap                   ; TRAP #11 exception
	dc.l   E_Trap                   ; TRAP #12 exception
	dc.l   E_Trap                   ; TRAP #13 exception
	dc.l   E_Trap                   ; TRAP #14 exception
	dc.l   E_Trap                   ; TRAP #15 exception
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
	dc.l   Exception                ; Unused (reserved)
; Header Section ---------------------------------------------------------------
	dc.b    'SEGA MEGA DRIVE '                                 ; Console name
	dc.b    '(C)OCTRONIC 2017'                                 ; Copyrght / Release
	dc.b    'Ashs Game                                       ' ; Domestic name
	dc.b    'Ashs Game                                       ' ; International name
	dc.b    'GM 12345678-90'                                   ; Version number
	dc.w    $0000                                              ; Checksum
	dc.b    'J               '                                 ; I/O support
	dc.l    ROM_START                                          ; Start address of ROM
	dc.l    __end-1                                            ; End address of ROM
	dc.l    RAM_START                                          ; Start address of RAM
	dc.l    RAM_END                                            ; End address of RAM
	dc.l    $00000000                                          ; SRAM enabled
	dc.l    $00000000                                          ; Unused
	dc.l    SRAM_START                                         ; Start address of SRAM
	dc.l    SRAM_END                                           ; End address of SRAM
	dc.l    $00000000                                          ; Unused
	dc.l    $00000000                                          ; Unused
	dc.b    '                                        '         ; Notes (unused)
	dc.b    '  E             '                                 ; Country codes
; All this crap Should be $200 long

_EntryPoint: ; -----------------------------------------------------------------
	move    #$2700,sr	                ; Disable interrupts.
	tst.l   $A10008		                ; Test port A control.
	bne.s   _Header_PortA_Ok	        ; If so, magically branch.
	tst.w   $A1000C		                ; Test port C control.
_Header_PortA_Ok:
	bne.w   _Header_PortC_Ok
	move.b  $A10001,d0		            ; Get hardware version.
	andi.b  #$F,d0			            ; Compare.
	beq.s   _Header_SkipSecurity		; If the console has no TMSS, skip the security stuff.
	move.l  #'SEGA',$A14000	            ; Make the TMSS happy.
_Header_SkipSecurity:

_Header_Clear_RAM:
	lea     $FFFF0000,a0	            ; Load start of RAM into a0.
	move.w  #$3FFF,d0		            ; Clear $3FFF longwords.
	moveq.l #0,d1			            ; Clear d1.
_Header_Clear_RAM_Loop:
	move.l  d1,(a0)+		            ; Clear a long of RAM.
	dbra    d0,_Header_Clear_RAM_Loop	; Continue clearing RAM if there's anything left.

    move.l  #2,-(sp) 
    jsr     VDPSetAutoIncrement
    addq.l  #4,sp

    jsr     _Header_Clear_VRAM       
    jsr     _Header_Clear_CRAM
    jsr     _Header_Clear_VSRAM
    jmp     _Header_PortC_Ok
    

_Header_Clear_CRAM:
	moveq   #0,d0			            ; Clear d0.
	move.l  #$C0000000,$C00004	        ; Set VDP to CRAM write.
	move.w  #$3F,d7			            ; Clear the entire CRAM.
_Header_Clear_CRAM_Loop:
	move.w  d0,$C00000	                ; Write 0 to the data port.
	dbra    d7,_Header_Clear_CRAM_Loop	; Clear the CRAM.
    rts

_Header_Clear_VSRAM:
	moveq   #0,d0			            ; Clear d0.
	move.l  #$40000010,$C00004	        ; Set VDP to VSRAM write.
	move.w  #$4F,d7			            ; Clear the entire VSRAM.
_Header_Clear_VSRAM_Loop:
	move.w  d0,$C00000	                ; Write 0 to the data port.
	dbra    d7,_Header_Clear_VSRAM_Loop	; Clear the VSRAM.
    rts

_Header_Clear_VRAM:
	moveq   #0,d0			            ; Clear d0.
	move.l  #$40000000,$C00004	        ; Set VDP to VRAM write.
	move.w  #$7FFF,d7			        ; Clear the entire VRAM.
_Header_Clear_VRAM_Loop:
	move.w  d0,$C00000	                ; Write 0 to the data port.
	dbra    d7,_Header_Clear_VRAM_Loop	; Clear the VRAM.
    rts

_Header_PortC_Ok:
	bsr.w   _Header_Z80Init		; Initialize the Z80.
	move    #$2300,sr		; Enable interrupts.
	jmp     Main    		; Branch to main program.
	nop

_Header_Z80Init:
    move.w  #$0100,Z80_BUSREQ   ; Request access to the Z80 bus, by writing $0100 into the BUSREQ port
    move.w  #$0100,Z80_RESET    ; Hold the Z80 in a reset state, by writing $0100 into the RESET port
     
_Header_Z80InitWait:
    btst    #$00,Z80_BUSREQ     ; Test bit 0 of A11100 to see if the 68k has access to the  Z80 bus yet
    bne     _Header_Z80InitWait        ; If we don't yet have control, branch back up to Wait

_Header_Z80InitWrite:
    move.l #Z80Data,a0          ; Load address of data into a0
    move.l #Z80_RAM_BASE,a1     ; Copy Z80 RAM address to a1
    move.l #$29,d0              ; 42 bytes of init data (minus 1 for counter)

_Header_Z80InitCopy:
    move.b  (a0)+,(a1)+         ; Copy data, and increment the source/dest addresses
    dbra    d0,_Header_Z80InitCopy
    move.w  #Z80_BUS_DISABLE,Z80_RESET    ; Release reset state
    move.w  #Z80_BUS_DISABLE,Z80_BUSREQ   ; Release control of bus

_Header_PSGInit:
    move.l  #PSGData,a0         ; Load address of PSG data into a0
    move.l  #$03,d0             ; 4 bytes of data

_Header_PSGInitCopy:
    move.b (a0)+,PSG_RAM_BASE   ; Copy data to PSG RAM
    dbra d0,_Header_PSGInitCopy

_Header_VDPInit:
    move.l #VDPRegisters,a0     ; Load address of register table into a0
    move.l #$18,d0              ; 24 registers to write
    move.l #$00008000,d1        ; 'Set register 0' command (and clear the rest of d1 ready)
     
_Header_VDPInitCopy:
    move.b (a0)+,d1             ; Move register value to lower byte of d1
    move.w  d1,VDP_CTRL_PORT    ; Write command and value to VDP control port
    add.w   #$0100,d1           ; Increment register #
    dbra    d0,_Header_VDPInitCopy

_Header_ControllerInit:                ; Set IN I/O direction, interrupts off, on all ports
    move.b #$00,CTRL_PORT_1     ; Controller port 1 CTRL
    move.b #$00,CTRL_PORT_2     ; Controller port 2 CTRL
    move.b #$00,CTRL_PORT_EXP   ; EXP port CTRL

_Header_InitCleanup:
    move.l  #$0,a0              ; Move $0 to a0
    movem.l (a0),d0-d7/a1-a6    ; Multiple move 0 to all registers

_Header_LoadFont:
    jsr     _TextLoadFont

_Header_EnableInterrupts:
	move    #$2300,sr		; Enable interrupts.

Main:
    jmp __GameMain

; Interrupt Handlers -----------------------------------------------------------

HBlankInterrupt:
VBlankInterrupt:
   rte   ; Return from Exception
 
; Exception Handlers -----------------------------------------------------------


E_Bus:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_BUS_ERROR_STR
    jmp     ExceptionMsg

E_Address:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_ADDRESS_ERROR_STR
    jmp     ExceptionMsg

E_IllegalInstruction:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_ILLEGAL_INSTRUCTION_STR
    jmp     ExceptionMsg

E_DivisionByZero:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_DIVISION_BY_ZERO_STR
    jmp     ExceptionMsg

E_Chk:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_CHK_EXCEPTION_STR
    jmp     ExceptionMsg

E_TrapV:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_TRAPV_EXCEPTION_STR
    jmp     ExceptionMsg

E_PrivilegeViolation:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_PRIVILEGE_VIOLATION_STR
    jmp     ExceptionMsg

E_Trace:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_TRACE_EXCEPTION_STR
    jmp     ExceptionMsg

E_Line_A_Emulator:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_LINE_A_EMULATOR_STR
    jmp     ExceptionMsg

E_Line_F_Emulator:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_LINE_F_EMULATOR_STR
    jmp     ExceptionMsg

E_Spurious:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_SPURIOUS_EXCEPTION_STR
    jmp     ExceptionMsg

E_IRQ:
    movem.l d0-d7/a0-a6,-(sp)
    pea     E_IRQ_STR
    jmp     ExceptionMsg

E_Trap:
    movem.l d0-d7/a0-a7,-(sp)
    pea     E_TRAP_EXCEPTION_STR
    jmp     ExceptionMsg

ExceptionMsg:
    move.l  #2,-(sp)
    jsr     VDPSetAutoIncrement
    addq.l  #4,sp
    move.l  #_PixelFontTileID,-(sp) ; First font tile
    move.l  #$0001,-(sp)            ; X,Y
    move.l  #$0,-(sp)               ; Palette Index
    jsr     _TextOnPlaneA
    add.l   #16,sp

Exception:
    pea     EXCEPTION_STRING        ; String
    move.l  #_PixelFontTileID,-(sp) ; First font tile
    move.l  #$0000,-(sp)            ; X,Y
    move.l  #$0,-(sp)               ; Palette Index
    jsr     _TextOnPlaneA
    add.l   #16,sp
    movem.l (sp)+,d0-d7/a0-a6
    rte                             ; Return from Exception

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
    dc.b $14 ; 0:  H interrupt on, palettes on
    dc.b $74 ; 1:  V interrupt on, display on, DMA on, Genesis mode on
    dc.b $30 ; 2:  Pattern table for Scroll Plane A at VRAM $C000 (bits 3-5 = bits 13-15)
    dc.b $00 ; 3:  Pattern table for Window Plane at VRAM $0000 (disabled) (bits 1-5 = bits 11-15)
    dc.b $07 ; 4:  Pattern table for Scroll Plane B at VRAM $E000 (bits 0-2 = bits 11-15)
    dc.b $78 ; 5:  Sprite table at VRAM $F000 (bits 0-6 = bits 9-15)
    dc.b $00 ; 6:  Unused
    dc.b $00 ; 7:  Background colour - bits 0-3 = colour, bits 4-5 = palette
    dc.b $00 ; 8:  Unused
    dc.b $00 ; 9:  Unused
    dc.b $08 ; 10: Frequency of Horiz. interrupt in Rasters (number of lines travelled by the beam)
    dc.b $00 ; 11: External interrupts off, V scroll fullscreen, H scroll fullscreen
    dc.b $81 ; 12: Shadows and highlights off, interlace off, H40 mode (320 x 224 screen res)
    dc.b $3F ; 13: Horiz. scroll table at VRAM $FC00 (bits 0-5)
    dc.b $00 ; 14: Unused
    dc.b $02 ; 15: Autoincrement 2 bytes
    dc.b $01 ; 16: Vert. scroll 32, Horiz. scroll 64
    dc.b $00 ; 17: Window Plane X pos 0 left (pos in bits 0-4, left/right in bit 7)
    dc.b $00 ; 18: Window Plane Y pos 0 up (pos in bits 0-4, up/down in bit 7)
    dc.b $FF ; 19: DMA length lo byte
    dc.b $FF ; 20: DMA length hi byte
    dc.b $00 ; 21: DMA source address lo byte
    dc.b $00 ; 22: DMA source address mid byte
    dc.b $80 ; 23: DMA source address hi byte, memory-to-VRAM mode (bits 6-7)

EXCEPTION_STRING:
    dc.b    "WHAT KIND OF FUCKERY IS THIS???",0,0
E_BUS_ERROR_STR:
    dc.b    "BUS ERROR              ",0,0
E_ADDRESS_ERROR_STR:
    dc.b    "ADDRESS ERROR          ",0,0
E_ILLEGAL_INSTRUCTION_STR:
    dc.b    "ILLEGAL INSTRUCTION    ",0,0
E_DIVISION_BY_ZERO_STR:
    dc.b    "DIVISION BY ZERO       ",0,0
E_CHK_EXCEPTION_STR:
    dc.b    "CHK EXCEPTION          ",0,0
E_TRAPV_EXCEPTION_STR:
    dc.b    "TRAPV EXCEPTION        ",0,0
E_PRIVILEGE_VIOLATION_STR:
    dc.b    "PRIVILEGE VIOLATION    ",0,0
E_TRACE_EXCEPTION_STR:
    dc.b    "TRACE EXCEPTION        ",0,0
E_LINE_A_EMULATOR_STR:
    dc.b    "LINE A EMULATOR        ",0,0
E_LINE_F_EMULATOR_STR:
    dc.b    "LINE F EMULATOR        ",0,0
E_SPURIOUS_EXCEPTION_STR: 
    dc.b    "SPURIOUS EXCEPTION     ",0,0
E_IRQ_STR:
    dc.b    "IRQ                    ",0,0
E_TRAP_EXCEPTION_STR:
    dc.b    "TRAP_EXCEPTION         ",0,0
