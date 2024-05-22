
/*
# Team ID:          eYRC#AB#3265
# Theme:            AstroTinker Bot (AB).
# Author List:      Sudhanshu Ranjan
# Filename:         Line follower 
# File Description: This is the main file which controls he bot trasversal in the arena.
# Global variables: None
*/


module Line_Follower(clk_50M,data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,
no1,no2,l,c,r,din,adc_cs_n,node,led1r,led1g,led2r,led2g,led3r,led3g,led1b,led2b,led3b,state,path0,path1,path2,path3,path4,
path5,path6,path7,path8,path9,path10,path11,path12,index,reset,SP,EP,cpu_reset,cpu_done,fault,em1_w,em2_w,next_node_w,seach_EU_w,seach_CU_w,
seach_RU_w,reach_B1_w,reach_B2_w,reach_B3_w,reach_B4_w,reach_ESU1_w,reach_ESU2_w,reach_ESU3_w,reach_CSU1_w,reach_CSU2_w,reach_CSU3_w,
reach_RSU1_w,reach_RSU2_w,reach_RSU3_w,reach_RSU4_w,B1_supply_toggle_w,B2_supply_toggle_w,B3_supply_toggle_w,B4_supply_toggle_w,ESU1_fixed_w,ESU2_fixed_w,
ESU3_fixed_w,CSU1_fixed_w,CSU2_fixed_w,CSU3_fixed_w,RSU1_fixed_w,RSU2_fixed_w,RSU3_fixed_w,RSU4_fixed_w,ESU1_found_w,ESU2_found_w,ESU3_found_w,
CSU1_found_w,CSU2_found_w,CSU3_found_w,RSU1_found_w,RSU2_found_w,RSU3_found_w,RSU4_found_w,start_bot_w);


 
 input clk_50M;


output reg [3:0] no1,no2;
input [11:0] l,c,r;
input adc_cs_n,din;


input [7:0] data0;
input [7:0] data2;
input [7:0] data1;
input [7:0] data3;
input [7:0] data4;
input [7:0] data5;
input [7:0] data6;
input [7:0] data7;
input [7:0] data8;
input [7:0] data9;
input [7:0] data10;
input [7:0] data11;
input [7:0] data12;
input [7:0] data13;

output  [5:0] node;
output  [5:0] next_node_w;
output reg led1r,led1g;
output reg led2r,led2g;
output reg led3r,led3g;
output reg led1b,led2b,led3b;

output reg [6:0] state;

output seach_EU_w;
output seach_CU_w;
output seach_RU_w;
output reach_B1_w;
output reach_B2_w;
output reach_B3_w;
output reach_B4_w;

output reach_ESU1_w;
output reach_ESU2_w;
output reach_ESU3_w;
output reach_CSU1_w;
output reach_CSU2_w;
output reach_CSU3_w;
output reach_RSU1_w;
output reach_RSU2_w;
output reach_RSU3_w;
output reach_RSU4_w;


output B1_supply_toggle_w;
output B2_supply_toggle_w;
output B3_supply_toggle_w;
output B4_supply_toggle_w;

     input [7:0] path0;
    input [7:0] path1; 
    input [7:0] path2;
    input [7:0] path3;
    input [7:0] path4;
    input [7:0] path5;
    input [7:0] path6;
    input [7:0] path7;
    input [7:0] path8;
    input [7:0] path9;
    input [7:0] path10;
    input [7:0] path11;
    input [7:0] path12;
    input [7:0] index;
    input reset;

     output reg [7:0] SP;
    output reg [7:0] EP;
    output reg cpu_reset;
    input cpu_done;
    
    input fault;


    output ESU1_fixed_w;
    output ESU2_fixed_w;
    output ESU3_fixed_w;

    output CSU1_fixed_w;
    output CSU2_fixed_w;
    output CSU3_fixed_w;

    output RSU1_fixed_w;
    output RSU2_fixed_w;
    output RSU3_fixed_w;
    output RSU4_fixed_w;

    output ESU1_found_w;
    output ESU2_found_w;
    output ESU3_found_w;

    output CSU1_found_w;
    output CSU2_found_w;
    output CSU3_found_w;

    output RSU1_found_w;
    output RSU2_found_w;
    output RSU3_found_w;
    output RSU4_found_w;

    output em1_w;
    output em2_w;

    input start_bot_w;



 reg [11:0] l_data ;
reg [11:0] c_data ;
 reg [11:0] r_data ;

 






localparam WAIT_FOR_MESSAGE = 49;
localparam SEARCH_SUB_UNIT = 1;
localparam REACH_TO_SUPPLY_UNIT = 2;
localparam deposit_the_block = 3;

localparam SEARCH_THE_EU = 4;
localparam SEARCH_THE_CU = 5;
localparam SEARCH_THE_RU = 6;

localparam CPU_PATH_CALCULATION = 7;
localparam DIRECTION_TO_TURN_ARRAY_MAKER = 8;
localparam DIRECTION_TO_MOVE = 9;

localparam DECISION = 10;
localparam FOLLOWER = 11;
localparam SPECIAL_FOLLOWER = 12;
localparam little_forward = 13;
localparam follower_search_line = 14;
localparam reverse = 15;
localparam stop = 16;
localparam check_line = 17;
localparam testing = 18;

localparam adjusted_shortest_path = 19;


localparam WHITE_LINE_FOUND_LEFT_TURN = 20;
localparam BLACK_LINE_FOUND_LEFT_TURN_PART_ONE = 21;
localparam black_line_found_left_turn_part_two = 22;
localparam white_line_found_right_turn = 23;
localparam black_line_found_right_turn_part_one = 24;
localparam black_line_found_right_turn_part_two = 25;
localparam forward_0 = 26;
localparam double_left_white_part_one = 27;
localparam double_left_white_part_two = 28;
localparam double_left_white_part_three = 29;
localparam double_right_white_part_one = 30;
localparam double_right_white_part_two = 31;
localparam double_right_white_part_three = 32;
localparam turn_around = 33;

localparam fault_found_pickup_block = 34;
localparam turn_little_right_for_picking_block = 35;
localparam stop_little_time_for_picking_block = 36;
localparam turn_little_left_after_picking_block = 37;
localparam fault_found_deposit_it = 38;
localparam little_stop_for_depositing_block = 39;
localparam add_last_node_at_back = 40;
localparam little_right_for_depositing_block = 41;
localparam store_in_fault_toggle = 42;
localparam for_led = 43;
localparam GO_STRAIGHT_SPECIAL_CASE_RIGHT_ONE = 44;
localparam GO_STRAIGHT_SPECIAL_CASE_LEFT_ONE = 45;
localparam GO_STRAIGHT_SPECIAL_CASE_LEFT_TWO = 46;
localparam GO_STRAIGHT_SPECIAL_CASE_RIGHT_TWO = 47;
localparam LITTLE_FORWARD_FOR_DEPOSIT_BLOCK = 48;
localparam WAITING_TILL_ONE_MESSAGE_IS_RECIEVED_TIMER_STARTS = 0;
localparam WAITING_FOR_ALL_MESSAGE_OR_30_SEC = 50;
localparam MOVE_REVERSE = 51;
localparam LITTLE_FORWARD_FOR_STOPPING = 52;
localparam TURN_RIGHT_UNTIL_WE_GET_WHITE = 53;
localparam LITTLE_MORE_RIGHT = 54;
localparam TURN_LEFT_UNTIL_WE_GET_WHITE = 55;
localparam LITTLE_MORE_LEFT = 56;
localparam EXITING_PICKING_UP_BLOCK = 57;
localparam STOP_FOR_SOME_TIME = 58;
localparam STOP_FOR_SOME_TIME_AFTER_TURNING = 59;
localparam white_line_found_right_turn_part_1 = 60;
localparam white_line_found_left_turn_part_1 = 61;
localparam LITTLE_RIGHT_Part1 = 62;
localparam LITTLE_STOP_AFTER_DETECTING_NODE = 63;
localparam STOP_LITTLE_MORE = 64;





reg [2:0] EU_fault_toggle=0;
reg [2:0] CU_fault_toggle=0;
reg [2:0] RU_fault_toggle=1;

reg return_to_deposit_the_block_in_ESU1=0;
reg return_to_deposit_the_block_in_ESU2_part_1=0;
reg return_to_deposit_the_block_in_ESU2_part_2=0;
reg return_to_deposit_the_block_in_ESU3_part_1=0;
reg return_to_deposit_the_block_in_ESU3_part_2=0;
reg return_to_deposit_the_block_in_CSU1=0;
reg return_to_deposit_the_block_in_CSU1_part_1=0;
reg return_to_deposit_the_block_in_CSU2=0;
reg return_to_deposit_the_block_in_CSU3=0;
reg return_to_deposit_the_block_in_RSU1=0;
reg return_to_deposit_the_block_in_RSU2=0;
reg return_to_deposit_the_block_in_RSU3=0;
reg return_to_deposit_the_block_in_RSU4=0;

reg ESU1_fault_toggle=0;
reg ESU2_fault_toggle=0;
reg ESU3_fault_toggle=0;
reg CSU1_fault_toggle=0;
reg CSU1_fault_toggle_part_1=0;
reg CSU2_fault_toggle=0;
reg CSU3_fault_toggle=0;
reg RSU1_fault_toggle=0;
reg RSU2_fault_toggle=0;
reg RSU3_fault_toggle=0;
reg RSU4_fault_toggle=0;

reg search_EU_toggle=0;
reg search_CU_toggle=0;
reg search_RU_toggle=0;

reg B1_supply_toggle=0;
reg B2_supply_toggle=0;
reg B3_supply_toggle=0;
reg B4_supply_toggle=0;

reg B1_msg_toggle=0;
reg B2_msg_toggle=0;
reg B3_msg_toggle=0;
reg B4_msg_toggle=0;

reg EU_search_msg_toggle=0;
reg CU_search_msg_toggle=0;
reg RU_search_msg_toggle=0;

reg EU_path_1_toggle=0;
reg EU_path_2_toggle=0;
reg EU_path_3_toggle=0;
reg EU_path_4_toggle=0;

reg CU_path_1_toggle=0;
reg CU_path_2_toggle=0;
reg CU_path_3_toggle=0;
reg CU_path_4_toggle=0;

reg RU_path_1_toggle=0;
reg RU_path_2_toggle=0;
reg RU_path_3_toggle=0;
reg RU_path_4_toggle=0;
reg RU_path_5_toggle=0;

reg searching_ESU_feedback_toggle=0;
reg searching_CSU_feedback_toggle=0;
reg searching_RSU_feedback_toggle=0;

reg reaching_to_B1_feedback_toggle=0;
reg reaching_to_B2_feedback_toggle=0;
reg reaching_to_B3_feedback_toggle=0;
reg reaching_to_B4_feedback_toggle=0;

reg reaching_to_ESU1_feedback_toggle=0;
reg reaching_to_ESU2_feedback_toggle=0;
reg reaching_to_ESU3_feedback_toggle=0;

reg reaching_to_CSU1_feedback_toggle=0;
reg reaching_to_CSU2_feedback_toggle=0;
reg reaching_to_CSU3_feedback_toggle=0;

reg reaching_to_RSU1_feedback_toggle=0;
reg reaching_to_RSU2_feedback_toggle=0;
reg reaching_to_RSU3_feedback_toggle=0;
reg reaching_to_RSU4_feedback_toggle=0;

reg B1_mem_toggle=0;
reg B2_mem_toggle=0;
reg B3_mem_toggle=0;
reg B4_mem_toggle=0;


reg return_to_EU_path_2_toggle=0;
reg return_to_EU_path_3_toggle=0;
reg return_to_EU_path_4_toggle=0;
reg return_to_search_the_EU=0;


reg return_to_CU_path_2_toggle=0;
reg return_to_CU_path_3_toggle=0;
reg return_to_CU_path_4_toggle=0;
reg return_to_search_the_CU=0;

reg return_to_RU_path_2_toggle=0;
reg return_to_RU_path_3_toggle=0;
reg return_to_RU_path_4_toggle=0;
reg return_to_RU_path_5_toggle=0;
reg return_to_search_the_RU=0;

reg return_to_REACH_TO_SUPPLY_UNIT=0;

reg add_last_node_in_path_of_ESU1=0;
reg add_last_node_in_path_of_ESU2=0;
reg add_last_node_in_path_of_ESU3=0;

reg add_last_node_in_path_of_CSU1=0;
reg add_last_node_in_path_of_CSU2=0;
reg add_last_node_in_path_of_CSU3=0;
reg add_last_node_in_path_of_CSU3_2=0;

reg add_last_node_in_path_of_RSU1=0;
reg add_last_node_in_path_of_RSU2=0;
reg add_last_node_in_path_of_RSU3=0;


reg return_to_reach_the_supply_unit_toggle=0;
reg return_to_deposit_the_block_toggle=0;

reg return_to_testing=0;
reg return_to_reach_to_fault=0;
reg deposit_done=0;
reg pick_done=0;

reg return_to_ESU1_fault_toggle_2=0;
reg return_to_ESU2_fault_toggle_2=0;
reg return_to_ESU2_fault_toggle_3=0;
reg return_to_ESU3_fault_toggle_2=0;
reg return_to_ESU3_fault_toggle_3=0;
reg return_to_CSU3_fault_toggle_2=0;
reg return_to_CSU3_fault_toggle_3=0;
reg return_to_RSU1_fault_toggle_2=0;
reg return_to_RSU3_fault_toggle_2=0;

reg ESU1_fixed=0;
reg ESU2_fixed=0;
reg ESU3_fixed=0;

reg CSU1_fixed=0;
reg CSU2_fixed=0;
reg CSU3_fixed=0;

reg RSU1_fixed=0;
reg RSU2_fixed=0;
reg RSU3_fixed=0;
reg RSU4_fixed=0;

reg ESU1_found=0;
reg ESU2_found=0;
reg ESU3_found=0;

reg CSU1_found=0;
reg CSU2_found=0;
reg CSU3_found=0;

reg RSU1_found=0;
reg RSU2_found=0;
reg RSU3_found=0;
reg RSU4_found=0;

reg skip=0;
reg [31:0] counter4=0;

reg em1,em2;


reg [4:0] shortest_path [29:0];
reg [4:0] size_of_path;
reg [4:0] array [0:2];
reg [4:0] i,j,k;
reg [4:0] direction_arr [29:0];
reg [4:0] dir;
reg [31:0] counter;
reg [31:0] counter2;
reg [31:0] counter3;
reg [4:0] Start;
reg [4:0] last;
reg [4:0] last_second_node;
reg [4:0] fault_in_EU;
reg node_found,found_white_line_after_node,found_black_line_after_node;
reg [5:0] current_node;
reg [5:0] next_node;
reg [5:0] previous_node=0;
reg [31:0] cpu_counter;
reg fault_collected;

reg skip_2=0;
reg skip_node_before_searching=0;
reg skip_4=0;
reg skip_5=0;
reg skip_led1_red=0;
reg skip_led2_red=0;
reg skip_led3_red=0;

reg skip_led3_blue_ESU_1_found=0;
reg skip_led3_blue_ESU_2_found=0;
reg skip_led3_blue_ESU_3_found=0;
reg skip_led3_blue_CSU_1_found=0;
reg skip_led3_blue_CSU_2_found=0;
reg skip_led3_blue_CSU_3_found=0;
reg skip_led3_blue_RSU_1_found=0;
reg skip_led3_blue_RSU_2_found=0;
reg skip_led3_blue_RSU_3_found=0;
reg skip_led3_blue_RSU_4_found=0;

reg skip_led3_green_ESU_1_deposit=0;
reg skip_led3_green_ESU_2_deposit=0;
reg skip_led3_green_ESU_3_deposit=0;
reg skip_led3_green_CSU_1_deposit=0;
reg skip_led3_green_CSU_2_deposit=0;
reg skip_led3_green_CSU_3_deposit=0;
reg skip_led3_green_RSU_1_deposit=0;
reg skip_led3_green_RSU_2_deposit=0;
reg skip_led3_green_RSU_3_deposit=0;
reg skip_led3_green_RSU_4_deposit=0;

reg [3:0] SPEED=8;

reg [3:0] msg_counter_eu=0;
reg [3:0] msg_counter_cu=0;
reg [3:0] msg_counter_ru=0;

reg msg_reset_eu=0;
reg msg_reset_cu=0;
reg msg_reset_ru=0;

reg [5:0] total_message=0;
reg  fault_found_go_to_deposit_block=0;




initial
begin



    em2<=0;   em1<=0;
    led1b<=0; led2b<=0;
    led1r<=0; led2r<=0;
    led1g<=0; led2g<=0;
    led3r<=0;
    led3g<=0; 
    led3b<=0;
    no1 = 0;  no2 = 0;  
    SP  = 0;  EP  = 0;
    
    cpu_reset = 1;
    counter2 =0;
    
  shortest_path[0]=0;
  shortest_path[1]=0;
  shortest_path[2]=0;
  shortest_path[3]=0;
  shortest_path[4]=0;
  shortest_path[5]=0;
  shortest_path[6]=0;
  shortest_path[7]=0;
  shortest_path[8]=0;
  shortest_path[9]=0;
  shortest_path[10]=0;
  shortest_path[11]=0;
  shortest_path[12]=0;
  shortest_path[13]=0;
  shortest_path[14]=0;
  shortest_path[15]=0;
  shortest_path[16]=0;
  shortest_path[17]=0;
  shortest_path[18]=0;
  shortest_path[19]=0;
  shortest_path[20]=0;
  shortest_path[21]=0;
  shortest_path[22]=0;
  shortest_path[23]=0;
  shortest_path[24]=0;
  shortest_path[25]=0;
  shortest_path[26]=0;
  shortest_path[27]=0;
  shortest_path[28]=0;
  shortest_path[29]=0;

    direction_arr[0] = 0;
    direction_arr[1] = 0;
    direction_arr[2] = 0;
    direction_arr[3] = 0;
    direction_arr[4] = 0;
    direction_arr[5] = 0;
    direction_arr[6] = 0;
    direction_arr[7] = 0;
    direction_arr[8] = 0;
    direction_arr[9] = 0;
    direction_arr[10] = 0;
    direction_arr[11] = 0;
    direction_arr[12] = 0;
    direction_arr[13] = 0;
    direction_arr[14] = 0;
    direction_arr[15] = 0;
    direction_arr[16] = 0;
    direction_arr[17] = 0;
    direction_arr[18] = 0;
    direction_arr[19] = 0;
    direction_arr[20] = 0;
    direction_arr[21] = 0;
    direction_arr[22] = 0;
    direction_arr[23] = 0;
    direction_arr[24] = 0;
    direction_arr[25] = 0;
    direction_arr[26] = 0;
    direction_arr[27] = 0;
    direction_arr[28] = 0;
    direction_arr[29] = 0;

    array[0]=0;
	array[1]=0;
	array[2]=0;

	node_found<=0;
	found_white_line_after_node<=0;
	found_black_line_after_node<=0;
	current_node<=0;
	next_node<=0;

	i<=0; j<=0; k<=0;
	size_of_path<=0;
	dir<=0;
	state<=WAITING_TILL_ONE_MESSAGE_IS_RECIEVED_TIMER_STARTS;
    counter<=0;

     fault_collected<=0;

    Start<=0;
    last<=0;
    cpu_counter<= 0;
    




end



always @(posedge clk_50M) begin

/*
Purpose:
This block manages all the path calculation, and makes the direction of every node to reach to next node. It also maanages the traversal of bot in the whole arena along with picking and droping the block at the correct path.

*/

l_data <= l;
c_data <= c;
r_data <= r;


if(data0=="P" & data1=="B" & data2=="M" & data3=="-" & data4=="S" & data5=="U"  & data6=="-" & data7=="B" & data8=="1" & data9=="-" & data10=="#" & B1_msg_toggle==0)
begin
B1_msg_toggle<=1;
B1_supply_toggle<=1;
end
else if(data0=="P" & data1=="B" & data2=="M" & data3=="-" & data4=="S" & data5=="U"  & data6=="-" & data7=="B" & data8=="2" & data9=="-" & data10=="#" & B2_msg_toggle==0)
begin
B2_msg_toggle<=1;
B2_supply_toggle<=1;
end
else if(data0=="P" & data1=="B" & data2=="M" & data3=="-" & data4=="S" & data5=="U"  & data6=="-" & data7=="B" & data8=="3" & data9=="-" & data10=="#" & B3_msg_toggle==0)
begin
B3_msg_toggle<=1;
B3_supply_toggle<=1;
end
else if(data0=="P" & data1=="B" & data2=="M" & data3=="-" & data4=="S" & data5=="U"  & data6=="-" & data7=="B" & data8=="4" & data9=="-" & data10=="#" & B4_msg_toggle==0)
begin
B4_msg_toggle<=1;
B4_supply_toggle<=1;
end

if(data0==0) begin
msg_reset_eu=1;
msg_reset_cu=1;
msg_reset_ru=1;
end


if(data0=="I" & data1=="F" & data2=="M" & data3=="-" & data4=="E" & data5=="U" & data6=="-" & data7=="#" & EU_search_msg_toggle==0)
begin
EU_search_msg_toggle<=1;

if(msg_counter_eu==0 ) begin
msg_counter_eu <= msg_counter_eu +1;
msg_reset_eu<=0;
EU_fault_toggle <= EU_fault_toggle +1;
end
else if(msg_counter_eu==1 && msg_reset_eu==1) begin
EU_fault_toggle <= EU_fault_toggle +1;
msg_reset_eu<=0;
end
else if(msg_counter_eu==2 && msg_reset_eu==1) begin
 EU_fault_toggle <= EU_fault_toggle +1;
end

if(skip_led1_red==0)
begin
led1b<=0;
led1g<=0;
led1r<=1;
skip_led1_red<=1;
end

end


if(data0=="I" & data1=="F" & data2=="M" & data3=="-" & data4=="C" & data5=="U" & data6=="-" & data7=="#" & CU_search_msg_toggle==0)
begin
CU_search_msg_toggle<=1;

if(msg_counter_cu==0 ) begin
msg_counter_cu <= msg_counter_cu +1;
msg_reset_cu<=0;
CU_fault_toggle <= CU_fault_toggle +1;
end
else if(msg_counter_cu==1 && msg_reset_cu==1) begin
CU_fault_toggle <= CU_fault_toggle +1;
msg_reset_cu<=0;
end
else if(msg_counter_cu==2 && msg_reset_cu==1) begin
 CU_fault_toggle <= CU_fault_toggle +1;
end


if(skip_led2_red==0)
begin
led2b<=0;
led2g<=0;
led2r<=1;
skip_led2_red<=1;
end
end

if(data0=="I" & data1=="F" & data2=="M" & data3=="-" & data4=="R" & data5=="U" & data6=="-" & data7=="#" & RU_search_msg_toggle==0)
begin
RU_search_msg_toggle<=1;

if(msg_counter_ru==0 ) begin
msg_counter_ru <= msg_counter_ru +1;
msg_reset_ru<=0;
RU_fault_toggle <= RU_fault_toggle +1;
end
else if(msg_counter_ru==1 && msg_reset_ru==1) begin
RU_fault_toggle <= RU_fault_toggle +1;
msg_reset_ru<=0;
end
else if(msg_counter_ru==2 && msg_reset_ru==1) begin
RU_fault_toggle <= RU_fault_toggle +1;
end


if(skip_led3_red==0)
begin
led3b<=0;
led3g<=0;
led3r<=1;
skip_led3_red<=1;
end

end


counter3=counter3+1;

if(counter3>100000000)
begin
    EU_search_msg_toggle<=0;
    CU_search_msg_toggle<=0;
    RU_search_msg_toggle<=0;
counter3<=0;
end


//All EU Fault Indicator
if((current_node==24) && (fault==1) && (ESU1_found==1) && (skip_led3_blue_ESU_1_found==0))
begin
led1r<=0;
led1g<=0;
led1b<=1;
skip_led3_blue_ESU_1_found<=1;
end
if((current_node==27) && (fault==1) && (ESU2_found==1) && (skip_led3_blue_ESU_2_found==0))
begin
led1r<=0;
led1g<=0;
led1b<=1;
skip_led3_blue_ESU_2_found<=1;
end
if((current_node==28) && (fault==1) && (ESU3_found==1) && (skip_led3_blue_ESU_3_found==0))
begin
led1r<=0;
led1g<=0;
led1b<=1;
skip_led3_blue_ESU_3_found<=1;
end

//All CU Fault Indicator
if((current_node==2) && (fault==1) && (CSU1_found==1) && (skip_led3_blue_CSU_1_found==0))
begin
led2r<=0;
led2g<=0;
led2b<=1;
skip_led3_blue_CSU_1_found<=1;
end
if((current_node==4) && (fault==1) && (CSU2_found==1) && (skip_led3_blue_CSU_2_found==0))
begin
led2r<=0;
led2g<=0;
led2b<=1;
skip_led3_blue_CSU_2_found<=1;
end
if((current_node==6) && (fault==1) && (CSU3_found==1) && (skip_led3_blue_CSU_3_found==0))
begin
led2r<=0;
led2g<=0;
led2b<=1;
skip_led3_blue_CSU_3_found<=1;
end

//All RU Fault Indicator
if((current_node==18) && (fault==1) && (RSU1_found==1) && (skip_led3_blue_RSU_1_found==0))
begin
led3r<=0;
led3g<=0;
led3b<=1;
skip_led3_blue_RSU_1_found<=1;
end
if((current_node==16) && (fault==1) && (RSU2_found==1) && (skip_led3_blue_RSU_2_found==0))
begin
led3r<=0;
led3g<=0;
led3b<=1;
skip_led3_blue_RSU_2_found<=1;
end
if((current_node==15) && (fault==1) && (RSU3_found==1) && (skip_led3_blue_RSU_3_found==0))
begin
led3r<=0;
led3g<=0;
led3b<=1;
skip_led3_blue_RSU_3_found<=1;
end
if((current_node==12) && (fault==1) && (RSU4_found==1) && (skip_led3_blue_RSU_4_found==0))
begin
led3r<=0;
led3g<=0;
led3b<=1;
skip_led3_blue_RSU_4_found<=1;
end


//All EU Deposit Indicator
if((current_node==24) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_ESU_1_deposit==0))
begin
led1r<=0;
led1b<=0;
led1g<=1;
skip_led3_green_ESU_1_deposit<=1;
end
if((current_node==27) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_ESU_2_deposit==0))
begin
led1r<=0;
led1b<=0;
led1g<=1;
skip_led3_green_ESU_2_deposit<=1;
end
if((current_node==28) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_ESU_3_deposit==0))
begin
led1r<=0;
led1b<=0;
led1g<=1;
skip_led3_green_ESU_3_deposit<=1;
end

//All CU Deposit Indicator
if((current_node==2) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_CSU_1_deposit==0))
begin
led2r<=0;
led2b<=0;
led2g<=1;
skip_led3_green_CSU_1_deposit<=1;
end
if((current_node==4) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_CSU_2_deposit==0))
begin
led2r<=0;
led2b<=0;
led2g<=1;
skip_led3_green_CSU_2_deposit<=1;
end
if((current_node==6) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_CSU_3_deposit==0))
begin
led2r<=0;
led2b<=0;
led2g<=1;
skip_led3_green_CSU_3_deposit<=1;
end

//All RU Deposit Indicator
if((current_node==18) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_RSU_1_deposit==0))
begin
led3r<=0;
led3b<=0;
led3g<=1;
skip_led3_green_RSU_1_deposit<=1;
end
if((current_node==16) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_RSU_2_deposit==0))
begin
led3r<=0;
led3b<=0;
led3g<=1;
skip_led3_green_RSU_2_deposit<=1;
end
if((current_node==15) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_RSU_3_deposit==0))
begin
led3r<=0;
led3b<=0;
led3g<=1;
skip_led3_green_RSU_3_deposit<=1;
end
if((current_node==12) && (fault==1) && (state==little_stop_for_depositing_block) && (skip_led3_green_RSU_4_deposit==0))
begin
led3r<=0;
led3b<=0;
led3g<=1;
skip_led3_green_RSU_4_deposit<=1;
end

// if(current_node==13 & state==testing)
// begin
// counter<=counter+1;
// if(counter>50000000)
// begin
// led1r<=0; led2r<=0; led3r<=0;
//  led1b<=0; led2b<=0; led3b<=0;
//  led1g<=~led1g; led2g<=~led2g; led3g<=~led3g;
// counter<=0;
// end
// end


total_message<= EU_fault_toggle + CU_fault_toggle + RU_fault_toggle;

// if( (current_node==18 & next_node==19) | (current_node==13 & next_node==12) | (current_node==5 & next_node==4) | (current_node==7 & next_node==8)  )
// begin
// SPEED<=5;
// end
// if((current_node==19 & next_node==12) | (current_node==12 & next_node==19) | (current_node==14 & next_node==16)  | (current_node==13 & next_node==14)  | (current_node==16 & next_node==17) | (current_node==14 & next_node==15)) 
// begin
//     SPEED<=12;
// end
// else if((current_node==12 & next_node==13) | (current_node==13 & next_node==12)) 
// begin
//     SPEED<=12;
// end

// else if (current_node==0 & next_node==1) 
// begin
//     SPEED<=12;
// end
// else 
// begin
// SPEED<=12;
// end
if(current_node==8)
begin
state<=testing;
end





case (state) 

WAITING_TILL_ONE_MESSAGE_IS_RECIEVED_TIMER_STARTS:
begin
if(total_message>0)
begin
state<=WAITING_FOR_ALL_MESSAGE_OR_30_SEC;
counter<=0;
end
end

WAITING_FOR_ALL_MESSAGE_OR_30_SEC:
begin
counter<=counter+1;
if(counter>=1500000000 || total_message>0)
begin
state<=WAIT_FOR_MESSAGE;
counter<=0;
end

end


WAIT_FOR_MESSAGE:
begin
    reaching_to_ESU1_feedback_toggle<=0;
    reaching_to_ESU2_feedback_toggle<=0;
    reaching_to_ESU3_feedback_toggle<=0;

    reaching_to_CSU1_feedback_toggle<=0;
    reaching_to_CSU2_feedback_toggle<=0;
    reaching_to_CSU3_feedback_toggle<=0;

    reaching_to_RSU1_feedback_toggle<=0;
    reaching_to_RSU2_feedback_toggle<=0;
    reaching_to_RSU3_feedback_toggle<=0;
    reaching_to_RSU4_feedback_toggle<=0;
   

    
if(EU_fault_toggle>0)
begin

    search_EU_toggle<=1;  EU_fault_toggle<=EU_fault_toggle-1;
     state<=SEARCH_SUB_UNIT;
end

else if(CU_fault_toggle>0)
begin
   
    search_CU_toggle<=1;  CU_fault_toggle<=CU_fault_toggle-1; 
    state<=SEARCH_SUB_UNIT;
end

else if(RU_fault_toggle>0)
begin
    search_RU_toggle<=1;  RU_fault_toggle<=RU_fault_toggle-1; 
    state<=SEARCH_SUB_UNIT;
end



else if(total_message==0)
begin
state<=testing;
led1r<=0; led2r<=0; led3r<=0;
led1g<=0; led2g<=0; led3g<=0;
led1b<=0; led2b<=0; led3b<=0;
counter<=0;
end

else
begin
    state<=WAIT_FOR_MESSAGE;

end
end


SEARCH_SUB_UNIT:
begin

if(search_EU_toggle==1)
begin
  search_EU_toggle<=0; EU_path_1_toggle<=1; state<=SEARCH_THE_EU;
end
else if(search_CU_toggle==1)
begin
  search_CU_toggle<=0; CU_path_1_toggle<=1; state<=SEARCH_THE_CU;
end
else if(search_RU_toggle==1)
begin
  search_RU_toggle<=0; RU_path_1_toggle<=1; state<=SEARCH_THE_RU;
end
else if((ESU1_fault_toggle==1) || (ESU2_fault_toggle==1) || (ESU3_fault_toggle==1) || (CSU1_fault_toggle==1) || (CSU2_fault_toggle==1)
 || (CSU3_fault_toggle==1) || (RSU1_fault_toggle==1) || (RSU2_fault_toggle==1) || (RSU3_fault_toggle==1) || (RSU4_fault_toggle==1))
begin
  state<=REACH_TO_SUPPLY_UNIT;
end
else
begin
    state<=WAIT_FOR_MESSAGE;
end
end


SEARCH_THE_EU:
begin
no1 <= 0; no2 <= 0;

if(skip_node_before_searching==0)
  begin
     skip_node_before_searching<=1;
     node_found<=0;
  end
  else
  node_found<=1;

if(EU_path_1_toggle==1)
    begin
        EU_path_1_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=20;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;


         return_to_EU_path_2_toggle<=1;
         state<=CPU_PATH_CALCULATION;
    end


else if(EU_path_2_toggle==1)
    begin
        EU_path_2_toggle<=0;
        searching_ESU_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=25;
        last_second_node<=shortest_path[size_of_path-2];
        
         k<=1; i<=0; j<=0;
        node_found<=1;
         return_to_EU_path_3_toggle<=1;
         state<=CPU_PATH_CALCULATION;
        
    end

else if(EU_path_3_toggle==1)
    begin
        EU_path_3_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=27;
        last_second_node<=shortest_path[size_of_path-2];
          k<=1; i<=0; j<=0;
         
        node_found<=1;
         return_to_EU_path_4_toggle<=1;
         state<=CPU_PATH_CALCULATION;
    end

else if(EU_path_4_toggle==1)
    begin
        EU_path_4_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=29;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
        node_found<=1;
         return_to_search_the_EU<=1;
         state<=CPU_PATH_CALCULATION;
    end

else 
begin
state<=REACH_TO_SUPPLY_UNIT ;
end
   
end

SEARCH_THE_CU:
begin
no1 <= 0; no2 <= 0;
if(skip_node_before_searching==0)
  begin
     skip_node_before_searching<=1;
     node_found<=0;
  end
  else
  node_found<=1;

if(CU_path_1_toggle==1)
    begin
        CU_path_1_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=2;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;

         return_to_CU_path_2_toggle<=1;
         state<=CPU_PATH_CALCULATION;
    end

else if(CU_path_2_toggle==1)
    begin
        CU_path_2_toggle<=0;
        searching_CSU_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=3;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;

         return_to_CU_path_3_toggle<=1;
         state<=CPU_PATH_CALCULATION;
    end
else if(CU_path_3_toggle==1)
    begin
        CU_path_3_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=5;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;

         return_to_CU_path_4_toggle<=1;
         state<=CPU_PATH_CALCULATION;
    end

else if(CU_path_4_toggle==1)
    begin
        CU_path_4_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=7;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;

         return_to_search_the_CU<=1;
         state<=CPU_PATH_CALCULATION;
    end

else 
begin
state<=REACH_TO_SUPPLY_UNIT ;
end
   
end


SEARCH_THE_RU:
begin
no1 <= 0; no2 <= 0;

if(skip_node_before_searching==0)
  begin
     skip_node_before_searching<=1;
     node_found<=0;
  end
  else
  node_found<=1;

if(RU_path_1_toggle==1)
    begin
        RU_path_1_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=12;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;

         return_to_RU_path_2_toggle<=1;
         state<=CPU_PATH_CALCULATION;
    end

else if(RU_path_2_toggle==1)
    begin
        RU_path_2_toggle<=0;
        searching_RSU_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=15;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;

         return_to_RU_path_3_toggle<=1;
         state<=CPU_PATH_CALCULATION;
    end
else if(RU_path_3_toggle==1)
    begin
        RU_path_3_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=17;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;

         return_to_RU_path_4_toggle<=1;
         state<=CPU_PATH_CALCULATION;
    end
else if(RU_path_4_toggle==1)
    begin
        RU_path_4_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=18;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;

         return_to_RU_path_5_toggle<=1;
         state<=CPU_PATH_CALCULATION;
    end

else if(RU_path_5_toggle==1)
    begin
        RU_path_5_toggle<=0;
        Start<=shortest_path[size_of_path-1];
        last<=19;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;

         return_to_search_the_RU<=1;
         state<=CPU_PATH_CALCULATION;
    end

else 
begin
state<=REACH_TO_SUPPLY_UNIT ;
end
   
end



REACH_TO_SUPPLY_UNIT:
begin
    searching_ESU_feedback_toggle<=0;
    searching_CSU_feedback_toggle<=0;
    searching_RSU_feedback_toggle<=0;

    no1 <= 0; no2 <= 0;

 
if(B1_supply_toggle==1)
    begin
        B1_supply_toggle<=0;
        reaching_to_B1_feedback_toggle<=1;
        B1_mem_toggle<=1;
        // Start<=shortest_path[size_of_path-1];
        Start<=next_node;
        last<=22;
        // last_second_node<=shortest_path[size_of_path-2];
        last_second_node<=current_node;
         k<= 1; i<= 0; j<= 0;
         node_found<=1;
         return_to_REACH_TO_SUPPLY_UNIT<= 1;
         state<=CPU_PATH_CALCULATION;
    end
else if(B2_supply_toggle==1)
    begin
        B2_supply_toggle<=0;
        reaching_to_B2_feedback_toggle<=1;
        B2_mem_toggle<=1;
        // Start<=shortest_path[size_of_path-1];
        Start<=next_node;
        last<=10;
        // last_second_node<=shortest_path[size_of_path-2];
        last_second_node<=current_node;
         k<= 1; i<= 0; j<= 0;
         node_found<=1;
         return_to_REACH_TO_SUPPLY_UNIT<= 1;
         state<=CPU_PATH_CALCULATION;
    end
else if(B3_supply_toggle==1)
begin
        B3_supply_toggle<=0;
        reaching_to_B3_feedback_toggle<=1;
        B3_mem_toggle<=1;
        // Start<=shortest_path[size_of_path-1];
        Start<=next_node;
        last<=23;
        // last_second_node<=shortest_path[size_of_path-2];
        last_second_node<=current_node;
         k<= 1; i<= 0; j<= 0;
         node_found<=1;
         return_to_REACH_TO_SUPPLY_UNIT<= 1;
         state<=CPU_PATH_CALCULATION;
end
else if(B4_supply_toggle==1)
    begin
        B4_supply_toggle<=0;
        reaching_to_B4_feedback_toggle<=1;
        B4_mem_toggle<=1;
        // Start<=shortest_path[size_of_path-1];
        Start<=next_node;
        last<=11;
        // last_second_node<=shortest_path[size_of_path-2];
        last_second_node<=current_node;
         k<= 1; i<= 0; j<= 0;
         node_found<=1;
         return_to_REACH_TO_SUPPLY_UNIT<= 1;
         state<=CPU_PATH_CALCULATION;
    end
else
    begin
        state<=REACH_TO_SUPPLY_UNIT;
    end
end


deposit_the_block:
begin
    no1 <= 0; no2 <= 0;
    reaching_to_B1_feedback_toggle<=0;
    reaching_to_B2_feedback_toggle<=0;
    reaching_to_B3_feedback_toggle<=0;
    reaching_to_B4_feedback_toggle<=0;
    
if(ESU1_fault_toggle==1)
    begin
        ESU1_fault_toggle<=0;
        reaching_to_ESU1_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=20;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         add_last_node_in_path_of_ESU1<=1;
         
         state<=CPU_PATH_CALCULATION;
    end
else if(return_to_ESU1_fault_toggle_2==1)
    begin
        return_to_ESU1_fault_toggle_2<=0;
        Start<=shortest_path[size_of_path-1];
        last<=25;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         
         return_to_deposit_the_block_in_ESU1<=1 ;
         state<=CPU_PATH_CALCULATION;
    end


else if(ESU2_fault_toggle==1)
    begin
        ESU2_fault_toggle<=0;
        
        reaching_to_ESU2_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=29;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         add_last_node_in_path_of_ESU2<=1;
         
         state<=CPU_PATH_CALCULATION;
    end
else if(return_to_ESU2_fault_toggle_2==1)
    begin
        return_to_ESU2_fault_toggle_2<=0;
        Start<=shortest_path[size_of_path-1];
        last<=27;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;

         return_to_deposit_the_block_in_ESU2_part_1<=1 ;
         state<=CPU_PATH_CALCULATION;
    end
else if(return_to_ESU2_fault_toggle_3==1)
    begin
        return_to_ESU2_fault_toggle_3<=0;
        Start<=shortest_path[size_of_path-1];
        last<=26;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;

         return_to_deposit_the_block_in_ESU2_part_2<=1 ;
         state<=CPU_PATH_CALCULATION;
    end



else if(ESU3_fault_toggle==1)
begin 
        ESU3_fault_toggle<=0;
        
        reaching_to_ESU3_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=29; //two part needed
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         add_last_node_in_path_of_ESU3<=1;
         
         state<=CPU_PATH_CALCULATION;
        //  state<=testing;
end
else if(return_to_ESU3_fault_toggle_2==1)
begin 
        return_to_ESU3_fault_toggle_2<=0;
        Start<=shortest_path[size_of_path-1];
        last<=28; //two part needed
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         return_to_deposit_the_block_in_ESU3_part_1<=1;
         
         state<=CPU_PATH_CALCULATION;
end
else if(return_to_ESU3_fault_toggle_3==1)
begin 
        return_to_ESU3_fault_toggle_3<=0;
        Start<=shortest_path[size_of_path-1];
        last<=29; //two part needed
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         return_to_deposit_the_block_in_ESU3_part_2<=1;
         
         state<=CPU_PATH_CALCULATION;
end



else if(CSU1_fault_toggle==1)
    begin
        CSU1_fault_toggle<=0;
        
        reaching_to_CSU1_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=2;// two part needed
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         
         return_to_deposit_the_block_in_CSU1<=1 ;
         state<=CPU_PATH_CALCULATION;
    end

else if(CSU1_fault_toggle_part_1==1)
    begin
        CSU1_fault_toggle_part_1<=0;
        Start<=shortest_path[size_of_path-1];
        last<=3;// two part needed
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         
         return_to_deposit_the_block_in_CSU1_part_1<=1 ;
         state<=CPU_PATH_CALCULATION;
    end



else if(CSU2_fault_toggle==1)
    begin
        CSU2_fault_toggle<=0;
        
        reaching_to_CSU2_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=5;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         add_last_node_in_path_of_CSU2<=1;
        return_to_deposit_the_block_in_CSU2<=1 ;
         state<=CPU_PATH_CALCULATION;
    end





else if(CSU3_fault_toggle==1)
    begin
        CSU3_fault_toggle<=0;
        reaching_to_CSU3_feedback_toggle<=1;
        
        Start<=shortest_path[size_of_path-1];
        last<=8;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         add_last_node_in_path_of_CSU3<=1;
         state<=CPU_PATH_CALCULATION;
    end
else if(return_to_CSU3_fault_toggle_2==1)
    begin
        return_to_CSU3_fault_toggle_2<=0;
        Start<=shortest_path[size_of_path-1];
        last<=6;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         
         add_last_node_in_path_of_CSU3_2<=1 ;
         state<=CPU_PATH_CALCULATION;
    end
else if(return_to_CSU3_fault_toggle_3==1)
    begin
        return_to_CSU3_fault_toggle_3<=0;
        Start<=shortest_path[size_of_path-1];
        last<=7;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         
         return_to_deposit_the_block_in_CSU3<=1 ;
         state<=CPU_PATH_CALCULATION;
    end





else if(RSU1_fault_toggle==1)
    begin
        RSU1_fault_toggle<=0;
        
        reaching_to_RSU1_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=18;
         k<=1; i<=0; j<=0;
         node_found<=1;
         add_last_node_in_path_of_RSU1<=1;
         last_second_node<=shortest_path[size_of_path-2];
         
         state<=CPU_PATH_CALCULATION;
    end
else if(return_to_RSU1_fault_toggle_2==1)
    begin
        return_to_RSU1_fault_toggle_2<=0;
        Start<=shortest_path[size_of_path-1];
        last<=19;
         k<=1; i<=0; j<=0;
         node_found<=1;
         
         last_second_node<=shortest_path[size_of_path-2];
         return_to_deposit_the_block_in_RSU1<=1 ;
         state<=CPU_PATH_CALCULATION;
    end



else if(RSU2_fault_toggle==1)
    begin
        RSU2_fault_toggle<=0;
       
        reaching_to_RSU2_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=17;
         k<=1; i<=0; j<=0;
         node_found<=1;
         add_last_node_in_path_of_RSU2<=1;
         last_second_node<=shortest_path[size_of_path-2];
         return_to_deposit_the_block_in_RSU2<=1 ;
         state<=CPU_PATH_CALCULATION;
    end


else if(RSU3_fault_toggle==1)
    begin
        RSU3_fault_toggle<=0;
        
        reaching_to_RSU3_feedback_toggle<=1;
        Start<=shortest_path[size_of_path-1];
        last<=15; //two parts needed
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         add_last_node_in_path_of_RSU3<=1;
         
         state<=CPU_PATH_CALCULATION;
    end
else if(return_to_RSU3_fault_toggle_2==1)
    begin
        return_to_RSU3_fault_toggle_2<=0;
        Start<=shortest_path[size_of_path-1];
        last<=14; //two parts needed
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         
         return_to_deposit_the_block_in_RSU3<=1 ;
         state<=CPU_PATH_CALCULATION;
    end


else if(RSU4_fault_toggle==1)
    begin
        RSU4_fault_toggle<=0;
        reaching_to_RSU4_feedback_toggle<=1;

        Start<=shortest_path[size_of_path-1];
        last<=13;
        last_second_node<=shortest_path[size_of_path-2];
         k<=1; i<=0; j<=0;
         node_found<=1;
         return_to_deposit_the_block_in_RSU4<=1 ;
         state<=CPU_PATH_CALCULATION;
    end
else
    begin
        // state<=SEARCH_SUB_UNIT;
        state<=deposit_the_block;
    end
end








CPU_PATH_CALCULATION : begin


    if(cpu_counter <10000 ) begin
    cpu_reset <= 1;
   shortest_path[0] <= 0;
  shortest_path[1] <= 0;
  shortest_path[2] <= 0;
  shortest_path[3] <= 0;
  shortest_path[4] <= 0;
  shortest_path[5] <= 0;
  shortest_path[6] <= 0;
  shortest_path[7] <= 0;
  shortest_path[8] <= 0;
  shortest_path[9] <= 0;
  shortest_path[10] <= 0;
  shortest_path[11] <= 0;
  shortest_path[12] <= 0;
  size_of_path <= 0;
          SP <= Start;
        EP <= last;


        cpu_counter <= cpu_counter + 1;
    end


    else begin

        cpu_reset <= 0;

  if(cpu_done==1) begin

  shortest_path[0] <= path0;
  shortest_path[1] <= path1;
  shortest_path[2] <= path2;
  shortest_path[3] <= path3;
  shortest_path[4] <= path4;
  shortest_path[5] <= path5;
  shortest_path[6] <= path6;
  shortest_path[7] <= path7;
  shortest_path[8] <= path8;
  shortest_path[9] <= path9;
  shortest_path[10] <= path10;
  shortest_path[11] <= path11;
  shortest_path[12] <= path12;
  size_of_path <= index;
  cpu_counter <= 0;
    if(skip_2==0)
  begin
    skip_2<=1;
    state<=DIRECTION_TO_TURN_ARRAY_MAKER;
  end
    else
    begin
        state<=adjusted_shortest_path;
    end
  end
end
end



adjusted_shortest_path:
begin

  shortest_path[15] <= shortest_path[14];
  shortest_path[14] <= shortest_path[13];
  shortest_path[13] <= shortest_path[12];
  shortest_path[12] <= shortest_path[11];
  shortest_path[11] <= shortest_path[10];
  shortest_path[10] <= shortest_path[9];
  shortest_path[9] <= shortest_path[8];
  shortest_path[8] <= shortest_path[7];
  shortest_path[7] <= shortest_path[6];
  shortest_path[6] <= shortest_path[5];
  shortest_path[5] <= shortest_path[4];
  shortest_path[4] <= shortest_path[3];
  shortest_path[3] <= shortest_path[2];
  shortest_path[2] <= shortest_path[1];
  shortest_path[1] <= shortest_path[0];
  shortest_path[0] <= last_second_node;
  size_of_path <= size_of_path+1;
  state<=DIRECTION_TO_TURN_ARRAY_MAKER;



end



DECISION:
begin
  previous_node=shortest_path[k-1];
  current_node=shortest_path[k];
  next_node=shortest_path[k+1];
  pick_done<=0;
  deposit_done<=0;

if(node_found==1)
begin
  
  if(direction_arr[j]==0)
  begin
    state<=WHITE_LINE_FOUND_LEFT_TURN;
   
  end
  else if(direction_arr[j]==1)
  begin
    state<=BLACK_LINE_FOUND_LEFT_TURN_PART_ONE;
  
  end
  else if(direction_arr[j]==2)
  begin
    state<=white_line_found_right_turn;
    
  end
  else if(direction_arr[j]==3)
  begin
    state<=black_line_found_right_turn_part_one;
  
  end
  else if(direction_arr[j]==4)
  begin
    state<=forward_0;
   
  end
  else if(direction_arr[j]==5)
  begin
    state<=double_left_white_part_one;
   
  end
  else if(direction_arr[j]==6)
  begin
    state<=double_right_white_part_one;
  end
  else if(direction_arr[j]==7)
  begin
    state<=turn_around;
  end
  else if(direction_arr[j]==8)
  begin
    state<=GO_STRAIGHT_SPECIAL_CASE_RIGHT_ONE;
  end
  else if(direction_arr[j]==9)
  begin
    state<=GO_STRAIGHT_SPECIAL_CASE_LEFT_ONE;
  end
 counter<=0;
end

else if(node_found==0)
begin
    
    

if((shortest_path[k]==28 && shortest_path[k+1]==3) || (shortest_path[j]==3 && shortest_path[k+1]==28) )
    begin 
         state<=FOLLOWER;
    end
else
    begin
        state<=FOLLOWER;

    end
end

end


DIRECTION_TO_TURN_ARRAY_MAKER:  //         Makes turn direction array from path
begin
    cpu_counter <= 0;

if(i<(size_of_path-1))begin
  if(i>=1)
  begin
        direction_arr[i-1]<=dir;
  end
  if(i==(size_of_path-2))
        i<=i+1;
  if(i<(size_of_path-2))
    begin
        array[0]<=shortest_path[i];
        array[1]<=shortest_path[i+1];
        array[2]<=shortest_path[i+2];
        i<=i+1;
        state<=DIRECTION_TO_MOVE;

    end

  else
  begin
   state<=DECISION;
  end

end
end



FOLLOWER:
begin


if(c_data>250)
begin
    no1 <= 15; no2 <= 15;
end
if(l_data>250)
begin
    no1 <= 0; no2 <= SPEED;
end
if(r_data>250)
begin
    no1 <= SPEED; no2 <= 0;
end
if((l_data<400 & c_data<400 & r_data<400 ))
begin
    no1 <= SPEED; no2 <= 4;
state <= follower_search_line;

    counter<=0;
end

    

 if(l_data>400 & c_data>400 & r_data>400 )    //
begin

    state<= LITTLE_STOP_AFTER_DETECTING_NODE;
     
end



if((fault==1) &&  (current_node==22 | current_node==9 | current_node==21) && (pick_done==0))
begin;
    pick_done<=1;
state<=fault_found_pickup_block;
counter<=0;

end

if((fault==1) && ((reaching_to_ESU1_feedback_toggle==1) || (reaching_to_ESU2_feedback_toggle==1) || 
(reaching_to_ESU3_feedback_toggle==1) || (reaching_to_CSU1_feedback_toggle==1) || (reaching_to_CSU2_feedback_toggle==1) || 
(reaching_to_CSU3_feedback_toggle==1) || (reaching_to_RSU1_feedback_toggle==1) || (reaching_to_RSU2_feedback_toggle==1) || 
(reaching_to_RSU3_feedback_toggle==1) || (reaching_to_RSU4_feedback_toggle==1)) && (deposit_done==0) && (current_node!=22) && (current_node!=10) && (current_node!=23) && (current_node!=11) && (current_node!=3))
begin
deposit_done<=1;

state<=fault_found_deposit_it;
counter<=0;
    if(ESU1_fixed==1 & current_node==24)
    state<=FOLLOWER;
    else if(ESU2_fixed==1 & current_node==27)
    state<=FOLLOWER;
    else if(ESU3_fixed==1 & current_node==28)
    state<=FOLLOWER;
    else if(CSU1_fixed==1 & current_node==2)
    state<=FOLLOWER;
    else if(CSU2_fixed==1 & current_node==4)
    state<=FOLLOWER;
    else if(CSU3_fixed==1 & current_node==6)
    state<=FOLLOWER;
    else if(RSU1_fixed==1 & current_node==18)
    state<=FOLLOWER;
    else if(RSU2_fixed==1 & current_node==16)
    state<=FOLLOWER;
    else if(RSU3_fixed==1 & current_node==15)
    state<=FOLLOWER;
    else if(RSU4_fixed==1 & current_node==12)
    state<=FOLLOWER;


end

if((fault==1) && ((searching_ESU_feedback_toggle==1) || (searching_CSU_feedback_toggle==1) || (searching_RSU_feedback_toggle==1)) && (ESU1_fault_toggle==0 & ESU2_fault_toggle==0 & ESU3_fault_toggle==0 & CSU1_fault_toggle==0 & CSU2_fault_toggle==0 & CSU3_fault_toggle==0 & RSU1_fault_toggle==0 & RSU2_fault_toggle==0 & RSU3_fault_toggle==0 & RSU4_fault_toggle==0))
begin
    state<=store_in_fault_toggle;

    if(ESU1_found==1 & current_node==24)
    begin
    state<=FOLLOWER;
    end
    if(ESU2_found==1 & current_node==27)
    begin
    state<=FOLLOWER;
    end
    if(ESU3_found==1 & current_node==28)
    begin
    state<=FOLLOWER;
    end
    if(CSU1_found==1 & current_node==2)
    begin
    state<=FOLLOWER;
    end
    if(CSU2_found==1 & current_node==4)
    begin
    state<=FOLLOWER;
    end
    if(CSU3_found==1 & current_node==6)
    begin
    state<=FOLLOWER;
    end
    if(RSU1_found==1 & current_node==18)
    begin
    state<=FOLLOWER;
    end
    if(RSU2_found==1 & current_node==16)
    begin
    state<=FOLLOWER;
    end
    if(RSU3_found==1 & current_node==15)
    begin
    state<=FOLLOWER;
    end
    if(RSU4_found==1 & current_node==12)
    begin
    state<=FOLLOWER;
    end
    
end





end



follower_search_line:
begin
    


if(counter>0)
begin
    no1<=SPEED; no2<=4;
end
if(counter>(6000000))
begin
    no1<=4; no2<=SPEED;
end

if(c_data>400)
begin
    state<=FOLLOWER;
    counter<= 0;
   
end
counter<= counter+1;
end


SPECIAL_FOLLOWER:
begin

if(l_data>r_data)
begin
    no1 <= 0; no2 <= SPEED;
end
else if(l_data<r_data)
begin
    no1 <= SPEED; no2 <= 0;
end

if( l_data>400 & c_data>400 & r_data>400 ) 
begin
	state <= little_forward;
end

end




LITTLE_STOP_AFTER_DETECTING_NODE :	// 100ms delay
begin 	
    no1<=0; no2<=0;

if (counter < 20) 
	begin
		counter <= counter + 1;
	end 
else 
	begin
		counter <= 0;
		state <= little_forward ;
	end
end
little_forward :	// 100ms delay
begin 	
    no1<=SPEED; no2<=SPEED;

if (counter < 14000000) 
	begin
		counter <= counter + 1;
	end 
else 
	begin
		counter <= 0;
		state <= check_line ;
	end
end



check_line:
begin

no1<=SPEED; no2<=SPEED;

if((l_data<100 && c_data<100) | (r_data<100 && c_data<100))
begin
    found_white_line_after_node<=1;
    state<=reverse;
  
end

if((l_data<100 && c_data>200) | (r_data<100 && c_data>200))
begin
    found_black_line_after_node<=1;
    state<=reverse;
end

node_found<=1;
end


reverse :	// 100ms delay
begin 	
    
if (counter < 8000000) 
	begin
		counter <= counter + 1;
        if(current_node==14)
        begin
            no1 <= SPEED; no2 <= SPEED;
        end
        else
        begin
		no1 <= 4; no2 <= 4;
        end
	end 
else 
	begin
		counter <= 0; state <= stop ;
	end

end



stop :	// 1s delay
begin 	
if (counter < 5000000) 
	begin
		counter <= counter + 1;
		no1 <= 0;
		no2 <= 0;
	end 
else 
	begin
        k<=k+1;
        counter <= 0;
        state<=DECISION;
    
        if((shortest_path[k]==last) && (return_to_EU_path_2_toggle==1) && (skip_4==0))
        begin
        skip_4<=1;
        return_to_EU_path_2_toggle<=0;
        EU_path_2_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_EU;
        end
        else if((shortest_path[k+1]==last) && (return_to_EU_path_2_toggle==1) && (skip_4==1))
        begin
        return_to_EU_path_2_toggle<=0;
        EU_path_2_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_EU;
        end

        else if((shortest_path[k+1]==last) && (return_to_EU_path_3_toggle==1))
        begin
        return_to_EU_path_3_toggle<=0;
        EU_path_3_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_EU;
        end
        else if((shortest_path[k+1]==last) && (return_to_EU_path_4_toggle==1))
        begin
        return_to_EU_path_4_toggle<=0;
        EU_path_4_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_EU;
        end
        else if((shortest_path[k+1]==last) && (return_to_search_the_EU==1))
        begin
        return_to_search_the_EU<=0;
        
        // state<=testing;
        state<=REACH_TO_SUPPLY_UNIT;
        end

        else if((shortest_path[k]==last) && (return_to_CU_path_2_toggle==1) && (skip_4==0))
        begin
        skip_4<=1;
        return_to_CU_path_2_toggle<=0;
        CU_path_2_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_CU;
        end
        else if((shortest_path[k+1]==last) && (return_to_CU_path_2_toggle==1) && (skip_4==1))
        begin
        return_to_CU_path_2_toggle<=0;
        CU_path_2_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_CU;
        end
        else if((shortest_path[k+1]==last) && (return_to_CU_path_3_toggle==1))
        begin
        return_to_CU_path_3_toggle<=0;
        CU_path_3_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_CU;
        end
        else if((shortest_path[k+1]==last) && (return_to_CU_path_4_toggle==1))
        begin
        return_to_CU_path_4_toggle<=0;
        CU_path_4_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_CU;
        end
        else if((shortest_path[k+1]==last) && (return_to_search_the_CU==1))
        begin
        return_to_search_the_CU<=0;
        // state<=testing;
        state<=REACH_TO_SUPPLY_UNIT;
        end

        else if((shortest_path[k]==last) && (return_to_RU_path_2_toggle==1) && (skip_4==0))
        begin
        skip_4<=1;
        return_to_RU_path_2_toggle<=0;
        RU_path_2_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_RU;
        end
        else if((shortest_path[k+1]==last) && (return_to_RU_path_2_toggle==1) && (skip_4==1))
        begin
        return_to_RU_path_2_toggle<=0;
        RU_path_2_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_RU;
        end
        else if((shortest_path[k+1]==last) && (return_to_RU_path_3_toggle==1))
        begin
        return_to_RU_path_3_toggle<=0;
        RU_path_3_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_RU;
        end
        else if((shortest_path[k+1]==last) && (return_to_RU_path_4_toggle==1))
        begin
        return_to_RU_path_4_toggle<=0;
        RU_path_4_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_RU;
        end
        else if((shortest_path[k+1]==last) && (return_to_RU_path_5_toggle==1))
        begin
        return_to_RU_path_5_toggle<=0;
        RU_path_5_toggle<=1;
        // state<=testing;
        state<=SEARCH_THE_RU;
        end
        else if((shortest_path[k+1]==last) && (return_to_search_the_RU==1))
        begin
        return_to_search_the_RU<=0;
        // state<=testing;
        state<=REACH_TO_SUPPLY_UNIT;
        end

        else if((shortest_path[k+1]==last) && (return_to_REACH_TO_SUPPLY_UNIT==1))
        begin
        return_to_REACH_TO_SUPPLY_UNIT<=0;
        // state<=testing;
        state<=deposit_the_block;
        end



        else if((shortest_path[k+1]==last) && (add_last_node_in_path_of_ESU1==1))
        begin
        add_last_node_in_path_of_ESU1<=0;
        // state<=testing;
        return_to_ESU1_fault_toggle_2<=1;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_ESU1==1))
        begin
        return_to_deposit_the_block_in_ESU1<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end



        else if((shortest_path[k+1]==last) && (add_last_node_in_path_of_ESU2==1))
        begin
        add_last_node_in_path_of_ESU2<=0;
        // state<=testing;
         return_to_ESU2_fault_toggle_2<=1;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_ESU2_part_1==1))
        begin
        return_to_deposit_the_block_in_ESU2_part_1<=0;
        // state<=testing;
        return_to_ESU2_fault_toggle_3<=1;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_ESU2_part_2==1))
        begin
        return_to_deposit_the_block_in_ESU2_part_2<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end



        else if((shortest_path[k+1]==last) && (add_last_node_in_path_of_ESU3==1))
        begin
        add_last_node_in_path_of_ESU3<=0;
        // state<=testing;
        return_to_ESU3_fault_toggle_2<=1;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_ESU3_part_1==1))
        begin
        return_to_deposit_the_block_in_ESU3_part_1<=0;
        // state<=testing;
        return_to_ESU3_fault_toggle_3<=1;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_ESU3_part_2==1))
        begin
        return_to_deposit_the_block_in_ESU3_part_2<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end



        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_CSU1==1))
        begin
        return_to_deposit_the_block_in_CSU1<=0;
        // state<=testing;
        CSU1_fault_toggle_part_1<=1;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_CSU1_part_1==1))
        begin
        return_to_deposit_the_block_in_CSU1_part_1<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end
        



        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_CSU2==1))
        begin
        return_to_deposit_the_block_in_CSU2<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end




        else if((shortest_path[k+1]==last) && (add_last_node_in_path_of_CSU3==1))
        begin
        add_last_node_in_path_of_CSU3<=0;
        // state<=testing;
        return_to_CSU3_fault_toggle_2<=1;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (add_last_node_in_path_of_CSU3_2==1))
        begin
        add_last_node_in_path_of_CSU3_2<=0;
        // state<=testing;
        return_to_CSU3_fault_toggle_3<=1;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_CSU3==1))
        begin
        return_to_deposit_the_block_in_CSU3<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end





        else if((shortest_path[k+1]==last) && (add_last_node_in_path_of_RSU1==1))
        begin
        add_last_node_in_path_of_RSU1<=0;
        // state<=testing;
        return_to_RSU1_fault_toggle_2<=1 ;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_RSU1==1))
        begin
        return_to_deposit_the_block_in_RSU1<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end





        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_RSU2==1))
        begin
        return_to_deposit_the_block_in_RSU2<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end



        else if((shortest_path[k+1]==last) && (add_last_node_in_path_of_RSU3==1))
        begin
        add_last_node_in_path_of_RSU3<=0;
        // state<=testing;
        return_to_RSU3_fault_toggle_2<=1;
        state<=deposit_the_block;
        end
        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_RSU3==1))
        begin
        return_to_deposit_the_block_in_RSU3<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end



        else if((shortest_path[k+1]==last) && (return_to_deposit_the_block_in_RSU4==1))
        begin
        return_to_deposit_the_block_in_RSU4<=0;
        // state<=testing;
        state<=WAIT_FOR_MESSAGE;
        end

        if(fault_found_go_to_deposit_block==1)
        begin
        EU_path_1_toggle<=0;
        return_to_EU_path_2_toggle<=0;
        EU_path_2_toggle<=0;
        return_to_EU_path_3_toggle<=0;
        EU_path_3_toggle<=0;
        return_to_EU_path_4_toggle<=0;
        EU_path_4_toggle<=0;
        return_to_search_the_EU<=0;
        CU_path_1_toggle<=0;
        return_to_CU_path_2_toggle<=0;
        CU_path_2_toggle<=0;
        return_to_CU_path_3_toggle<=0;
        CU_path_3_toggle<=0;
        return_to_CU_path_4_toggle<=0;
        CU_path_4_toggle<=0;
        return_to_search_the_CU<=0;
        RU_path_1_toggle<=0;
        return_to_RU_path_2_toggle<=0;
        RU_path_2_toggle<=0;
        return_to_RU_path_3_toggle<=0;
        RU_path_3_toggle<=0;
        return_to_RU_path_4_toggle<=0;
        RU_path_4_toggle<=0;
        return_to_RU_path_5_toggle<=0;
        RU_path_5_toggle<=0;
        return_to_search_the_RU<=0;

        state<=REACH_TO_SUPPLY_UNIT;

        fault_found_go_to_deposit_block<=0;

        end
       
	end

end



testing: //            testingStarts
begin

no1 <= 0;
no2 <= 0;
counter<=counter+1;
if(counter>50000000)
begin
led1g<=~led1g; led2g<=~led2g; led3g<=~led3g;
counter<=0;
end

end

//                     testing   ends  




//                              Fault _Pickup Block
fault_found_pickup_block:
begin
    em1<=1;
    em2<=1;
no1<=2; no2<=2;
counter<=counter+1;
if(counter>10000)
begin
no1<=0; no2<=0;
state<=turn_little_right_for_picking_block;
counter<=0;
end

end

turn_little_right_for_picking_block:
begin
no1<=2; no2<=4;
counter<=counter+1;
if(counter>10)
begin
state<=stop_little_time_for_picking_block;
// state<=testing;

counter<=0;

end

end

stop_little_time_for_picking_block:
begin
no1<=0; no2<=0;
counter<=counter+1;
if(counter>60000000)
begin
// state<=testing;
state<=turn_little_left_after_picking_block;
counter<=0;

end

end


turn_little_left_after_picking_block:
begin
no1<=4; no2<=SPEED;
counter<=counter+1;
if(counter>10)
begin
state<=MOVE_REVERSE;
counter<=0;
fault_collected<=1;
end

end

MOVE_REVERSE:
begin
if(c_data>250)
begin
    no1 <= 4; no2 <= 4;
end
if(l_data>250)
begin
    no1 <= 4; no2 <= 0;
end
if(r_data>250)
begin
    no1 <= 0; no2 <= 4;
end

 if((l_data>400 & c_data>400 & r_data>400 ))   //
begin

    state<= LITTLE_FORWARD_FOR_STOPPING;
    counter<=0;
     
end

end

LITTLE_FORWARD_FOR_STOPPING:
begin
    no1<=SPEED; no2<=SPEED;
		counter <= counter + 1;
if(counter>15000000)
	begin
		counter <= 0;
        state<=STOP_FOR_SOME_TIME;
	end

end

STOP_FOR_SOME_TIME:
begin
no1<=0; no2<=0;
		counter <= counter + 1;
if(counter>30000000)
	begin
		counter <= 0;
        if((current_node==21 & next_node==22))
        begin
        shortest_path[size_of_path-1]<=21;
        shortest_path[size_of_path-2]<=20;
		state <= TURN_RIGHT_UNTIL_WE_GET_WHITE ;
        end
        else if((current_node==21 & next_node==23))
        begin
        shortest_path[size_of_path-1]<=21;
        shortest_path[size_of_path-2]<=20;
        state <= TURN_LEFT_UNTIL_WE_GET_WHITE;
        end
        else if((current_node==9 & next_node==11))
        begin
        shortest_path[size_of_path-1]<=9;
        shortest_path[size_of_path-2]<=8;
        state <= TURN_RIGHT_UNTIL_WE_GET_WHITE;
        end
        else if((current_node==9 & next_node==10))
        begin
        shortest_path[size_of_path-1]<=9;
        shortest_path[size_of_path-2]<=8;
        state <= TURN_LEFT_UNTIL_WE_GET_WHITE;
        end
	end
end

TURN_RIGHT_UNTIL_WE_GET_WHITE:  // Right turn when found no line
begin
no1<=SPEED; no2<=4;
if(l_data<100 && c_data<100 && r_data<100)
begin
state<=LITTLE_MORE_RIGHT;


end
end
LITTLE_MORE_RIGHT:  // Right turn when found no line
begin
no1<=SPEED; no2<=4;
counter<=counter+1;
if(counter>500000)
begin
state<=STOP_FOR_SOME_TIME_AFTER_TURNING;
counter<=0;

end
end

TURN_LEFT_UNTIL_WE_GET_WHITE:  // Left turn when found no line
begin
    
no1<=4; no2<=SPEED;
if(l_data<100 && c_data<100 && r_data<100)
begin
state<=LITTLE_MORE_LEFT;

end
end

LITTLE_MORE_LEFT:  // Left turn when found no line
begin
    
no1<=4; no2<=SPEED;
counter<=counter+1;
if(counter>500000)
begin
state<=STOP_FOR_SOME_TIME_AFTER_TURNING;
counter<=0;

end
end

STOP_FOR_SOME_TIME_AFTER_TURNING:
begin
no1<=0; no2<=0;
counter<=counter+1;
if(counter>50000000)
begin
state<=EXITING_PICKING_UP_BLOCK;
counter<=0;
end
end

EXITING_PICKING_UP_BLOCK:
begin
return_to_REACH_TO_SUPPLY_UNIT<= 0;
state<=deposit_the_block;

end







//                   Fault _Pickup Block_Ends


//                   Fault _Deposit Block_Starts
fault_found_deposit_it:
begin
no1<=4; no2<=4;
counter<=counter+1;
if(counter>2700000)
begin
state<=little_stop_for_depositing_block;
no1<=0; no2<=0;
counter<=0;

    if(reaching_to_ESU1_feedback_toggle==1 & current_node==24)
    ESU1_fixed<=1;
    else if(reaching_to_ESU2_feedback_toggle==1 & current_node==27)
    ESU2_fixed<=1;
    else if(reaching_to_ESU3_feedback_toggle==1 & current_node==28)
    ESU3_fixed<=1;
    else if(reaching_to_CSU1_feedback_toggle==1 & current_node==2)
    CSU1_fixed<=1;
    else if(reaching_to_CSU2_feedback_toggle==1 & current_node==4)
    CSU2_fixed<=1;
    else if(reaching_to_CSU3_feedback_toggle==1 & current_node==6)
    CSU3_fixed<=1;
    else if(reaching_to_RSU1_feedback_toggle==1 & current_node==18)
    RSU1_fixed<=1;
    else if(reaching_to_RSU2_feedback_toggle==1 & current_node==16)
    RSU2_fixed<=1;
    else if(reaching_to_RSU3_feedback_toggle==1 & current_node==15)
    RSU3_fixed<=1;
    else if(reaching_to_RSU4_feedback_toggle==1 & current_node==12)
    RSU4_fixed<=1;

end

end
little_stop_for_depositing_block:
begin
no1<=0; no2<=0;
counter<=counter+1;
if(counter>25000000)
begin
// state<=testing;
state<=LITTLE_FORWARD_FOR_DEPOSIT_BLOCK;
no1<=0; no2<=0;
counter<=0;
end
end

LITTLE_FORWARD_FOR_DEPOSIT_BLOCK:
begin

no1<=SPEED; no2<=SPEED;
counter<=counter+1;
    
if((counter>5620000) & (current_node==27 | current_node==4 | current_node==16 | current_node==15 ))
begin
state<=LITTLE_RIGHT_Part1;
no1<=0; no2<=0;
counter<=0;
end
else if(counter>5020000)
begin
state<=STOP_LITTLE_MORE;
no1<=0; no2<=0;
counter<=0;
end
end

LITTLE_RIGHT_Part1:
begin

no1<=SPEED; no2<=4;
counter<=counter+1;
    
if(counter>10000000)
begin
em1<=0;
em2<=0;
state<=STOP_LITTLE_MORE;
no1<=0; no2<=0;
counter<=0;
end
end

STOP_LITTLE_MORE:
begin
em1<=0;
em2<=0;
no1<=0; no2<=0;
counter<=counter+1;
    
if(counter>9500000)
begin
state<=little_right_for_depositing_block;
no1<=0; no2<=0;
counter<=0;
end
end
little_right_for_depositing_block:
begin
em1<=0;
em2<=0;
no1<=4; no2<=4;
counter<=counter+1;
    
if(counter>9500000)
begin
    
    
state<=FOLLOWER;
no1<=0; no2<=0;
counter<=0;
end
end






//                 Fault_deposit block ends

//                 Fault toggle begin

store_in_fault_toggle:
begin

state<=FOLLOWER;

if(current_node ==24 & ESU1_found==0)
begin
ESU1_fault_toggle<=1;
ESU1_found<=1;
fault_found_go_to_deposit_block<=1;
end

else if(current_node ==27 & ESU2_found==0)
begin
ESU2_fault_toggle<=1;
ESU2_found<=1;
fault_found_go_to_deposit_block<=1;
end

else if(current_node ==28 & ESU3_found==0)
begin
ESU3_fault_toggle<=1;
ESU3_found<=1;
fault_found_go_to_deposit_block<=1;
end

else if(current_node ==2 & CSU1_found==0)
begin
CSU1_fault_toggle<=1;
CSU1_found<=1;
fault_found_go_to_deposit_block<=1;
end

else if(current_node ==4 & CSU2_found==0)
begin
CSU2_fault_toggle<=1;
CSU2_found<=1;
fault_found_go_to_deposit_block<=1;
end

else if(current_node ==6 & CSU3_found==0)
begin
CSU3_fault_toggle<=1;
CSU3_found<=1;
fault_found_go_to_deposit_block<=1;
end

else if(current_node ==18 & RSU1_found==0)
begin
RSU1_fault_toggle<=1;
RSU1_found<=1;
fault_found_go_to_deposit_block<=1;
end

else if(current_node ==16 & RSU2_found==0)
begin
RSU2_fault_toggle<=1;
RSU2_found<=1;
fault_found_go_to_deposit_block<=1;
end

else if(current_node ==15 & RSU3_found==0)
begin
RSU3_fault_toggle<=1;
RSU3_found<=1;
fault_found_go_to_deposit_block<=1;
end

else if(current_node ==12 & RSU4_found==0)
begin
RSU4_fault_toggle<=1;
RSU4_found<=1;
fault_found_go_to_deposit_block<=1;
end



end




WHITE_LINE_FOUND_LEFT_TURN:  // Left turn when found no line
begin
no1<=4; no2<=SPEED;
if(l_data<100 && c_data>200 && r_data<100)
begin
state<=white_line_found_left_turn_part_1;
node_found<=0;
 j<=j+1;
end
end

white_line_found_left_turn_part_1:
begin
no1<=4; no2<=SPEED;
counter<=counter+1;
if(counter>500000)
begin
state<=DECISION;
counter<=0;
end
end


BLACK_LINE_FOUND_LEFT_TURN_PART_ONE:   // Left turn when found black line part-1
begin

no1<=4; no2<=SPEED;
if(c_data<100 && r_data<100)
begin
state<=black_line_found_left_turn_part_two;
end

end

black_line_found_left_turn_part_two:    // Left turn when found black line part-2
begin

no1<=4; no2<=SPEED;
if(c_data>200 && r_data<100)
begin
state<=white_line_found_left_turn_part_1;
node_found<=0;
 j<=j+1;
end

end



white_line_found_right_turn:  // Right turn when found no line
begin
    
no1<=SPEED; no2<=4;
if(l_data<100 && c_data>200 && r_data<200)
begin
state<=white_line_found_right_turn_part_1;
node_found<=0;
 j<=j+1;
 counter<=0;
end
end

white_line_found_right_turn_part_1:
begin
no1<=SPEED; no2<=4;
counter<=counter+1;
if(counter>500000)
begin
state<=DECISION;
counter<=0;
end
end

black_line_found_right_turn_part_one:   // Right turn when found black line part-1
begin


no1<=SPEED; no2<=4;
if(l_data<100 && c_data<100)
begin
state<=black_line_found_right_turn_part_two;
end


end

black_line_found_right_turn_part_two:    // Right turn when found black line part-2
begin

no1<=SPEED; no2<=4;
if(l_data<100 && c_data>200)
begin
state<=white_line_found_right_turn_part_1;
node_found<=0;
 j<=j+1;
end

end

//forward_0:  // Moves the bot forward after node
//begin
//no1<=5;
//no2<=5;
//if((l_data<100 && c_data>200) | (r_data<100 && c_data>200))
//begin
//    state<=DECISION;
//    node_found<=0;
//    j<=j+1;
//end


forward_0:  // Moves the bot forward after node
begin

    no1<=SPEED; no2<=SPEED;
    state<=DECISION;
    node_found<=0;
    j<=j+1;


end


double_left_white_part_one:  // Moves bot double left part-1 (Searches for black line while moving anti-clockwise)
begin

no1<=4; no2<=SPEED;
if(c_data>200 && r_data<100)
begin
state<=double_left_white_part_two;
end

end

double_left_white_part_two:// Moves bot double left part-2 (Searches for white while moving anti-clockwise)
begin

no1<=4; no2<=SPEED;
if(c_data<100 && r_data<100)
begin
state<=double_left_white_part_three;
end

end

double_left_white_part_three:// Moves bot double left part-3 (Searches for black line while moving anti-clockwise)
begin

no1<=4; no2<=SPEED;
if(c_data>200 && r_data<100)
begin
state<=white_line_found_left_turn_part_1;
node_found<=0;
 j<=j+1;
end

end

double_right_white_part_one:  // Moves bot double right part-1 (Searches for black line while moving clockwise)
begin

no1<=SPEED; no2<=4;
if(l_data<100 && c_data>200)
begin
state<=double_right_white_part_two;
end

end

double_right_white_part_two:// Moves bot double right part-2 (Searches for white while moving clockwise)
begin

no1<=SPEED; no2<=4;
if(l_data<100 && c_data<100)
begin
state<=double_right_white_part_three;
end

end

double_right_white_part_three:// Moves bot double right part-3 (Searches for black line while moving clockwise)
begin

no1<=SPEED; no2<=4;
if(l_data<100 && c_data>200)
begin
state<=white_line_found_right_turn_part_1;
node_found<=0;
j<=j+1;
end

end

turn_around:// Turn_around 180 degree
begin


no1<=4; no2<=SPEED;
counter<=counter+1;
if(counter>47000000)
begin
state<=DECISION;
node_found<=0;
counter<=0;
j<=j+1;
end

end

GO_STRAIGHT_SPECIAL_CASE_RIGHT_ONE:  // Moves the bot right turn in node 19
begin

no1<=SPEED; no2<=SPEED;
counter<=counter+1;
if(counter>11000000)
begin
state<=GO_STRAIGHT_SPECIAL_CASE_RIGHT_TWO;
counter<=0;
end
end
GO_STRAIGHT_SPECIAL_CASE_RIGHT_TWO:  
begin

no1<=4; no2<=SPEED;
counter<=counter+1;
if(l_data<100 && c_data<100 && r_data<100)
begin
state<=double_left_white_part_one;
counter<=0;
end
end



GO_STRAIGHT_SPECIAL_CASE_LEFT_ONE:   // Moves the bot right turn in node 12
begin

no1<=SPEED; no2<=SPEED;
counter<=counter+1;
if(counter>11000000)
begin
state<=GO_STRAIGHT_SPECIAL_CASE_LEFT_TWO;
counter<=0;
end
end
GO_STRAIGHT_SPECIAL_CASE_LEFT_TWO:  
begin

no1<=SPEED; no2<=4;
counter<=counter+1;
if(l_data<100 && c_data<100 && r_data<100)
begin
state<=double_right_white_part_one;
counter<=0;
end
end








DIRECTION_TO_MOVE:
begin
// Left_White=0; Left_Black=1; Right_White=2; Right_Black=3; Forward=4; Left_Left_White=5; Right_Right_White=6; Turn around = 7;  Special_node_left=8 ; Special_node= 9; 

if(array[0]==0 && array[1]==1 && array[2]==29)
dir<=2;
else if(array[0]==2 && array[1]==1 && array[2]==0)
dir<=3;
else if(array[0]==2 && array[1]==1 && array[2]==29)
dir<=4;
else if(array[0]==29 && array[1]==1 && array[2]==0)
dir<=1;
else if(array[0]==29 && array[1]==1 && array[2]==2)
dir<=4;
else if(array[0]==1 && array[1]==2 && array[2]==3)
dir<=0;
else if(array[0]==1 && array[1]==2 && array[2]==8)
dir<=2;
else if(array[0]==8 && array[1]==2 && array[2]==1)//  *
dir<=0;
else if(array[0]==8 && array[1]==2 && array[2]==3)
dir<=2;
else if(array[0]==3 && array[1]==2 && array[2]==1)
dir<=2;
else if(array[0]==3 && array[1]==2 && array[2]==8)
dir<=0;
else if(array[0]==2 && array[1]==3 && array[2]==4)
dir<=2;
else if(array[0]==2 && array[1]==3 && array[2]==28)
dir<=0;
else if(array[0]==4 && array[1]==3 && array[2]==2)
dir<=0;
else if(array[0]==4 && array[1]==3 && array[2]==28)
dir<=2;
else if(array[0]==28 && array[1]==3 && array[2]==2)//  **
dir<=2;
else if(array[0]==28 && array[1]==3 && array[2]==4)
dir<=0;
else if(array[0]==3 && array[1]==28 && array[2]==26) 
dir<=2;
else if(array[0]==3 && array[1]==28 && array[2]==29)//
dir<=0; //done till here
else if(array[0]==29 && array[1]==28 && array[2]==26)
dir<=0;
else if(array[0]==29 && array[1]==28 && array[2]==3)
dir<=2;
else if(array[0]==26 && array[1]==28 && array[2]==29)//
dir<=2;
else if(array[0]==26 && array[1]==28 && array[2]==3)
dir<=0;
else if(array[0]==28 && array[1]==29 && array[2]==1)
dir<=0;
else if(array[0]==28 && array[1]==29 && array[2]==20)//  *
dir<=2;
else if(array[0]==20 && array[1]==29 && array[2]==1)//
dir<=2;
else if(array[0]==20 && array[1]==29 && array[2]==28)//
dir<=0;
else if(array[0]==1 && array[1]==29 && array[2]==20)//
dir<=0;
else if(array[0]==1 && array[1]==29  && array[2]==28)
dir<=2;
else if(array[0]==25 && array[1]==26 && array[2]==27)
dir<=3;
else if(array[0]==25 && array[1]==26 && array[2]==28)
dir<=4;
else if(array[0]==27 && array[1]==26 && array[2]==25)
dir<=0;
else if(array[0]==27 && array[1]==26 && array[2]==28)
dir<=2;
else if(array[0]==28 && array[1]==26 && array[2]==25)//  **
dir<=4;
else if(array[0]==28 && array[1]==26  && array[2]==27)
dir<=1;
else if(array[0]==26 && array[1]==25  && array[2]==24)
dir<=4;
else if(array[0]==24 && array[1]==25  && array[2]==26)
dir<=4;
else if(array[0]==25 && array[1]==24 && array[2]==20)//
dir<=0;
else if(array[0]==20 && array[1]==24 && array[2]==25)//
dir<=2;
else if(array[0]==24 && array[1]==20 && array[2]==29)//
dir<=1;
else if(array[0]==24 && array[1]==20 && array[2]==21)
dir<=4;
else if(array[0]==24 && array[1]==20 && array[2]==19)
dir<=3;
else if(array[0]==29 && array[1]==20 && array[2]==24)
dir<=2;
else if(array[0]==29 && array[1]==20 && array[2]==19)
dir<=0;
else if(array[0]==29 && array[1]==20 && array[2]==21)
dir<=5;
else if(array[0]==21 && array[1]==20 && array[2]==19)
dir<=1;
else if(array[0]==21 && array[1]==20 && array[2]==24)
dir<=4;
else if(array[0]==21 && array[1]==20 && array[2]==29)
dir<=3;
else if(array[0]==19 && array[1]==20 && array[2]==24)
dir<=0;
else if(array[0]==19 && array[1]==20 && array[2]==29)
dir<=2;
else if(array[0]==19 && array[1]==20 && array[2]==21)
dir<=6;
else if(array[0]==22 && array[1]==21 && array[2]==20)
dir<=2;
else if(array[0]==22 && array[1]==21 && array[2]==23)
dir<=0;
else if(array[0]==20 && array[1]==21 && array[2]==22)
dir<=0;
else if(array[0]==20 && array[1]==21 && array[2]==23)
dir<=2;
else if(array[0]==23 && array[1]==21 && array[2]==20)
dir<=0;
else if(array[0]==23 && array[1]==21 && array[2]==22)
dir<=2;
else if(array[0]==array[2])
dir<=7;
// By sumeet
else if(array[0]==3 && array[1]==4 && array[2]==5)
dir<=3;
else if(array[0]==5 && array[1]==4 && array[2]==3)
dir<=0;
else if(array[0]==6 && array[1]==4 && array[2]==5)
dir<=1;
else if(array[0]==5 && array[1]==4 && array[2]==6)
dir<=2;
else if(array[0]==3 && array[1]==4 && array[2]==6)
dir<=4;
else if(array[0]==6 && array[1]==4 && array[2]==3)
dir<=4;
else if(array[0]==4 && array[1]==5 && array[2]==4)
dir<=7;
else if(array[0]==4 && array[1]==6 && array[2]==7)
dir<=4;
else if(array[0]==7 && array[1]==6 && array[2]==4)
dir<=4;
else if(array[0]==6 && array[1]==7 && array[2]==8)
dir<=2;
else if(array[0]==8 && array[1]==7 && array[2]==6)
dir<=0;
else if(array[0]==2 && array[1]==8 && array[2]==7)
dir<=0;
else if(array[0]==2 && array[1]==8 && array[2]==9)
dir<=6;
else if(array[0]==2 && array[1]==8 && array[2]==12)
dir<=2;
else if(array[0]==9 && array[1]==8 && array[2]==2)
dir<=1;
else if(array[0]==9 && array[1]==8 && array[2]==7)
dir<=4;
else if(array[0]==9 && array[1]==8 && array[2]==12)
dir<=3;
else if(array[0]==12 && array[1]==8 && array[2]==9)
dir<=5;
else if(array[0]==12 && array[1]==8 && array[2]==2)
dir<=0;
else if(array[0]==12 && array[1]==8 && array[2]==7)
dir<=2;
else if(array[0]==7 && array[1]==8 && array[2]==2)
dir<=3;
else if(array[0]==7 && array[1]==8 && array[2]==9)
dir<=4;
else if(array[0]==7 && array[1]==8 && array[2]==12)
dir<=1;
else if(array[0]==8 && array[1]==9 && array[2]==10)
dir<=2;
else if(array[0]==8 && array[1]==9 && array[2]==11)
dir<=0;
else if(array[0]==10 && array[1]==9 && array[2]==8)
dir<=0;
else if(array[0]==10 && array[1]==9 && array[2]==11)
dir<=2;
else if(array[0]==11 && array[1]==9 && array[2]==10)
dir<=0;
else if(array[0]==11 && array[1]==9 && array[2]==8)
dir<=2;
else if(array[0]==9 && array[1]==10 && array[2]==9)
dir<=7;
else if(array[0]==9 && array[1]==11 && array[2]==9)
dir<=7;
else if(array[0]==20 && array[1]==19 && array[2]==12)
dir<=0;
else if(array[0]==20 && array[1]==19 && array[2]==18)
dir<=2;
else if(array[0]==18 && array[1]==19 && array[2]==20)
dir<=1;
else if(array[0]==18 && array[1]==19 && array[2]==12)
dir<=4;
else if(array[0]==12 && array[1]==19 && array[2]==20)
dir<=8;//      SPECIAL
else if(array[0]==12 && array[1]==19 && array[2]==18)
dir<=4;
else if(array[0]==8 && array[1]==12 && array[2]==13)
dir<=0;
else if(array[0]==8 && array[1]==12 && array[2]==19)
dir<=2;
else if(array[0]==19 && array[1]==12 && array[2]==8)
dir<=9;//        SPECIAL
else if(array[0]==19 && array[1]==12 && array[2]==13)
dir<=4;
else if(array[0]==13 && array[1]==12 && array[2]==8)
dir<=6;
else if(array[0]==13 && array[1]==12 && array[2]==19)
dir<=4;
else if(array[0]==16 && array[1]==17 && array[2]==16)
dir<=7;
else if(array[0]==14 && array[1]==15 && array[2]==14)
dir<=7;
else if(array[0]==19 && array[1]==18 && array[2]==16)
dir<=0;
else if(array[0]==16 && array[1]==18 && array[2]==19)
dir<=2;
else if(array[0]==12 && array[1]==13 && array[2]==14)
dir<=2;
else if(array[0]==14 && array[1]==13 && array[2]==12)
dir<=0;
else if(array[0]==18 && array[1]==16 && array[2]==17)
dir<=0;
else if(array[0]==18 && array[1]==16 && array[2]==14)
dir<=4;
else if(array[0]==17 && array[1]==16 && array[2]==14)
dir<=0;
else if(array[0]==17 && array[1]==16 && array[2]==18)
dir<=2;
else if(array[0]==14 && array[1]==16 && array[2]==17)
dir<=3;
else if(array[0]==14 && array[1]==16 && array[2]==18)
dir<=4;
else if(array[0]==13 && array[1]==14 && array[2]==16)
dir<=4;
else if(array[0]==13 && array[1]==14 && array[2]==15)
dir<=3;
else if(array[0]==16 && array[1]==14 && array[2]==15)
dir<=1;
else if(array[0]==16 && array[1]==14 && array[2]==13)
dir<=4;
else if(array[0]==15 && array[1]==14 && array[2]==16)
dir<=2;
else if(array[0]==15 && array[1]==14 && array[2]==13)
dir<=0;
//ends by sumeet

state<=DIRECTION_TO_TURN_ARRAY_MAKER;
end


endcase
end


assign node = current_node;
assign next_node_w = next_node;
assign state_w = state;

assign seach_EU_w = searching_ESU_feedback_toggle;
assign seach_CU_w = searching_CSU_feedback_toggle;
assign seach_RU_w = searching_RSU_feedback_toggle;

assign reach_B1_w = reaching_to_B1_feedback_toggle;
assign reach_B2_w = reaching_to_B2_feedback_toggle;
assign reach_B3_w = reaching_to_B3_feedback_toggle;
assign reach_B4_w = reaching_to_B4_feedback_toggle;

assign reach_ESU1_w = reaching_to_ESU1_feedback_toggle;
assign reach_ESU2_w = reaching_to_ESU2_feedback_toggle;
assign reach_ESU3_w = reaching_to_ESU3_feedback_toggle;
assign reach_CSU1_w = reaching_to_CSU1_feedback_toggle;
assign reach_CSU2_w = reaching_to_CSU2_feedback_toggle;
assign reach_CSU3_w = reaching_to_CSU3_feedback_toggle;
assign reach_RSU1_w = reaching_to_RSU1_feedback_toggle;
assign reach_RSU2_w = reaching_to_RSU2_feedback_toggle;
assign reach_RSU3_w = reaching_to_RSU3_feedback_toggle;
assign reach_RSU4_w = reaching_to_RSU4_feedback_toggle;

assign  B1_supply_toggle_w = B1_supply_toggle;
assign  B2_supply_toggle_w = B2_supply_toggle;
assign  B3_supply_toggle_w = B3_supply_toggle;
assign  B4_supply_toggle_w = B4_supply_toggle;

assign ESU1_fixed_w = ESU1_fixed;
assign ESU2_fixed_w = ESU2_fixed;
assign ESU3_fixed_w = ESU3_fixed;

assign CSU1_fixed_w = CSU1_fixed;
assign CSU2_fixed_w = CSU2_fixed;
assign CSU3_fixed_w = CSU3_fixed;

assign RSU1_fixed_w = RSU1_fixed;
assign RSU2_fixed_w = RSU2_fixed;
assign RSU3_fixed_w = RSU3_fixed;
assign RSU4_fixed_w = RSU4_fixed;

assign ESU1_found_w = ESU1_found;
assign ESU2_found_w = ESU2_found;
assign ESU3_found_w = ESU3_found;

assign CSU1_found_w = CSU1_found;
assign CSU2_found_w = CSU2_found;
assign CSU3_found_w = CSU3_found;

assign RSU1_found_w = RSU1_found;
assign RSU2_found_w = RSU2_found;
assign RSU3_found_w = RSU3_found;
assign RSU4_found_w = RSU4_found;

assign em1_w = em1;
assign em2_w = em2;


endmodule