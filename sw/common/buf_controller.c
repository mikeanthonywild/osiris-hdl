/*
 * buf_controller.c
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 24th March 2016
 *
 * Handles buf_controller interrupts from fabric and manages
 * linebuffer-framebuffer transfers.
 *
 */

/***************************** Include Files *********************************/
#include "buf_controller.h"
#include "interrupt.h"
#include "platform_config.h"
#include "framebuf.h"
#include "xaxicdma.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Variable Definitions *****************************/
volatile static int line_valid_flag;
volatile static int frame_valid_flag;
volatile static int req_line_flag;
volatile static int req_frame_flag;

static XAxiCdma i_cdma;
static XAxiCdma o_cdma;
static XAxiCdma_Config *i_cdma_cfg_p;
static XAxiCdma_Config *o_cdma_cfg_p;

static u8 (*i_framebuffer_line_p)[FRAMEBUF_WIDTH] = &g_framebuf[0];
static u8 (*o_framebuffer_line_p)[FRAMEBUF_WIDTH] = &g_framebuf[0];

/************************** Function Prototypes ******************************/
static void line_valid_isr(void *);
static void frame_valid_isr(void *);
static void req_line_isr(void *);
static void req_frame_isr(void *);

static int init_buf_ctrl_interrupts(void);

/*****************************************************************************/
int init_buf_ctrl_interrupts(void) {
    int status;

    // line_valid
    status = create_interrupt(&g_int_ctrl, LINE_VALID_INT_ID, 0x8, TRIGGER_TYPE_EDGE_RISING, &line_valid_isr, NULL);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // frame_valid
    status = create_interrupt(&g_int_ctrl, FRAME_VALID_INT_ID, 0x0, TRIGGER_TYPE_EDGE_RISING, &frame_valid_isr, NULL);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // req_line
    status = create_interrupt(&g_int_ctrl, REQ_LINE_INT_ID, 0x8, TRIGGER_TYPE_EDGE_RISING, &req_line_isr, NULL);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // req_frame
    status = create_interrupt(&g_int_ctrl, REQ_FRAME_INT_ID, 0x0, TRIGGER_TYPE_EDGE_RISING, &req_frame_isr, NULL);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}


void line_valid_isr(void *line_valid_flag) {
    *((int *)line_valid_flag) = 1;
}

void frame_valid_isr(void *frame_valid_flag) {
	*((int *)frame_valid_flag) = 1;
}

void req_line_isr(void *req_line_flag) {
	*((int *)req_line_flag) = 1;
}

void req_frame_isr(void *req_frame_flag) {
	*((int *)req_frame_flag) = 1;
}


int init_axi_cdma(void) {
    int status;
    

    // AXI CDMA for i_buf_controller
    i_cdma_cfg_p = XAxiCdma_LookupConfig(I_CDMA_DEVICE_ID);
    if (!i_cdma_cfg_p) {
        return XST_FAILURE;
    }
    status = XAxiCdma_CfgInitialize(&i_cdma, i_cdma_cfg_p, i_cdma_cfg_p->BaseAddress);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XAxiCdma_IntrDisable(&i_cdma, XAXICDMA_XR_IRQ_ALL_MASK);    // We don't need interrupts

    // AXI CDMA for o_buf_controller
    o_cdma_cfg_p = XAxiCdma_LookupConfig(O_CDMA_DEVICE_ID);
    if (!o_cdma_cfg_p) {
        return XST_FAILURE;
    }
    status = XAxiCdma_CfgInitialize(&o_cdma, o_cdma_cfg_p, o_cdma_cfg_p->BaseAddress);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XAxiCdma_IntrDisable(&o_cdma, XAXICDMA_XR_IRQ_ALL_MASK);    // We don't need interrupts


    return XST_SUCCESS;
}


int init_buf_controller(void) {
    int status;

    status = init_buf_ctrl_interrupts();
    if (status != XST_SUCCESS) {
    	return XST_FAILURE;
    }

    return XST_SUCCESS;
}


void update_buf_controller(void) {
    // Check the flags for transfers and address reset
    if (line_valid_flag) {
        // TODO: Do we need to flush the cache?
        /* Flush the SrcBuffer before the DMA transfer, in case the Data Cache
         * is enabled
         */
        //Xil_DCacheFlushRange((UINTPTR)&SrcBuffer, Length);
        XAxiCdma_SimpleTransfer(&i_cdma, (UINTPTR)I_BRAM_AXI_ADDR, (UINTPTR)i_framebuffer_line_p, FRAMEBUF_WIDTH, NULL, NULL);
        i_framebuffer_line_p++;
        line_valid_flag = 0;
    }

    if (frame_valid_flag) {
        i_framebuffer_line_p = &g_framebuf[0];
        frame_valid_flag = 0;
    }

    if (req_line_flag) {
    	XAxiCdma_SimpleTransfer(&o_cdma, (UINTPTR)o_framebuffer_line_p, (UINTPTR)O_BRAM_AXI_ADDR, FRAMEBUF_WIDTH, NULL, NULL);
        o_framebuffer_line_p++;
        req_line_flag = 0;
    }

    if (req_frame_flag) {
        o_framebuffer_line_p = &g_framebuf[0];
        req_frame_flag = 0;
    }
}
