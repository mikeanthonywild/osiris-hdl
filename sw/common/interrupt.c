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
#include "xil_exception.h"
#include "platform_config.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Variable Definitions *****************************/
XScuGic g_int_ctrl;
static XScuGic_Config *int_ctrl_cfg_p;

/************************** Function Prototypes ******************************/


/*****************************************************************************/
int init_interrupts(void) {
	int status;

	Xil_ExceptionInit(); // Only needed for Microblaze + PPC?

	int_ctrl_cfg_p = XScuGic_LookupConfig(SCUGIC_DEVICE_ID);
	status = XScuGic_CfgInitialize(&g_int_ctrl, int_ctrl_cfg_p, int_ctrl_cfg_p->CpuBaseAddress);
	if (status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	// Connect interrupt controller hardware driver
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_IRQ_INT, (Xil_ExceptionHandler) XScuGic_InterruptHandler, &g_int_ctrl);

	return XST_SUCCESS;
}


void enable_interrupts(void) {
	Xil_ExceptionEnable();
}


void cleanup_interrupts(void) {
	Xil_ExceptionDisable();
}


int create_interrupt(XScuGic *instance_p, u32 int_id, u8 priority, u8 trigger, Xil_InterruptHandler isr, void *callback_ref) {
    int status;

    // Connect interrupt controller hardware driver
    status = XScuGic_Connect(instance_p, int_id, isr, callback_ref);
    if (status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    XScuGic_SetPriorityTriggerType(instance_p, int_id, priority, trigger);

    XScuGic_Enable(instance_p, int_id);

    return XST_SUCCESS;
}


void destroy_interrupt(XScuGic *instance_p, u32 int_id) {
	XScuGic_Disconnect(instance_p, int_id);
	XScuGic_Disable(instance_p, int_id);	// Disable for good measure
}
