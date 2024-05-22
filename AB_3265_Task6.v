/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan, Sudhanshu Ranjan, Sumit Saroj
▪ * Filename: controller
▪ * Theme: Astro Tinker Bot 
▪ * Functions: controller
▪ * Global Variables: None
▪ */

// Top module for all the  modules
module  AB_3265_Task6(  clk_50M,reset_wire,Instr,rx,tx,echo_rx,pwml1,pwml2,pwmr1,pwmr2,reset,trigger_wire,dout,adc_cs_n,din,clk_3125KHz,
em1,em2,led1r,led1g,led1b,led2r,led2g,led2b,led3r,led3g,led3b,no1,no2,start);

input clk_50M;
input rx;
input echo_rx;
input  dout;
input reset;

output tx;
output pwml1;
output pwml2;
output pwmr1;
output pwmr2;
output trigger_wire;

output adc_cs_n,clk_3125KHz, din;
output em1,em2;

output led1r,led1g,led1b;
output led2r,led2g,led2b;
output led3r,led3g,led3b;


output [31:0] Instr;
output reset_wire;
output [3:0] no1;
output [3:0] no2;

input start;




wire [7:0] rx_msg,data;
wire rx_complete;
wire sensdata;
wire [11:0] l,c,r;
wire pwmleft2;
wire pwmright2;
wire [31:0] ex_addr,ex_data;



wire reset_wire;

wire [7:0] start_p;
wire [7:0] end_p;

wire [7:0] path0_w;
wire [7:0] path1_w;
wire [7:0] path2_w;
wire [7:0] path3_w;
wire [7:0] path4_w;
wire [7:0] path5_w;
wire [7:0] path6_w;
wire [7:0] path7_w;
wire [7:0] path8_w;
wire [7:0] path9_w;
wire [7:0] path10_w;
wire [7:0] path11_w;
wire [7:0] path12_w;
wire [7:0] index_w;

////////////////// UART///
wire [7:0] data0_w;
wire [7:0] data1_w;
wire [7:0] data2_w;
wire [7:0] data3_w;
wire [7:0] data4_w;
wire [7:0] data5_w;
wire [7:0] data6_w;
wire [7:0] data7_w;
wire [7:0] data8_w;
wire [7:0] data9_w;
wire [7:0] data10_w;
wire [7:0] data11_w;
wire [7:0] data12_w;
wire [7:0] data13_w;

wire [3:0] no1;
wire [3:0] no2;
wire [5:0] node_w;
wire [5:0] next_node_wire;
wire [5:0] state_w;
wire fault_w;
wire cpu_reset_w;
wire cpu_done_w ;
wire fault_collected_w;
wire pbm_recieved_w;
wire block_picked_w;

wire seach_EU_w2;
wire seach_CU_w2;
wire seach_RU_w2;
wire reach_B1_w;
wire reach_B2_w;
wire reach_B3_w;
wire reach_B4_w;

wire reach_ESU1_w;
wire reach_ESU2_w;
wire reach_ESU3_w;
wire reach_CSU1_w;
wire reach_CSU2_w;
wire reach_CSU3_w;
wire reach_RSU1_w;
wire reach_RSU2_w;
wire reach_RSU3_w;
wire reach_RSU4_w;

wire B1_supply_toggle_w;
wire B2_supply_toggle_w;
wire B3_supply_toggle_w;
wire B4_supply_toggle_w;

wire data_sent_w;
wire start_rcv_w;

wire data_avail_w;
wire start_bot_w;


assign sensdata = dout;


Frequency_Scaling fs( clk_50M, clk_3125KHz);

 ADC_Controller adc(sensdata,clk_3125KHz,clk_50M,adc_cs_n,din,l,c,r);


   Line_Follower lf(clk_50M,data0_w,data1_w,data2_w,data3_w,data4_w,data5_w,data6_w,data7_w,data8_w,data9_w,data10_w,data11_w,data12_w,
   data13_w,no1,no2,l,c,r,din,adc_cs_n,node_w,led1r,led1g,led2r,led2g,led3r,led3g,led1b,led2b,led3b,state_w,path0_w,
   path1_w,path2_w,path3_w,path4_w,path5_w,path6_w,path7_w,path8_w,path9_w,path10_w,path11_w,path12_w,index_w,reset,
   start_p,end_p,cpu_reset_w,cpu_done_w,fault_w,em1,em2,next_node_wire,
   seach_EU_w2,seach_CU_w2,seach_RU_w2,reach_B1_w,reach_B2_w,reach_B3_w,reach_B4_w,reach_ESU1_w,reach_ESU2_w,reach_ESU3_w,
   reach_CSU1_w,reach_CSU2_w,reach_CSU3_w,reach_RSU1_w,reach_RSU2_w,reach_RSU3_w,reach_RSU4_w,B1_supply_toggle_w,B2_supply_toggle_w,
   B3_supply_toggle_w,B4_supply_toggle_w,ESU1_fixed_w,ESU2_fixed_w,ESU3_fixed_w,CSU1_fixed_w,CSU2_fixed_w,CSU3_fixed_w,RSU1_fixed_w,
   RSU2_fixed_w,RSU3_fixed_w,RSU4_fixed_w,ESU1_found_w,ESU2_found_w,ESU3_found_w,CSU1_found_w,CSU2_found_w,CSU3_found_w,RSU1_found_w,
   RSU2_found_w,RSU3_found_w,RSU4_found_w,start_bot_w);


 pwm_generator pm1(clk_3125KHz,no1,no1,clk_195KHz,pwmleft2,pwml1,pwml2);
 pwm_generator pm2(clk_3125KHz,no2,no2,clk_195KHz,pwmright2,pwmr1,pwmr2);

 uart_rx uart_LF_rx(clk_50M,rx,rx_msg,data0_w,data1_w,data2_w,data3_w,data4_w,data5_w,data6_w,data7_w,data8_w,data9_w,data10_w,
 data11_w,data12_w,data13_w,data_avail_w,start_bot_w);
 uart_tx uart_LF_tx( clk_50M, data, tx,data_sent_w,start_rcv_w);

 t1c_pulse_gen_detect ultra(clk_50M,reset,echo_rx,fault_w,trigger,echo_duration);

 Identify_fault FI(clk_50M,fault_w,node_w,data,path0_w,fault_collected_w,pbm_recieved_w,block_picked_w,next_node_wire,data0_w,data1_w,
 data2_w,data3_w,data4_w,data5_w,data6_w,data7_w,data8_w,data9_w,data10_w,data11_w,data12_w,data13_w,state_w,seach_EU_w2,seach_CU_w2,
 seach_RU_w2,reach_B1_w,reach_B2_w,reach_B3_w,reach_B4_w,reach_ESU1_w,reach_ESU2_w,reach_ESU3_w,reach_CSU1_w,reach_CSU2_w,reach_CSU3_w,
 reach_RSU1_w,reach_RSU2_w,reach_RSU3_w,reach_RSU4_w,B1_supply_toggle_w,B2_supply_toggle_w,B3_supply_toggle_w,B4_supply_toggle_w,data_sent_w,
 start_rcv_w,ESU1_fixed_w,ESU2_fixed_w,ESU3_fixed_w,CSU1_fixed_w,CSU2_fixed_w,CSU3_fixed_w,RSU1_fixed_w,RSU2_fixed_w,RSU3_fixed_w,
 RSU4_fixed_w,ESU1_found_w,ESU2_found_w,ESU3_found_w,CSU1_found_w,CSU2_found_w,CSU3_found_w,RSU1_found_w,RSU2_found_w,RSU3_found_w,
 RSU4_found_w);

write_points wr_p(clk_3125KHz, start_p, end_p, reset_wire, ex_data, ex_addr, Ext_MemWrite,  point_sp, point_ep,WriteData, DataAdr,
 states, cpu_reset_w);

t2b_riscv_cpu cpu (clk_3125KHz,reset_wire, Ext_MemWrite, ex_data, ex_addr, MemWrite, WriteData, DataAdr, ReadData, Instr, WriteData_rv32,
rdata2,write,PC,DataAdr_rv32,path0_w,path1_w,path2_w,path3_w,path4_w,path5_w,path6_w,path7_w,path8_w,path9_w,path10_w,path11_w,path12_w,
index_w, cpu_done_w,cpu_reset_w);

assign trigger_wire = trigger;


endmodule