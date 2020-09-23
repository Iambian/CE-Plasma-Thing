/*
 *--------------------------------------
 * Program Name:
 * Author:
 * License:
 * Description:
 *--------------------------------------
*/

/* Keep these headers */
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <tice.h>

/* Standard headers (recommended) */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* External library headers */
#include <debug.h>
#include <keypadc.h>
#include <graphx.h>
#include <compression.h>
#include <fileioc.h>

/* Put your function prototypes here */
#include "gfx/_gfx_img.h"

/* Put all your globals here */
uint16_t pj_HueTo1555(uint8_t hue);

void main(void) {
	int i,j,k;
	i = 0;
	gfx_Begin();
	gfx_SetPalette(_gfx_img_pal,sizeof__gfx_img_pal,0);
	zx7_Decompress((void*)0x0D40000,Plasmafractal_compressed);
	while (!kb_AnyKey()) {
		i = (i+1)&255;
		for (j=0;j<129;++j) {
			gfx_palette[j] = pj_HueTo1555(((i+j))&255);
		}
		//for (k=0;k<10000;++k);
		gfx_Wait();
	}
	
	gfx_End();
}

/* Put other functions here */

