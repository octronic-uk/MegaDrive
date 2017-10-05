PCBPalette:
	; --- Palette ---
	dc.w	$0000	;	Color $0 is transparent (so the actual value doesn't matter)
	dc.w	$0000	;	Color $1
	dc.w	$0004	;	Color $2
	dc.w	$0020	;	Color $3
	dc.w	$0008	;	Color $4
	dc.w	$0620	;	Color $5
	dc.w	$000e	;	Color $6
	dc.w	$0026	;	Color $7
	dc.w	$0444	;	Color $8
	dc.w	$0060	;	Color $9
	dc.w	$0c60	;	Color $a
	dc.w	$006c	;	Color $b
	dc.w	$00c0	;	Color $c
	dc.w	$0aaa	;	Color $d
	dc.w	$00ee	;	Color $e
	dc.w	$0eec	;	Color $f
PCBTilesStart:
	; --- Tiles ---
	dc.l	$33333333	;	Tile (col 0, row 0)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$9999999b
	dc.l	$3333333b
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33393333	;	Tile (col 1, row 0)
	dc.l	$33393333
	dc.l	$333933bb
	dc.l	$b33933bb
	dc.l	$b3393333
	dc.l	$33393333
	dc.l	$33393333
	dc.l	$33333333
	dc.l	$33333333	;	Tile (col 2, row 0)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33e33e33	;	Tile (col 3, row 0)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$99333333
	dc.l	$39333bb3
	dc.l	$39333bb3
	dc.l	$39333393
	dc.l	$39333399
	dc.l	$e33e3333	;	Tile (col 4, row 0)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$39333333	;	Tile (col 5, row 0)
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$36699999
	dc.l	$36633333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$99999933
	dc.l	$33339333	;	Tile (col 6, row 0)
	dc.l	$33339333
	dc.l	$3333933e
	dc.l	$9999999e
	dc.l	$3333933e
	dc.l	$33339333
	dc.l	$33339333
	dc.l	$33339333
	dc.l	$33333339	;	Tile (col 7, row 0)
	dc.l	$33333339
	dc.l	$1e1e1339
	dc.l	$1e1e1999
	dc.l	$1e1e1339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333333	;	Tile (col 0, row 1)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$33dd3333	;	Tile (col 1, row 1)
	dc.l	$33dd3333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$33333333	;	Tile (col 2, row 1)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$39333333	;	Tile (col 3, row 1)
	dc.l	$39333333
	dc.l	$dd333333
	dc.l	$dd333333
	dc.l	$99999999
	dc.l	$39333333
	dc.l	$99999999
	dc.l	$39333333
	dc.l	$33333333	;	Tile (col 4, row 1)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$999999f3
	dc.l	$33333393
	dc.l	$9999f393
	dc.l	$33339393
	dc.l	$33333933	;	Tile (col 5, row 1)
	dc.l	$33332923
	dc.l	$333d222d
	dc.l	$33332223
	dc.l	$333d222d
	dc.l	$33332223
	dc.l	$333d222d
	dc.l	$33332223
	dc.l	$33339333	;	Tile (col 6, row 1)
	dc.l	$33339333
	dc.l	$33339333
	dc.l	$33339333
	dc.l	$333dd999
	dc.l	$333dd333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333339	;	Tile (col 7, row 1)
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$33333366
	dc.l	$33333363
	dc.l	$99339339	;	Tile (col 0, row 2)
	dc.l	$33933933
	dc.l	$33393393
	dc.l	$33339339
	dc.l	$33333933
	dc.l	$33333393
	dc.l	$33333339
	dc.l	$3d3d3d3d
	dc.l	$99999999	;	Tile (col 1, row 2)
	dc.l	$93393333
	dc.l	$39339333
	dc.l	$33933933
	dc.l	$93393393
	dc.l	$39339339
	dc.l	$33933933
	dc.l	$3d3d3933
	dc.l	$99999999	;	Tile (col 2, row 2)
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$93333339
	dc.l	$f3333333
	dc.l	$99999999	;	Tile (col 3, row 2)
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$33933333
	dc.l	$93393333
	dc.l	$99f39393	;	Tile (col 4, row 2)
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$333d222d	;	Tile (col 5, row 2)
	dc.l	$33332223
	dc.l	$333d222d
	dc.l	$33332223
	dc.l	$333d222d
	dc.l	$33332223
	dc.l	$333d222d
	dc.l	$33332223
	dc.l	$33333333	;	Tile (col 6, row 2)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333bb3
	dc.l	$33333366	;	Tile (col 7, row 2)
	dc.l	$33333366
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$3dd33dd3
	dc.l	$3dd33dd3
	dc.l	$33333333
	dc.l	$33933933
	dc.l	$11111111	;	Tile (col 0, row 3)
	dc.l	$11111111
	dc.l	$11111111
	dc.l	$3d3d3d3d
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$11111933	;	Tile (col 1, row 3)
	dc.l	$11111933
	dc.l	$11111933
	dc.l	$3d3d3933
	dc.l	$39393933
	dc.l	$39393933
	dc.l	$39393933
	dc.l	$39393933
	dc.l	$93333333	;	Tile (col 2, row 3)
	dc.l	$93333333
	dc.l	$f333a334
	dc.l	$93333334
	dc.l	$93333334
	dc.l	$93333334
	dc.l	$93333334
	dc.l	$93333334
	dc.l	$39393333	;	Tile (col 3, row 3)
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$39393e3b
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$33939393	;	Tile (col 4, row 3)
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33332223	;	Tile (col 5, row 3)
	dc.l	$33332923
	dc.l	$33333933
	dc.l	$33333999
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333bb3	;	Tile (col 6, row 3)
	dc.l	$33333933
	dc.l	$33333933
	dc.l	$39999933
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$33933933	;	Tile (col 7, row 3)
	dc.l	$33933933
	dc.l	$33933933
	dc.l	$33933933
	dc.l	$33933933
	dc.l	$33933933
	dc.l	$33933933
	dc.l	$33933933
	dc.l	$33333333	;	Tile (col 0, row 4)
	dc.l	$33333333
	dc.l	$bb333333
	dc.l	$bb999999
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$39393393	;	Tile (col 1, row 4)
	dc.l	$39339339
	dc.l	$33933933
	dc.l	$33393393
	dc.l	$33339339
	dc.l	$33333933
	dc.l	$33333393
	dc.l	$33333339
	dc.l	$93333334	;	Tile (col 2, row 4)
	dc.l	$93333334
	dc.l	$93333334
	dc.l	$99333334
	dc.l	$93933334
	dc.l	$93393334
	dc.l	$f9339333
	dc.l	$93933933
	dc.l	$39393e3b	;	Tile (col 3, row 4)
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$39393e3b
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$33939393	;	Tile (col 4, row 4)
	dc.l	$33939393
	dc.l	$33939393
	dc.l	$33939399
	dc.l	$33939333
	dc.l	$33939999
	dc.l	$33933333
	dc.l	$33999999
	dc.l	$33333339	;	Tile (col 5, row 4)
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$99999999
	dc.l	$33333339
	dc.l	$99999999
	dc.l	$33333339
	dc.l	$99999999
	dc.l	$39333333	;	Tile (col 6, row 4)
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39999999
	dc.l	$39333333
	dc.l	$39999999
	dc.l	$39333333
	dc.l	$39999999
	dc.l	$33933933	;	Tile (col 7, row 4)
	dc.l	$33933933
	dc.l	$33933933
	dc.l	$99933999
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333339
	dc.l	$99999939
	dc.l	$33333339	;	Tile (col 0, row 5)
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333	;	Tile (col 1, row 5)
	dc.l	$33333333
	dc.l	$333333e3
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$3e333333
	dc.l	$33333333
	dc.l	$93393393	;	Tile (col 2, row 5)
	dc.l	$99339339
	dc.l	$93933933
	dc.l	$93393393
	dc.l	$93339339
	dc.l	$33333933
	dc.l	$33333393
	dc.l	$33333339
	dc.l	$39393333	;	Tile (col 3, row 5)
	dc.l	$39393333
	dc.l	$99393333
	dc.l	$39393333
	dc.l	$3339333c
	dc.l	$9333333c
	dc.l	$3999999c
	dc.l	$33333333
	dc.l	$33333333	;	Tile (col 4, row 5)
	dc.l	$33333333
	dc.l	$3ccc3333
	dc.l	$c333c333
	dc.l	$33333999
	dc.l	$3dd33333
	dc.l	$3dd33999
	dc.l	$c393c333
	dc.l	$33333339	;	Tile (col 5, row 5)
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333339
	dc.l	$39333333	;	Tile (col 6, row 5)
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$33333939	;	Tile (col 7, row 5)
	dc.l	$33333939
	dc.l	$343c3939
	dc.l	$34333939
	dc.l	$343c3939
	dc.l	$34333939
	dc.l	$343c3939
	dc.l	$34333939
	dc.l	$3333333d	;	Tile (col 0, row 6)
	dc.l	$3333333d
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333111
	dc.l	$3333d177
	dc.l	$33333172
	dc.l	$d33333dd	;	Tile (col 1, row 6)
	dc.l	$d33333dd
	dc.l	$33333393
	dc.l	$33333393
	dc.l	$33333393
	dc.l	$11111111
	dc.l	$77777777
	dc.l	$22222222
	dc.l	$33333333	;	Tile (col 2, row 6)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$13333333
	dc.l	$1d333333
	dc.l	$13333333
	dc.l	$93333333	;	Tile (col 3, row 6)
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$39393333
	dc.l	$39399999
	dc.l	$39333333
	dc.l	$66999999
	dc.l	$3ccc3333	;	Tile (col 4, row 6)
	dc.l	$33933333
	dc.l	$33933333
	dc.l	$33933333
	dc.l	$33933333
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$99999999
	dc.l	$33333339	;	Tile (col 5, row 6)
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$99999999
	dc.l	$33333333
	dc.l	$99333333
	dc.l	$39333333	;	Tile (col 6, row 6)
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$39333333
	dc.l	$3933dd33
	dc.l	$3999dd33
	dc.l	$33339333
	dc.l	$33339333
	dc.l	$343c3939	;	Tile (col 7, row 6)
	dc.l	$34333939
	dc.l	$343c3939
	dc.l	$34333939
	dc.l	$343c3939
	dc.l	$34333939
	dc.l	$343c3939
	dc.l	$33333939
	dc.l	$3333d172	;	Tile (col 0, row 7)
	dc.l	$33333172
	dc.l	$3333d172
	dc.l	$33333172
	dc.l	$3333d172
	dc.l	$33333172
	dc.l	$33333111
	dc.l	$33333333
	dc.l	$22222222	;	Tile (col 1, row 7)
	dc.l	$22222222
	dc.l	$22222222
	dc.l	$22222222
	dc.l	$22222222
	dc.l	$22222222
	dc.l	$11111111
	dc.l	$333c3333
	dc.l	$1d333333	;	Tile (col 2, row 7)
	dc.l	$13333333
	dc.l	$1d333333
	dc.l	$13333333
	dc.l	$1d333333
	dc.l	$13333333
	dc.l	$13333333
	dc.l	$33333333
	dc.l	$66333333	;	Tile (col 3, row 7)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$33e33e33
	dc.l	$88888888
	dc.l	$81111111
	dc.l	$81111111
	dc.l	$81111111
	dc.l	$33333333	;	Tile (col 4, row 7)
	dc.l	$33333333
	dc.l	$33333333
	dc.l	$e33e3333
	dc.l	$88888833
	dc.l	$11111833
	dc.l	$11111833
	dc.l	$11111833
	dc.l	$39335b44	;	Tile (col 5, row 7)
	dc.l	$393f5b44
	dc.l	$39335b44
	dc.l	$39333333
	dc.l	$3933555b
	dc.l	$393f555b
	dc.l	$3933555b
	dc.l	$39333333
	dc.l	$43339333	;	Tile (col 6, row 7)
	dc.l	$4f339333
	dc.l	$43339333
	dc.l	$33339333
	dc.l	$53339333
	dc.l	$5f339333
	dc.l	$53339333
	dc.l	$33339333
	dc.l	$33333939	;	Tile (col 7, row 7)
	dc.l	$33333939
	dc.l	$33333939
	dc.l	$3333bb39
	dc.l	$3333bb39
	dc.l	$33333339
	dc.l	$33333339
	dc.l	$33333339
PCBTilesEnd:

PCBTilesSizeB	    equ (PCBTilesEnd-PCBTilesStart) ; Font size in bytes
PCBTilesSizeW	    equ (PCBTilesSizeB/2)           ; Font size in words
PCBTilesSizeL	    equ (PCBTilesSizeB/4)           ; Font size in longs
PCBTilesSizeT	    equ (PCBTilesSizeB/32)          ; Font size in tiles
PCBTilesVRAM	    equ $0740                       ; Dest address in VRAM
PCBTilesTileID	    equ (PCBTilesVRAM/32)           ; ID of first tile

    nop     0,8

PCBLoadTiles:
    move.l  #PCBTilesVRAM,-(sp)     ; d0 - VRAM address
    jsr     VDPWriteVramMode
    addq.l  #4,sp
    move.l  #PCBTilesSizeT,d1       ; d1 - Num chars in tiles
    subq.b  #1,d1                   ; Num chars - 1
    lea     PCBTilesStart,a0        ; a0 - Font address
PCBLoadTilesCopy:
    move.w  #8,d2                   ; 8 longwords in tile
    subq.b  #1,d2                   ; - 1 for loop
PCBLoadTilesLongCopy:
    move.l  (a0)+,VDP_DATA_PORT     ; Copy one line of tile to VDP data port
    dbra    d2,PCBLoadTilesLongCopy
    dbra    d1,PCBLoadTilesCopy
    rts

PCBOnPlane:
    ; Setup VRAM Write
    movea.l  4(sp),a0
_PCB_On_Plane_Set_Address:
    move.l  a0,-(sp)
    jsr     VDPWriteVramMode
    addq.l  #4,sp
_PCB_On_Plane_Setup_Loop:
    ; d0: Tile ID
    move.l  #PCBTilesTileID,d0
    move.l  #8,d1 ; X Index
    subq.l  #1,d1
_PCB_On_Plane_Loop_X:
    move.l  #8,d2 ; Y Index
    subq.l  #1,d2
_PCB_On_Plane_Loop_Y:
    ; d3: Palette
    move.l  #1,d3
    ror.w   #3,d3
    clr.w   d7
    or.w    d0,d7
    or.w    d3,d7
    move.w  d7,VDP_DATA_PORT 
    addq.w  #1,d0   ; Advance Tile ID
    dbra d2,_PCB_On_Plane_Loop_Y
    ; Advance Line
    add.l   #128,a0
    movem.l d0-d7/a0,-(sp)
    move.l  a0,-(sp)
    jsr     VDPWriteVramMode
    addq.l  #4,sp
    movem.l (sp)+,d0-d7/a0
    dbra d1,_PCB_On_Plane_Loop_X
	rts

PCBPushPalette:
    ; Set autoincrement to 2 bytes
    move.l  #2,-(sp)
    jsr     VDPSetAutoIncrement
	addq.l  #4,sp

    ; Set up VDP to write to CRAM address $0000
    move.l  #$0020,-(sp)
    jsr     VDPWriteCramMode
    addq.l  #4,sp

    ; Load address of Palette into a0
    lea     PCBPalette,a0               
    ; 32 bytes of data (8 longwords, minus 1 for counter) in palette
    move.l  #8,d0                  
    subq.l  #1,d0                  

_PushPCBPaletteLoop:
    ; Move data to VDP data port, and increment source address
    move.l  (a0)+,VDP_DATA_PORT        
    dbra    d0,_PushPCBPaletteLoop

    rts

PCBDrawRow:
    move.l  4(sp),a0 ; Get start address into a0
    move.l  a0,a1    ; Setup End Address in a1
    add.l   #$80,a1  ; to be a0 + $60
PCBDrawRowLoop:
    movem.l  d0/a0-a1,-(sp) ; Cache Registers
    move.l  a0,-(sp)        ; Push Address Param
    jsr     PCBOnPlane      ; Draw PCB
    addq.l  #4,sp           ; Correct Stack
    movem.l  (sp)+,d0/a0-a1 ; Restore Registers
    add.l   #$10,a0         ; Add 16 to draw address
    cmp.l   a0,a1           ; Compare with limit
    bgt     PCBDrawRowLoop  ; Are we there yet?
    rts
