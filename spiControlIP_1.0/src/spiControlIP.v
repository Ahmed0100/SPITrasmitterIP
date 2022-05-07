`timescale 1ns / 1ps

module spiControlIP(
input  clock, //clock (100 MHz)
input  reset_n,
input [7:0] spi_data_in,
input  spi_load_data,
output reg spi_done_send,
output     spi_clock,//10MHz max
output reg spi_data_out
);

reg [2:0] data_count;
reg [7:0] shift_reg=0;
reg [1:0] state;
reg [2:0] counter=0;

reg clock_10;
reg CE;

assign spi_clock = (CE == 1) ? clock_10 : 1'b1;

always @(posedge clock)
begin
    if(counter != 4)
        counter <= counter + 1;
    else
        counter <= 0;
end

initial
    clock_10 <= 0;

always @(posedge clock)
begin
    if(counter == 4)
        clock_10 <= ~clock_10;
end

localparam IDLE = 'd0,
           SEND = 'd1,
           DONE = 'd2;

always @(negedge clock_10)
begin
    if(!reset_n)
    begin
        state <= IDLE;
        data_count <= 0;
        spi_done_send <= 1'b0;
        CE <= 0;
        spi_data_out <= 1'b1;
    end
    else
    begin
        case(state)
            IDLE:begin
                if(spi_load_data)
                begin
                    shift_reg <= spi_data_in;
                    state <= SEND;
                    data_count <= 0;
                end
            end
            SEND:begin
                spi_data_out <= shift_reg[7];
                shift_reg <= {shift_reg[6:0],1'b0};
                CE <= 1;
                if(data_count != 7)
                    data_count <= data_count + 1;
                else
                begin
                    state <= DONE;
                end
            end
            DONE:begin
                CE <= 0;
                spi_done_send <= 1'b1;
                if(!spi_load_data)
                begin
                    spi_done_send <= 1'b0;
                    state <= IDLE;
                end
            end
        endcase
    end
end

   
endmodule