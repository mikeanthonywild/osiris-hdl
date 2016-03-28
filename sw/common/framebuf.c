/*
 * framebuf.c
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 24th March 2016
 *
 * Library for accessing the global framebuffer 
 *
 */

/***************************** Include Files *********************************/
#include "framebuf.h"
#include "platform_config.h"
#include "string.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Variable Definitions *****************************/
u8 g_framebuf[FRAMEBUF_HEIGHT][FRAMEBUF_WIDTH];

/************************** Function Prototypes ******************************/


/*****************************************************************************/
void init_framebuf(void) {
	memset(g_framebuf, 0x00, sizeof(g_framebuf[0][0]) * FRAMEBUF_HEIGHT * FRAMEBUF_WIDTH);
}
