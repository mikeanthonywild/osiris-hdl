/* 
 * ov7670_capture.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 14th October 2015
 *
 * Module to capture pixel data from OV7670 image sensor.
 */

module ov7670_capture (
    input           pclk, // Pixel clock
    input           vsync, //Vertical sync signal
    input           href, // Horizontal timing reference
    input [7:0]     d, // Pixel data
    input           reset // Synchronous reset
);

// FSM states
localparam IDLE                 = 3'd0;
localparam I2C_SETUP            = 3'd1;
localparam WAIT_FOR_FRAME_END   = 3'd2;
localparam WAIT_FOR_FRAME_START = 3'd3;
localparam WAIT_FOR_LINE_START  = 3'd4;
localparam FETCH_PIXEL          = 3'd5;

reg [2:0]   capture_state = IDLE;

reg         i2c_setup_complete = 1'b0;

always @(posedge pclk) begin
    if (!reset) begin
        capture_state = IDLE;
        i2c_setup_complete = 1'b0;
    end

    // Capture state machine
    case (capture_state)
        IDLE: begin
            capture_state <= I2C_SETUP;
        end

        // Configure sensor registers
        I2C_SETUP: begin
            if (i2c_setup_complete) begin
                capture_state <= WAIT_FOR_FRAME_END;
            end
        end

        WAIT_FOR_FRAME_END: begin
            if (vsync) begin
                capture_state <= WAIT_FOR_FRAME_START;
            end
        end

        WAIT_FOR_FRAME_START: begin
            if (!vsync) begin
                capture_state <= WAIT_FOR_LINE_START;
            end
        end

        WAIT_FOR_LINE_START: begin
            if (href) begin
                // TODO: Clock first pixel on transition!
                capture_state <= FETCH_PIXEL;
            else if (vsync) begin
                capture_state <= WAIT_FOR_FRAME_START;
            end
        end

        FETCH_PIXEL: begin
            if (!href) begin
                capture_state <= WAIT_FOR_LINE_START;
            end
        end
    end
end

endmodule