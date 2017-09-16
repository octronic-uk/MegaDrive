;  ______   ______   __  __
; /\  __ \ /\  ___\ /\ \_\ \
; \ \  __ \\ \___  \\ \  __ \
;  \ \_\ \_\\/\_____\\ \_\ \_\
;   \/_/\/_/ \/_____/ \/_/\/_/
;      ash@octronic.co.uk
;
; TestingVDP.asm - Testing Useful VDP Definitions
;

TEST_REGISTER	    equ	$11
TEST_DATA		    equ	$DA
TEST_REG_EXPECTED   equ $91DA 
TEST_STATUS_VALUE   equ $B00B
TEST_AI_EXPECTED    equ $8F02
 
 	;public start    ;Make the entry point public
	org $1000       ;Place the origin at $2000

start:
	move.l  #TEST_REGISTER,-(sp)
	move.l	#TEST_DATA,-(sp)
	jsr 	_VDPWriteRegister
	addq.l  #8,sp
	
	cmpi.w  #TEST_REG_EXPECTED,VDP_CTRL_PORT
	bne     _TestFailed
	
	move.w  #TEST_STATUS_VALUE,VDP_CTRL_PORT
	jsr     _VDPReadStatusIntoD0
	
	cmpi.w  #TEST_STATUS_VALUE,d0
	bne     _TestFailed
	
	move.l  #2,-(sp)
	jsr     _VDPSetAutoIncrement
	addq.l  #4,sp
	
	cmpi.w  #TEST_AI_EXPECTED,VDP_CTRL_PORT
	
	
_TestingComplete:
	bra _TestingComplete


_TestFailed:
    bra _TestFailed
    
	include "../include/VDP.asm"
	
	org $00C00000
__FAKE_VDP:
	ds.b	1024
	
	SIMHALT
    END start