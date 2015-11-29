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
                // TODO: WHY ARE WE DIVIDING INPUT CLOCK BY TWO???!!!
                // ALL OF THIS IS CONTRADICTED. Implementation guide 3.2.1:
                // FINT = F * PLL / (2 * CLKRC + 1)
                // DATASHEET:
                // FINT = F / (CLKRC + 1)
                2   : data <= 'h1101;   // CLKRC            Prescaler f = XCLK / (1 + 1)
                3   : data <= 'h1201;   // COM7             VGA Bayer RAW output
                4   : data <= 'h0c00;   // COM3             No scaling or DCW - this is default
                5   : data <= 'h3e00;   // COM14            No PCLK divider - also default
                // TODO: WHAT ARE ALL OF THESE FOR? Linux driver refers to them
                // as magic scaling registers. No-one even knows! Read implementation
                // guide part 6.2.
                6   : data <= 'h703a;   // SCALING_XSC      Horizontal scaling - default
                7   : data <= 'h7135;   // SCALING_YSC      Vertical scaling - default
                8   : data <= 'h7211;   // SCALING_DCWCTR   H+V downsample by 2 - default
                9   : data <= 'h73f0;   // SCALING_PCLK_DIV PCLK preserved? Uses reserved bits
                10  : data <= 'ha202;   // SCALING_PCLK_DELAY Scaling output delay 2 - default

                default: data <= 'hffff;

                /*
                 * THESE ARE FOR A MORE SPECIALISED SYSTEM. UNTIL WE UNDERSTAND
                 * HOW IT WORKS, IT'S BEST NOT TO USE THESE SETTINGS.
                // Are reset registers even required in addition to reset pin?
                0   : data <= 'h1280;   // COM7     Reset
                1   : data <= 'h1280;   // Delay after reset
                2   : data <= 'h1100;   // CLKRC    Prescaler - Fin/(1+1)
                3   : data <= 'h1204;   // COM7     QCIF + RGB output
                4   : data <= 'h0c04;   // COM3     Lots of stuff, enable scaling, all others off
                5   : data <= 'h3e19;   // COM14    PCLK scaling = 0

                6   : data <= 'h4010;   // COM15    Full 0-255 output, RGB 565
                7   : data <= 'h3a04;   // TSLB     Set UV ordering, do not auto-reset window
                8   : data <= 'h8c00;   // RGB444   Set RGB format

                9   : data <= 'h1714;   // HSTART   HREF start (high 8 bits)
                10  : data <= 'h1802;   // HSTOP    HREF stop (high 8 bits)
                11  : data <= 'h32a4;   // HREF     Edge offset and low 3 bits of HSTART and HSTOP
                12  : data <= 'h1903;   // VSTART   VSYNC start (high 8 bits)
                13  : data <= 'h1a7b;   // VSTOP    VSYNC stop (high 8 bits)
                14  : data <= 'h030a;   // VREF     VSYNC low two bits 

                15  : data <= 'h703a;   // SCALING_XSC
                16  : data <= 'h7135;   // SCALING_YSC
                17  : data <= 'h7211;   // SCALING_DCWCTR
                18  : data <= 'h73f1;   // SCALING_PCLK_DIV
                19  : data <= 'ha202;   // SCALING_PCLK_DELAY PCLK scaling = 4, must match COM14

                20  : data <= 'h1500;   // COM10    Use HREF not HSYNC
                21  : data <= 'h7a20;   // SLOP
                22  : data <= 'h7b10;   // GAM1
                23  : data <= 'h7c1e;   // GAM2
                24  : data <= 'h7d35;   // GAM3
                25  : data <= 'h7e5a;   // GAM4
                26  : data <= 'h7f69;   // GAM5
                27  : data <= 'h8076;   // GAM6
                28  : data <= 'h8180;   // GAM7
                29  : data <= 'h8288;   // GAM8
                30  : data <= 'h838f;   // GAM9
                31  : data <= 'h8496;   // GAM10
                32  : data <= 'h85a3;   // GAM11
                33  : data <= 'h86af;   // GAM12
                34  : data <= 'h87c4;   // GAM13
                35  : data <= 'h88d7;   // GAM14
                36  : data <= 'h89e8;   // GAM15
                37  : data <= 'h13e0;   // COM8     AGC, White balance
                38  : data <= 'h0000;   // GAIN     AGC
                39  : data <= 'h1000;   // AECH     Exposure
                40  : data <= 'h0d40;   // COM4     Window size
                41  : data <= 'h1418;   // COM9     AGC
                42  : data <= 'ha505;   // AECGMAX  Banding filter step
                43  : data <= 'h2495;   // AEW      AGC Stable upper limit
                44  : data <= 'h2533;   // AEB      AGC Stable lower limit
                45  : data <= 'h26e3;   // VPT      AGC Fast mode limits
                46  : data <= 'h9f78;   // HRL      High reference level
                47  : data <= 'ha068;   // LRL      Low reference level
                48  : data <= 'ha103;   // DSPC3    DSP control
                49  : data <= 'ha6d8;   // LPH      Lower prob high
                50  : data <= 'ha7d8;   // UPL      Upper prob low
                51  : data <= 'ha8f0;   // TPL      Total prob low
                52  : data <= 'ha990;   // TPH      Total prob high
                53  : data <= 'haa94;   // NALG     AEC algo select
                54  : data <= 'h13e5;   // COM8     AGC settings
                */
            endcase
        end
    end

endmodule