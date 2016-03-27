/*
 * interrupt.c
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 24th March 2016
 *
 * Helper functions for setting up interrupts.
 *
 */

/***************************** Include Files *********************************/
#include "interrupt.h"
#include "xscugic.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Variable Definitions *****************************/


/************************** Function Prototypes ******************************/


/*****************************************************************************/
int create_interrupt(XScuGic *instance_p, u32 int_id, u8 priority, trigger_t trigger, Xil_InterruptHandler isr, void *callback_ref) {
    int status;

    // Connect interrupt controller hardware driver
    status = XScuGic_Connect(instance_p, int_id, isr, callback_ref);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    status = XScuGic_SetPriorityTriggerType(instance_p, int_id, priority, trigger);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    status = XScuGic_Enable(instance_p, int_id);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}