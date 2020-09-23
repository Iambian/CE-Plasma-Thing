.assume adl=1
XDEF _pj_HueTo1555



;Computing most of this in 8.8 fixed point, represented as an int.
;Note: 1524 comes from 65536/43, where 43 is roughly (256/6), or 1/6th of
;a complete rotation around our "special" color wheel.
;  0- 43: N*1524
; 44-127: 65535
;128-171: -(N-171)*1524
;172-255: 0
;
;1555: IRRR_RRGG:GGGB_BBBB
_pj_HueTo1555:
	pop bc
	pop de
	push de
	push bc
	ld a,e
	ld c,e
	call hto1555_single  ;get G. bits in GGGG_G***. Moveto: GGG*_**GG
	and a,248    ;GGGG_G***
	rlca         ;GGGG_***G
	rlca         ;GGG*_**GG
	ld h,a       ;save raw to high (reprocess later to replace upper bits
	and a,224    ;GGG0_0000
	ld l,a       ;save processed to low
	ld a,c
	sub a,171    ;blue offset
	call hto1555_single ;get B. bits in BBBB_B***. Moveto: ***B_BBBB
	and a,248    ;BBBB_B***
	rrca         ;*BBB_BB**
	rrca         ;**BB_BBB*
	rrca         ;***B_BBBB
	or L
	ld L,a       ;GGGB_BBBB (low byte)
	ld a,c
	sub a,85     ;red offset
	call hto1555_single ;get R. bits in RRRR_R***. Moveto: 1RRR_RR**
	and a,248    ;RRRR_R000
	inc a        ;RRRR_R001
	rrca         ;1RRR_RR00
	xor h        ;1R^G
	and 252      ;####_##00
	xor h        ;1RRR_RRGG
	ld h,a       ;HL is now set up for stuffs.
	ret
	

;in: A=hue, out A= (H_GREEN).
;(To get red, pass in A = A-85. To get blue, pass in A = A-171
;destroys HL
hto1555_single:
	cp 44
	jr nc,hto1555s_skipasc
hto1555_slide:
	ld  e,a
	ld  d,a
	add a,a
	add a,a
	add a,e  ;high byte const of 1524 (5) as repeated adds
	ld  e,224 ;low byte const of 1524 (224)
	mlt de
	add a,d ;10b
	ret
hto1555s_skipasc:
	bit 7,a
	jr nz,hto1555s_skipmax
	ld a,255
	ret
hto1555s_skipmax:
	sub a,172
	jr nc,hto1555s_skiptomin
	cpl     ; -(N-171) but we can -(N-172)+1. I think?
	jr hto1555_slide
hto1555s_skiptomin:
	xor a
	ret
	
	
;Note: 0E30200h is the start of the 512 byte color palette. (RGB 1555)
;NOte: 0E30800h is the start of CursorImage (1KB of high speed memory)
