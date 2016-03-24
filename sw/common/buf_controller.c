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

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Variable Definitions *****************************/
static line_valid_flag;
static frame_valid_flag;
static req_line_flag;
static req_frame_flag;

/************************** Function Prototypes ******************************/
static void line_valid_isr(void *);
static void frame_valid_isr(void *);
static void req_line_isr(void *);
static void req_frame_isr(void *);

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


void buf_controller_update(void) {
    // Check the flags for transfers or address reset
    if (line_valid_flag) {

        line_valid_flag = 0;
    }

    if (frame_valid_flag) {

        frame_valid_flag = 0;
    }

    if (req_line_flag) {

        req_line_flag = 0;
    }

    if (req_frame_flag) {

        req_frame_flag = 0;
    }
}