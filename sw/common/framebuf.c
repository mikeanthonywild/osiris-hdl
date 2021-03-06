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
#include "xil_types.h"
#include "vga_test_pattern.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Variable Definitions *****************************/
// Make sure this 32-bit aligned for FATFS transfer
u8 g_framebuf[FRAMEBUF_HEIGHT][FRAMEBUF_WIDTH] __attribute__ ((aligned(32)));

/************************** Function Prototypes ******************************/


/*****************************************************************************/
void init_framebuf(void) {
#ifdef ENABLE_TEST_PATTERN
    memcpy(g_framebuf, test_pattern, sizeof(g_framebuf[0][0]) * FRAMEBUF_HEIGHT * FRAMEBUF_WIDTH);
#else
    memset(g_framebuf, 0x00, sizeof(g_framebuf[0][0]) * FRAMEBUF_HEIGHT * FRAMEBUF_WIDTH);
#endif
}
