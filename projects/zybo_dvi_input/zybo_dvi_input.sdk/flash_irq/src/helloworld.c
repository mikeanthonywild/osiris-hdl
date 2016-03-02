#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xscutimer.h"

#define TIMER_INIT_CNT 66666667

// Interrupt controller
static XScuGic int_ctl;
static XScuGic_Config *int_ctl_cfg;

// SCU timer (internal)
static XScuTimer prv_timer;	// Private timer instance
static XScuTimer_Config *prv_timer_cfg;

// Interrupt synchronisation
static volatile int ISR_toggle = 0, ISR_count = 0;

// Timer interrupt handler
static void TimerIntrHandler(void *callback_ref) {
	XScuTimer *timer = (XScuTimer *) callback_ref;

	XScuTimer_ClearInterruptStatus(timer);
	XScuTimer_Stop(timer);
	ISR_count++;
	xil_printf("Flash triggered!\n");
}

// Button interrupt handler
static void ButtonHandler(void *callback_ref) {
	XScuTimer *timer = (XScuTimer *) callback_ref;

	xil_printf("Exposure about to start...\n");
	XScuTimer_RestartTimer(timer);
	XScuTimer_Start(timer);
}

int main()
{
	int status;

    init_platform();

    Xil_ExceptionInit(); // Only needed for Microblaze + PPC?

    // Init GIC
    int_ctl_cfg = XScuGic_LookupConfig(XPAR_SCUGIC_0_DEVICE_ID);
    status = XScuGic_CfgInitialize(&int_ctl, int_ctl_cfg, int_ctl_cfg->CpuBaseAddress);
    if (status != XST_SUCCESS) {
    	xil_printf("SCUGIC init failed");
    	return status;
    }

    // Connect interrupt controller hardware driver
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_IRQ_INT, (Xil_ExceptionHandler) XScuGic_InterruptHandler, &int_ctl);
    XScuGic_Connect(&int_ctl, XPAR_SCUTIMER_INTR, (Xil_ExceptionHandler) TimerIntrHandler, (void *) &prv_timer);
    XScuGic_Enable(&int_ctl, XPAR_SCUTIMER_INTR);
    XScuGic_Connect(&int_ctl, 61, (Xil_ExceptionHandler) ButtonHandler, (void *) &prv_timer);
    XScuGic_SetPriorityTriggerType(&int_ctl, 61, 0, 3);
    XScuGic_Enable(&int_ctl, 61);

    // Init and configure timer
    prv_timer_cfg = XScuTimer_LookupConfig(XPAR_XSCUTIMER_0_DEVICE_ID);
    XScuTimer_CfgInitialize(&prv_timer, prv_timer_cfg, prv_timer_cfg->BaseAddr);
    //XScuTimer_EnableAutoReload(&prv_timer);
    XScuTimer_LoadTimer(&prv_timer, TIMER_INIT_CNT);
    XScuTimer_EnableInterrupt(&prv_timer);
    //XScuTimer_Start(&prv_timer);

    Xil_ExceptionEnable();

    xil_printf("Hello World\n\r");

    while(1) {
    	;
    }

    cleanup_platform();
    return 0;
}
