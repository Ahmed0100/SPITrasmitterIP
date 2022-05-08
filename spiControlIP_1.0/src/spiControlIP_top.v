`timescale 1ns / 1ps

module top(
input  clock, //clock (100 MHz)
input  reset_n,
input [7:0] spi_data_in,
input  spi_load_data,
output spi_done_send,
output spi_clock,//10MHz max
output spi_data_out
);

spiControlIP inst(
.clock(clock), //clock (100 MHz)
.reset_n(reset_n),
.spi_data_in(spi_data_in),
.spi_load_data(spi_load_data),
.spi_done_send(spi_done_send),
.spi_clock(spi_clock),//10MHz max
.spi_data_out(spi_data_out)
);
   
endmodule
