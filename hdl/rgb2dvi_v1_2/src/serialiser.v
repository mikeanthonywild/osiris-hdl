/*
 * serialiser.v
 *
 * Author: Mike Wild <m.a.wild@se12.qmul.ac.uk>
 * Date: 9th April 2015
 *
 * This module instantiates a Zynq-7000 OSERDESE2 block for
 * serialising the 10-bit parallel output from the TMDS encoder ready
 * to clock it out onto the wire.
 *
 * Based on VHDL code written by Elod Gyorgy and Mihaita Nagy.
 */

module OutputSERDES(
   input PixelClk,      // TMDS clock x1 (CLKDIV)
   input SerialClk,     // TMDS clock x5 (CLK)

   // Encoded serial data
   // Does this need to be registered? They're buffer outputs so
   // probably not...
   output sDataOut_p,
   output sDataOut_n,

   // Encoded parallel data
   input [kParallelWidth-1:0] pDataOut,

   input aRst
);

   // Parameters
   parameter integer kParallelWidth    // Number of parallel bits

   // Wires
   wire        sDataOut, ocascade1, ocascade2;
   wire [13:0] pDataOut_q;

   // Differential output buffer for TMDS IO standard
   OBUFDS #(
      .IOSTANDARD("TMDS_33")
   ) OutputBuffer (
      .O(sDataOut_p),
      .OB(sDataOut_n),
      .I(sDataOut)
   );

   // 10:1 Serialiser (5:1 DDR), master-slave cascade
   // (what does this mean?)
   OSERDESE2 #(
      .DATA_RATE_OQ("DDR"),
      .DATA_RATE_TQ("SDR"),
      .DATA_WIDTH(kParallelWidth),
      .TRISTATE_WIDTH(1),
      .TBYTE_CTL(0),
      .TBYTE_SRC(0),
      .SERDES_MODE("MASTER")
   ) SerializerMaster(
      .OQ(sDataOut),          // Data path output
      .CLK(SerialClk),        // High speed clock
      .CLKDIV(PixelClk),      // Divided clock
      // Parallel data inputs
      .D1(pDataOut_q[13]),
      .D2(pDataOut_q[12]),
      .D3(pDataOut_q[11]),
      .D4(pDataOut_q[10]),
      .D5(pDataOut_q[9]),
      .D6(pDataOut_q[8]),
      .D7(pDataOut_q[7]),
      .D8(pDataOut_q[6]),
      .OCE(1),                // Output data clock enable
      .RST(aRst),             // Reset
      // Data intput expansion
      .SHIFTIN1(ocascade1),
      .SHIFTIN2(ocascade2),
      // Parallel 3-state inputs
      .T1(0),
      .T2(0),
      .T3(0),
      .T4(0),
      .TBYTEIN(0)             // Byte group tristate
      .TCE(0)                 // 3-state clock enable
   );

   OSERDESE2 #(
      .DATA_RATE_OQ("DDR"),
      .DATA_RATE_TQ("SDR"),
      .DATA_WIDTH(kParallelWidth),
      .TRISTATE_WIDTH(1),
      .TBYTE_CTL(0),
      .TBYTE_SRC(0),
      .SERDES_MODE("SLAVE")
   ) SerializerSlave(
      .OQ(sDataOut),          // Data path output
      // Data output expansion
      .SHIFTOUT1(ocascade1),
      .SHIFTOUT2(ocascade2),
      .CLK(SerialClk),        // High speed clock
      .CLKDIV(PixelClk),      // Divided clock
      // Parallel data inputs
      .D1(0),
      .D2(0),
      .D3(pDataOut_q[5]),
      .D4(pDataOut_q[4]),
      .D5(pDataOut_q[3]),
      .D6(pDataOut_q[2]),
      .D7(pDataOut_q[1]),
      .D8(pDataOut_q[0]),
      .OCE(1),                // Output data clock enable
      .RST(aRst),             // Reset
      // Data intput expansion
      .SHIFTIN1(0),
      .SHIFTIN2(0),
      // Parallel 3-state inputs
      .T1(0),
      .T2(0),
      .T3(0),
      .T4(0),
      .TBYTEIN(0)             // Byte group tristate
      .TCE(0)                 // 3-state clock enable
   );

   /* 
    * Concatenate the serdes inputs together. Keep the timesliced
    * bits together, and placing the earliest bits on the right
    * ie, if data comes in 0, 1, 2, 3, 4, 5, 6, 7, ...
    * the output will be 3210, 7654, ...
    */
   genvar slice_count;
   generate
      for(slice_count=0; slice_count<kParallelWidth-1; slice_count=slice_count+1) begin: SliceOSERDES_q
         // DVI sends least significant bit first 
         // OSERDESE2 sends D1 bit first
         assign pDataOut_q[14-slice_count-1] = pDataOut[slice_count];
      end   
   endgenerate

endmodule
