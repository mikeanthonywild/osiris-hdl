/*
 * storage_manager.c
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 24th March 2016
 *
 * Library for saving frames to SD card.
 *
 */

/***************************** Include Files *********************************/
#include "xsdps.h"
#include "ff.h"
#include "framebuf.h"
#include "platform_config.h"
#include "storage_manager.h"
#include <xgpio.h>
#include <stdio.h>

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Variable Definitions *****************************/
static FIL fh;
static FATFS fatfs;
static char *basename = "IMAGE";
static TCHAR *root_path = "0:/";
static XGpio push_buttons;
static int button_data = 0;
static int button_pressed = 0;
static int frameno;

/************************** Function Prototypes ******************************/
int get_next_free_frame(void);
int save_frame(void);

/*****************************************************************************/
int init_storage_manager(void) {
	FRESULT status;

	// Mount the SD card
	status = f_mount(&fatfs, root_path, 0);
	if (status != FR_OK) {
		return XST_FAILURE;
	}

	frameno = get_next_free_frame();

	// Init GPIO
	XGpio_Initialize(&push_buttons, GPIO_DEVICE_ID);
	XGpio_SetDataDirection(&push_buttons, 1, 0xF);

	// First file is empty for some reason, so get it over with now...
	save_frame();

	xil_printf("Initialised storage manager...\n");

	return XST_SUCCESS;
}


void update_storage_manager(void) {
	button_data = XGpio_DiscreteRead(&push_buttons, 1);

	if (button_data && !button_pressed) {
		xil_printf("Saving frame...\n");
		save_frame();
		button_pressed = 1;
	}

	if (!button_data) {
		button_pressed = 0;
	}
}


int get_next_free_frame(void) {
	char filename[13];	// IMAGEXXX.PGM\0
	int i = 0;

	while (1) {
		sprintf(filename, "%s%03d.PGM", basename, i);
		switch (f_stat(filename, NULL)) {
		case FR_OK:
			break;
		case FR_NO_FILE:
			return i;
		default:
			return -1;
		}

		i++;
	}
}


int save_frame(void) {
	FRESULT status;
	int line, pixel;
	char filename[13];	// IMAGEXXX.PGM\0

	sprintf(filename, "%s%03d.PGM", basename, frameno);
	status = f_open(&fh, filename, FA_CREATE_ALWAYS | FA_WRITE);
	if (status != FR_OK) {
		return XST_FAILURE;
	}

	status = f_lseek(&fh, 0);
	if (status != FR_OK) {
		return XST_FAILURE;
	}

	(void)f_puts("P2\n640 480\n255\n", &fh);

	Xil_DCacheFlushRange((UINTPTR)g_framebuf, FRAMEBUF_WIDTH * FRAMEBUF_HEIGHT);
	for (line=0; line<FRAMEBUF_HEIGHT; line++) {
		for (pixel=0; pixel<FRAMEBUF_WIDTH; pixel++) {
			f_printf(&fh, "%d ", g_framebuf[line][pixel]);
		}
		f_putc('\n', &fh);
	}

	status = f_close(&fh);
	if (status != FR_OK) {
		return XST_FAILURE;
	}

	frameno++;

	return XST_SUCCESS;
}
