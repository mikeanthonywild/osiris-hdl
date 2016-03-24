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
#include "config.h"
#include "framebuf.h"
#include "xaxicdma.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Variable Definitions *****************************/
static u32 line_valid_flag;
static u32 frame_valid_flag;
static u32 req_line_flag;
static u32 req_frame_flag;

static XAxiCdma i_cdma;
static XAxiCdma o_cdma;

static u32 framebuf_i_offset;
static u32 framebuf_o_offset;

/************************** Function Prototypes ******************************/
static void line_valid_isr(void *);
static void frame_valid_isr(void *);
static void req_line_isr(void *);
static void req_frame_isr(void *);

static s32 setup_buf_ctrl_interrupts(void);

s32 buf_controller_setup();
s32 buf_controller_update();

/*****************************************************************************/
s32 setup_buf_ctrl_interrupts(void) {
    int status;

    // line_valid
    status = create_interrupt(&g_int_ctrl, LINE_VALID_INT_ID, 0x8, TRIGGER_TYPE_EDGE_RISING, line_valid_isr);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // frame_valid
    status = create_interrupt(&g_int_ctrl, FRAME_VALID_INT_ID, 0x0, TRIGGER_TYPE_EDGE_RISING, frame_valid_isr);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // req_line
    status = create_interrupt(&g_int_ctrl, REQ_LINE_INT_ID, 0x8, TRIGGER_TYPE_EDGE_RISING, req_line_isr);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    // req_frame
    status = create_interrupt(&g_int_ctrl, REQ_FRAME_INT_ID, 0x0, TRIGGER_TYPE_EDGE_RISING, req_frame_isr);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}


void line_valid_isr(void *line_valid_flag) {
    line_valid_flag = 1;
}

void frame_valid_isr(void *frame_valid_flag) {
    frame_valid_flag = 1;
}

void req_line_isr(void *req_line_flag) {
    req_line_flag = 1;
}

void req_frame_isr(void *req_frame_flag) {
    req_frame_flag = 1;
}


s32 buf_controller_setup(void) {


    return XST_SUCCESS;
}


void buf_controller_update(void) {
    // Check the flags for transfers and address reset
    if (line_valid_flag) {
        XAxiCdma_Simple_Transfer(&i_cdma, src, dst, len, void, void)
        framebuf_i_offset++;
        line_valid_flag = 0;
    }

    if (frame_valid_flag) {
        framebuf_i_offset = 0;
        frame_valid_flag = 0;
    }

    if (req_line_flag) {
        XAxiCdma_Simple_Transfer(&o_cdma, src, dst, len, void, void)
        framebuf_o_offset++;
        req_line_flag = 0;
    }

    if (req_frame_flag) {
        framebuf_o_offset = 0;
        req_frame_flag = 0;
    }
}