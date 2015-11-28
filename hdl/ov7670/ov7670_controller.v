/* 
 * ov7670_controller.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 23rd November 2015
 *
 * This module connects the OV7670 register initialisation routines and I2C
 * controller together and trigger them on startup. Once initialisation is
 * finished, it sets a done flag to indicate that capture may proceed.
 */

module ov7670_controller (
    input   clk,            // Core clock
    input   reset_n,        // Synchronous reset
    output  start_capture,  // Signal the capture module to start
    output  ov7670_reset,   // Camera IC reset registers (active high)
    output  ov7670_pwrdn,   // Camera IC power down mode (active low)
    output  sda,            // SCCB data
    output  scl             // SCCB clock
);

    wire        continue_init;
    wire        i2c_send;
    wire [15:0] data;
    wire [7:0]  camera_addr;    

    assign ov7670_pwrdn = 1;
    assign ov7670_reset = 0;
    assign i2c_send = ~start_capture;
    assign camera_addr = 'h42;          // Base address (0x21) with write bit

    ov7670_init ov7670_init (
        .clk(clk),
        .reset_n(reset_n),
        .continue(continue_init),
        .data(data),
        .done(start_capture)
    ); 

    i2c_sender i2c_sender (
        .siod(sda),
        .sioc(scl),
        .taken(continue_init),
        .send(i2c_send),
        .id(camera_addr),
        .reg(data[15:8]),
        .value(data[7:0])
    );

 endmodule