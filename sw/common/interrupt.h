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
#include "xil_types.h"
#include "xscugic.h"

/************************** Constant Definitions *****************************/
#define TRIGGER_TYPE_LEVEL_ACTIVE_LOW   0
#define TRIGGER_TYPE_LEVEL_ACTIVE_HIGH  1
#define TRIGGER_TYPE_EDGE_FALLING       2
#define TRIGGER_TYPE_EDGE_RISING        3

/**************************** Type Definitions *******************************/


/**************************** Global variables *******************************/
extern XScuGic g_int_ctrl;

/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/
int init_interrupts(void);
void enable_interrupts(void);
void cleanup_interrupts(void);
int create_interrupt(XScuGic *, u32, u8, u8, Xil_InterruptHandler, void *);
void destroy_interrupt(XScuGic *, u32);

#endif // INTERRUPT_H
