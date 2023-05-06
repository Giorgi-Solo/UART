

module baseline_c5gx(

     
      ///////// CLOCK /////////
      input              CLOCK_125_p, ///LVDS
      input              CLOCK_50_B5B, ///3.3-V LVTTL
      input              CLOCK_50_B6A,
      input              CLOCK_50_B7A, ///2.5 V
      input              CLOCK_50_B8A,

    
      inout       [35:0] GPIO,


      ///////// KEY ///////// 1.2 V ///////
      input       [2:0]  KEY,

     
      ///////// LEDR ///////// 2.5 V ///////
      output      [9:0]  LEDR,

 
      ///////// SW ///////// 1.2 V ///////
      input       [7:0]  SW);

UART #(.counter_ceil_tr(2604),.counter_ceil_rec(2604))uut (
		.CLOCK_125_p(CLOCK_50_B5B), 
		.KEY(KEY), 
		.SW(SW), 
		.Rx(GPIO[1]), 
		.Tx(GPIO[0]), 
		.LEDR(LEDR[7:0]), 
		.check_parity(LEDR[8])
	);

endmodule
