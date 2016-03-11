"""A small script to calculate PLL parameters for target clocks.

"""

CLK_IN1 = [25.175, 148.5]
TARGET = 5
TOLERANCE = 1   # +/- 1 Hz

DIVCLK_DIVIDE = xrange(1, 107)
CLKFBOUT_MULT = xrange(2, 65)
CLKOUT0_DIV = xrange(1, 129)
FVCOMIN = 600
FVCOMAX = 1200

print("{:<13} {:<13} {:<11}".format('DIVCLK_DIVIDE', 'CLKFBOUT_MULT', 'CLKOUT0_DIV'))

for divclk in DIVCLK_DIVIDE:
    for mult in CLKFBOUT_MULT:
        for div in CLKOUT0_DIV:
            for clk_in in CLK_IN1:
                fvco = clk_in * mult / divclk
                fout = fvco / div
                if fvco < FVCOMIN or fvco > FVCOMAX \
                  or fout < clk_in * TARGET - TOLERANCE or fout > clk_in * TARGET + TOLERANCE:
                    solution_found = False
                    break

                solution_found = True
            
            if solution_found: 
                print("{:<13} {:<13} {:<11}".format(divclk, mult, div))