/*
 * ov7670_init.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 21st November 2015
 *
 * Before we can capture a frame, we need to configure the OV7670's internal
 * registers via SCCB (I2C clone). A lot of the registers we can leave the
 * default values.
 */

module ov7670_init (
    input               clk,        // Core clock
    input               reset_n,    // Synchronous reset
    input               continue,   // Continue with register intialisation
    output reg [15:0]   data,       // Register address and value for SCCB
    output              done        // Register initialisation finished
);

    reg [3:0] step;

    assign done = data == 'hffff;

    always @(posedge clk) begin
        if (!reset_n) begin
            // Reset everything
            step <= 0;
            data <= 'h0000;
        end else begin
            if (continue && !done) begin
                step <= step + 1;
            end

            // Data = {REG_ADDR, REG_VALUE}
            // Register init sequence   // REG              DESCRIPTION
            case (step)
                0   : data <= 'h1280;   // COM7             Reset
                1   : data <= 'h1280;   // COM7             Delay after reset

                // Register settings from Implementation Guide table 2-2.
                // ALL OF THIS IS CONTRADICTED. Implementation guide 3.2.1:
                // FINT = F * PLL / (2 * CLKRC + 1)
                // DATASHEET:
                // FINT = F / (CLKRC + 1)
                2   : data <= 'h1101;   // CLKRC            Prescaler x4 (2 * (CLKRC + 1))
                3   : data <= 'h6b7a;   // DBLV             PLL x4
                4   : data <= 'h1201;   // COM7             VGA RAW Bayer output
                5   : data <= 'h0c00;   // COM3             Disable scaling and DCW
                6   : data <= 'h3e00;   // COM14            No DCW or PCLK scaling
                // TODO: WHAT ARE ALL OF THESE FOR? Linux driver refers to them
                // as magic scaling registers. No-one even knows! Read implementation
                // guide part 6.2.
                7   : data <= 'h703a;   // SCALING_XSC      Horizontal scaling - default
                8   : data <= 'h7135;   // SCALING_YSC      Vertical scaling - default
                9   : data <= 'h7211;   // SCALING_DCWCTR   H+V downsample by 2 - default
                10  : data <= 'h73f0;   // SCALING_PCLK_DIV No scaling
                11  : data <= 'ha202;   // SCALING_PCLK_DELAY Scaling output delay 2 - default

                default: data <= 'hffff;
            endcase
        end
    end

endmodule
