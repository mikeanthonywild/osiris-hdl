#ifndef __PLATFORM_CONFIG_H_
#define __PLATFORM_CONFIG_H_

#include "xparameters.h"

#define STDOUT_IS_PS7_UART
#define UART_DEVICE_ID 0

#define ENABLE_TEST_PATTERN 1

#define FRAMEBUF_WIDTH 640
#define FRAMEBUF_HEIGHT 480

#define LINE_VALID_INT_ID	61
#define FRAME_VALID_INT_ID	62
#define REQ_LINE_INT_ID		63
#define REQ_FRAME_INT_ID	64

#define I_BRAM_AXI_ADDR		0xC0000000
#define O_BRAM_AXI_ADDR 	0xC0001000

#define I_CDMA_DEVICE_ID	XPAR_I_AXI_CDMA_DEVICE_ID
#define O_CDMA_DEVICE_ID	XPAR_O_AXI_CDMA_DEVICE_ID

#define SCUGIC_DEVICE_ID 	XPAR_SCUGIC_0_DEVICE_ID

#endif
