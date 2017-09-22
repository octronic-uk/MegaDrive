;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk
;
; TestingVDP.asm - Testing Useful VDP Definitions
;

TEST_REGISTER           equ $11
TEST_DATA               equ $DA
TEST_REG_EXPECTED       equ $91DA 
TEST_STATUS_VALUE       equ $B00B
TEST_AI_EXPECTED        equ $8F02
TEST_CMD_WORD_EXPECTED  equ $02360061
TEST_CMD_COMMAND        equ $18
TEST_CMD_ADDRESS        equ $4236
TEST_RED                equ $3
TEST_GREEN              equ $5
TEST_BLUE               equ $7
TEST_RGB_EXPECTED       equ $0EA6

    include "../include/constants/VDPConstants.asm"

 	org $2000   ;Place the origin at $2000
    
start:

Test_VDPCreateRgbD0:
    move.w  #TEST_RED,-(sp)
    move.w  #TEST_GREEN,-(sp)
    move.w  #TEST_BLUE,-(sp)
    jsr     _VDPCreateRgbD0
    addq.l  #6,sp 
    cmpi.w  #TEST_RGB_EXPECTED,d0
    bne     _TestFailed

Test_VDPCreateCmdWord:
    move.l  #TEST_CMD_COMMAND,-(sp)
    move.l  #TEST_CMD_ADDRESS,-(sp)
    jsr     _VDPCreateCmdWord
    addq.l  #8,sp
    cmpi.l  #TEST_CMD_WORD_EXPECTED,d0
    bne     _TestFailed

Test_VDPCreateCmdWordCRAM:
    move.l  #VDP_CRAM_WRITE,-(sp)
    move.l  #$0000,-(sp)
    jsr     _VDPCreateCmdWord
    addq.l  #8,sp
    cmpi.l  #$C0000000,d0
    bne     _TestFailed

Test_VDPWriteRegister:
	move.l  #TEST_REGISTER,-(sp)
	move.l	#TEST_DATA,-(sp)
	jsr 	_VDPWriteRegister
	addq.l  #8,sp
	cmpi.w  #TEST_REG_EXPECTED,VDP_CTRL_PORT
	bne     _TestFailed
	
Test_VDPReadStatusD0:
	move.w  #TEST_STATUS_VALUE,VDP_CTRL_PORT
	jsr     _VDPReadStatusD0
	cmpi.w  #TEST_STATUS_VALUE,d0
	bne     _TestFailed
	
Test_VDPSetAutoIncrement:
	move.l  #2,-(sp)
	jsr     _VDPSetAutoIncrement
	addq.l  #4,sp
	cmpi.w  #TEST_AI_EXPECTED,VDP_CTRL_PORT
	
_TestingComplete:
	bra _TestingComplete


_TestFailed:
    bra _TestFailed
    
	include "../include/VDPLib.asm"
	
	org $00C00000
__FAKE_VDP:
	ds.b	1024
	
	SIMHALT
    END start
