/*
 * interrupt.h
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 24th March 2016
 *
 * Helper functions for creating interrupts
 *
 */

#ifndef INTERRUPT_H
#define INTERRUPT_H

/***************************** Include Files *********************************/


/************************** Constant Definitions *****************************/
TRIGGER_TYPE_LEVEL_ACTIVE_LOW   = 0
TRIGGER_TYPE_LEVEL_ACTIVE_HIGH  = 1
TRIGGER_TYPE_EDGE_FALLING       = 2
TRIGGER_TYPE_EDGE_RISING        = 3

/**************************** Type Definitions *******************************/


/**************************** Global variables *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/
s32 create_interrupt(XScuGic *, u32, u8, u8, Xil_InterruptHandler, void *);

#endif // INTERRUPT_H