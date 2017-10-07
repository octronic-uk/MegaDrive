;  ______   ______   __  __    
; /\  __ \ /\  ___\ /\ \_\ \   
; \ \  __ \\ \___  \\ \  __ \  
;  \ \_\ \_\\/\_____\\ \_\ \_\ 
;   \/_/\/_/ \/_____/ \/_/\/_/ 
;      ash@octronic.co.uk      
;
;   Exception.asm - Exception Routines

 
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
    jsr     VDP_SetAutoIncrement
    addq.l  #VDP_SET_AUTO_INCREMENT_ALIGN,sp

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


EXCEPTION_STRING:
    dc.b    "WHAT KIND OF FUCKERY IS THIS???",0,0
E_BUS_ERROR_STR:
    dc.b    "BUS ERROR",0,0
E_ADDRESS_ERROR_STR:
    dc.b    "ADDRESS ERROR",0,0
E_ILLEGAL_INSTRUCTION_STR:
    dc.b    "ILLEGAL INSTRUCTION",0,0
E_DIVISION_BY_ZERO_STR:
    dc.b    "DIVISION BY ZERO",0,0
E_CHK_EXCEPTION_STR:
    dc.b    "CHK EXCEPTION",0,0
E_TRAPV_EXCEPTION_STR:
    dc.b    "TRAPV EXCEPTION",0,0
E_PRIVILEGE_VIOLATION_STR:
    dc.b    "PRIVILEGE VIOLATION",0,0
E_TRACE_EXCEPTION_STR:
    dc.b    "TRACE EXCEPTION",0,0
E_LINE_A_EMULATOR_STR:
    dc.b    "LINE A EMULATOR",0,0
E_LINE_F_EMULATOR_STR:
    dc.b    "LINE F EMULATOR",0,0
E_SPURIOUS_EXCEPTION_STR: 
    dc.b    "SPURIOUS EXCEPTION",0,0
E_IRQ_STR:
    dc.b    "IRQ Exception",0,0
E_TRAP_EXCEPTION_STR:
    dc.b    "TRAP_EXCEPTION",0,0
