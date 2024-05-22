module Identify_fault(clk_50M,fault,node_wire,data, path0, fault_collected,pbm_recieved,block_picked,next_node_wire,data0_w,data1_w,
data2_w,data3_w,data4_w,data5_w,data6_w,data7_w,data8_w,data9_w,data10_w,data11_w,data12_w,data13_w,state_w,seach_EU_w,seach_CU_w,
seach_RU_w,reach_B1_w,reach_B2_w,reach_B3_w,reach_B4_w,reach_ESU1_w,reach_ESU2_w,reach_ESU3_w,reach_CSU1_w,reach_CSU2_w,reach_CSU3_w,
reach_RSU1_w,reach_RSU2_w,reach_RSU3_w,reach_RSU4_w,B1_supply_toggle_w,B2_supply_toggle_w,B3_supply_toggle_w,B4_supply_toggle_w,data_sent,
start_rcv,ESU1_fixed_w,ESU2_fixed_w,ESU3_fixed_w,CSU1_fixed_w,CSU2_fixed_w,CSU3_fixed_w,RSU1_fixed_w,RSU2_fixed_w,RSU3_fixed_w,
RSU4_fixed_w,ESU1_found_w,ESU2_found_w,ESU3_found_w,CSU1_found_w,CSU2_found_w,CSU3_found_w,RSU1_found_w,RSU2_found_w,RSU3_found_w,
RSU4_found_w);

    input clk_50M;
    input fault;
    input [5:0] node_wire;
    input [5:0] next_node_wire;
	output reg [7:0] data;   
	
	input path0;
	input fault_collected;
	input pbm_recieved;
	input block_picked;
	input [5:0] state_w;
 

	input B1_supply_toggle_w;
	input B2_supply_toggle_w;
	input B3_supply_toggle_w;
	input B4_supply_toggle_w;

	input data0_w;
	input data1_w;
	input data2_w;
	input data3_w;
	input data4_w;
	input data5_w;
	input data6_w;
	input data7_w;
	input data8_w;
	input data9_w;
	input data10_w;
	input data11_w;
	input data12_w;
	input data13_w;

	input seach_EU_w;
    input seach_CU_w;
    input seach_RU_w;
    input reach_B1_w;
    input reach_B2_w;
    input reach_B3_w;
    input reach_B4_w;
  
    input reach_ESU1_w;
    input reach_ESU2_w;
    input reach_ESU3_w;
    input reach_CSU1_w;
    input reach_CSU2_w;
    input reach_CSU3_w;
    input reach_RSU1_w;
    input reach_RSU2_w;
    input reach_RSU3_w;
    input reach_RSU4_w;
	 
	 input data_sent;
	 output reg start_rcv;

	input ESU1_fixed_w;
    input ESU2_fixed_w;
    input ESU3_fixed_w;

    input CSU1_fixed_w;
    input CSU2_fixed_w;
    input CSU3_fixed_w;

    input RSU1_fixed_w;
    input RSU2_fixed_w;
    input RSU3_fixed_w;
    input RSU4_fixed_w;

    input ESU1_found_w;
    input ESU2_found_w;
    input ESU3_found_w;

    input CSU1_found_w;
    input CSU2_found_w;
    input CSU3_found_w;

    input RSU1_found_w;
    input RSU2_found_w;
    input RSU3_found_w;
    input RSU4_found_w;


    localparam normal = 1;
	localparam send_msg_FIM  = 2;
	localparam send_msg_BPM  = 3;
	localparam send_msg_BDM  = 4;
	localparam start = 0;
	localparam loop = 5;
	localparam delay = 6;

		localparam HUB = 53;
	    localparam message1 = 7;
        localparam message2 = 8;
		localparam message3 = 9;
		localparam message4 = 10;
		localparam message5 = 11;
		localparam message6 = 12;
		localparam message7 = 13;
		localparam message8 = 14;
		localparam message9 = 15;
		localparam message10 = 16;
		localparam end_message1 = 17;
		localparam message11 = 18;
		localparam message12 = 19;
		localparam message13 = 20;
	    localparam message14 = 21;
        localparam message15 = 22;
		localparam message16 = 23;
		localparam message17 = 24;
		localparam message18 = 25;
		localparam message19 = 26;
		localparam message20 = 27;
		localparam message21 = 28;
		localparam message22 = 29;
		localparam message23 = 30;
		localparam end_message2 = 31;
		localparam message24 = 32;
		localparam message25 = 33;
		localparam message26 = 34;
		localparam message27 = 35;
		localparam message28 = 36;
		localparam message29 = 37;
		localparam message30 = 38;
		localparam message31 = 39;
		localparam message32 = 40;
		localparam message33 = 41;
		localparam message34 = 42;
		localparam end_message3 = 43;
		localparam message35 = 44;
		localparam message36 = 45;
		localparam message37 = 46;
		localparam message38 = 47;
		localparam message39 = 48;
		localparam message40 = 49;
		

		localparam FIM_s = 50;
		localparam BPM_s = 51;
		localparam BDM_s = 52;

		localparam end_state = 54;


reg control_toggle=0;

reg end_toggle=0;


reg [7:0] FIM[15:0];
reg [7:0] BPM[15:0];
reg [7:0] BDM[15:0];
reg [7:0] m4[15:0];

reg led1b=0;
reg led2b=0;
reg led3b=0;

    reg [7:0] prev_node_wire;
	reg [1:0] trigger;
	reg prev_fault;
	 reg [7:0] state =0;

    reg [31:0] counter = 0;
	    reg [31:0] counter2 = 0;
   reg [7:0] xd =0;
   reg [31:0] count;
   reg [7:0] node_wire_count;
   reg message_sent =0;
   reg fim_sent = 0;


	reg FIM_EU_toggle=0;
	reg FIM_CU_toggle=0;
	reg FIM_RU_toggle=0;


	reg B1_msg_toggle=0;
	reg B2_msg_toggle=0;
	reg B3_msg_toggle=0;
	reg B4_msg_toggle=0;

	reg BDM_ESU1_B1_toggle=0;
	reg BDM_ESU1_B2_toggle=0;
	reg BDM_ESU1_B3_toggle=0;
	reg BDM_ESU1_B4_toggle=0;

	reg BDM_ESU2_B1_toggle=0;
	reg BDM_ESU2_B2_toggle=0;
	reg BDM_ESU2_B3_toggle=0;
	reg BDM_ESU2_B4_toggle=0;

	reg BDM_ESU3_B1_toggle=0;
	reg BDM_ESU3_B2_toggle=0;
	reg BDM_ESU3_B3_toggle=0;
	reg BDM_ESU3_B4_toggle=0;

	reg BDM_CSU1_B1_toggle=0;
	reg BDM_CSU1_B2_toggle=0;
	reg BDM_CSU1_B3_toggle=0;
	reg BDM_CSU1_B4_toggle=0;

	reg BDM_CSU2_B1_toggle=0;
	reg BDM_CSU2_B2_toggle=0;
	reg BDM_CSU2_B3_toggle=0;
	reg BDM_CSU2_B4_toggle=0;

	reg BDM_CSU3_B1_toggle=0;
	reg BDM_CSU3_B2_toggle=0;
	reg BDM_CSU3_B3_toggle=0;
	reg BDM_CSU3_B4_toggle=0;

	reg BDM_RSU1_B1_toggle=0;
	reg BDM_RSU1_B2_toggle=0;
	reg BDM_RSU1_B3_toggle=0;
	reg BDM_RSU1_B4_toggle=0;

	reg BDM_RSU2_B1_toggle=0;
	reg BDM_RSU2_B2_toggle=0;
	reg BDM_RSU2_B3_toggle=0;
	reg BDM_RSU2_B4_toggle=0;

	reg BDM_RSU3_B1_toggle=0;
	reg BDM_RSU3_B2_toggle=0;
	reg BDM_RSU3_B3_toggle=0;
	reg BDM_RSU3_B4_toggle=0;

	reg BDM_RSU4_B1_toggle=0;
	reg BDM_RSU4_B2_toggle=0;
	reg BDM_RSU4_B3_toggle=0;
	reg BDM_RSU4_B4_toggle=0;


	reg fim_after_bdm=0;
	reg pbm_after_fim=0;
	reg bdm_after_pbm=0;


	reg esu1_done=0;
	reg esu2_done=0;
	reg esu3_done=0;

	reg csu1_done=0;
	reg csu2_done=0;
	reg csu3_done=0;

	reg rsu1_done=0;
	reg rsu2_done=0;
	reg rsu3_done=0;
	reg rsu4_done=0;
	


	reg bdm_esu1_done=0;
	reg bdm_esu2_done=0;
	reg bdm_esu3_done=0;
    
	reg bdm_csu1_done=0;
	reg bdm_csu2_done=0;
	reg bdm_csu3_done=0;

	reg bdm_rsu1_done=0;
	reg bdm_rsu2_done=0;
	reg bdm_rsu3_done=0;
	reg bdm_rsu4_done=0;


	 initial begin

				trigger<=1'b0;
				prev_fault<=1'b0;
				state <= start;
				count <= 0;
				node_wire_count <= 0;
				
	end
	 
	 
	 always @(posedge clk_50M) begin

		FIM[0] <="F";
		FIM[1] <="I";
		FIM[2] <="M";
		FIM[3] <="-";
		// FIM[4] <="E";
		FIM[5] <="S";
		FIM[6] <="U";
		// FIM[7] <="0";
		FIM[8] <="-";
		FIM[9] <="#";


///////////////////////////////////////
			BPM[0] <="B";
		    BPM[1] <="P";
		    BPM[2] <="M";
			BPM[3] <="-";
			BPM[4] <="S";
			BPM[5] <="U";
			BPM[6] <="-";
			BPM[7] <="B";
				// BPM[8] <="0";
			BPM[9] <="-";
			BPM[10] <="#";
///////////////////////////////////////////
	    BDM[0] <="B";
		BDM[1] <="D";
		BDM[2] <="M";
		BDM[3] <="-";
		// BDM[4] <="E";
		BDM[5] <="S";
		BDM[6] <="U";
		// BDM[7] <="1";
		BDM[8] <="-";
		BDM[9] <="B";
		// BDM[10] <="1";
		BDM[11] <="-";
		BDM[12] <="#";


	if(((node_wire == 28) && (next_node_wire == 29)) )begin
	 FIM[7]<="3";
	 FIM[4]<="E";
	 BDM[7]<="3";
	 BDM[4]<="E";
	 end
	 else if(((node_wire == 27) && (next_node_wire == 26)) )begin
      FIM[7]<="2";
	  FIM[4]<="E";
	  BDM[7]<="2";
	  BDM[4]<="E";
	 end
	else if((node_wire == 24) && (next_node_wire == 25)) begin
      FIM[7]<="1";
	  FIM[4]<="E";
	  BDM[7]<="1";
	  BDM[4]<="E";
	 end	
	else if(((node_wire == 2) && (next_node_wire == 3)) )begin
      FIM[7]<="1";
	  FIM[4]<="C";
	  BDM[7]<="1";
	  BDM[4]<="C";
	 end	
	else if(((node_wire == 4) && (next_node_wire == 5)) )begin
      FIM[7]<="2";
	  FIM[4]<="C";
	  BDM[7]<="2";
	  BDM[4]<="C";
	 end	
	else if(((node_wire == 6) && (next_node_wire == 7)) )begin
      FIM[7]<="3";
	  FIM[4]<="C";
	  BDM[7]<="3";
	  BDM[4]<="C";
	 end	
	else if(((node_wire == 18) && (next_node_wire == 19)) )begin
      FIM[7]<="1";
	  FIM[4]<="R";
	  BDM[7]<="1";
	  BDM[4]<="R";
	 end	
	else if(((node_wire == 16) && (next_node_wire == 17)) )begin
      FIM[7]<="2";
	  FIM[4]<="R";
	  BDM[7]<="2";
	  BDM[4]<="R";
	 end	
	else if(((node_wire == 15) && (next_node_wire == 14)) )begin
      FIM[7]<="3";
	  FIM[4]<="R";
	  BDM[7]<="3";
	  BDM[4]<="R";
	 end	
	else if(((node_wire == 12) && (next_node_wire == 13)) )begin
      FIM[7]<="4";
	  FIM[4]<="R";
	  BDM[7]<="4";
	  BDM[4]<="R";
	 end	

			///////////////////////////////////////////////////////////////////


	if((node_wire == 21) && (next_node_wire == 22)) begin
	 BPM[8]<="1";
	 end
	 else if((node_wire == 21) && (next_node_wire == 23))begin
      BPM[8]<="3";
	 end
	else if((node_wire == 9) && (next_node_wire == 10)) begin
      BPM[8]<="2";
	 end	
	else if((node_wire == 9) && (next_node_wire == 11)) begin
      BPM[8]<="4";
	 end	


	 if(B1_supply_toggle_w==1 ) begin
	 BDM[10]<="1";
	 end
	 else if(B2_supply_toggle_w==1) begin
	 BDM[10]<="2";
	 end
	 if(B3_supply_toggle_w==1) begin
	 BDM[10]<="3";
	 end
	 else if(B4_supply_toggle_w==1) begin
	 BDM[10]<="4";
	 end

	if(data0_w =="P" & data8_w =="1" & node_wire==24 & next_node_wire==25)
	begin
      BDM_ESU1_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="1" & node_wire==27 & next_node_wire==26)
	begin
      BDM_ESU2_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="1" & node_wire==28 & next_node_wire==29)
	begin
      BDM_ESU3_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="1" & node_wire==2 & next_node_wire==3)
	begin
      BDM_CSU1_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="1" & node_wire==4 & next_node_wire==5)
	begin
      BDM_CSU2_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="1" & node_wire==6 & next_node_wire==7)
	begin
      BDM_CSU3_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="1" & node_wire==12 & next_node_wire==13)
	begin
      BDM_RSU4_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="1" & node_wire==15 & next_node_wire==16)
	begin
      BDM_RSU3_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="1" & node_wire==16 & next_node_wire==17)
	begin
      BDM_RSU2_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="1" & node_wire==18 & next_node_wire==19)
	begin
      BDM_RSU1_B1_toggle<=1;
	end

	else if(data0_w =="P" & data8_w =="2" & node_wire==24 & next_node_wire==25)
	begin
      BDM_ESU1_B2_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="2" & node_wire==27 & next_node_wire==26)
	begin
      BDM_ESU2_B2_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="2" & node_wire==28 & next_node_wire==29)
	begin
      BDM_ESU3_B2_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="2" & node_wire==2 & next_node_wire==3)
	begin
      BDM_CSU1_B2_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="2" & node_wire==4 & next_node_wire==5)
	begin
      BDM_CSU2_B2_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="2" & node_wire==6 & next_node_wire==7)
	begin
      BDM_CSU3_B2_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="2" & node_wire==12 & next_node_wire==13)
	begin
      BDM_RSU4_B2_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="2" & node_wire==15 & next_node_wire==16)
	begin
      BDM_RSU3_B2_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="2" & node_wire==16 & next_node_wire==17)
	begin
      BDM_RSU2_B2_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="2" & node_wire==18 & next_node_wire==19)
	begin
      BDM_RSU1_B2_toggle<=1;
	end

	else if(data0_w =="P" & data8_w =="3" & node_wire==24 & next_node_wire==25)
	begin
      BDM_ESU1_B1_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="3" & node_wire==27 & next_node_wire==26)
	begin
      BDM_ESU2_B3_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="3" & node_wire==28 & next_node_wire==29)
	begin
      BDM_ESU3_B3_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="3" & node_wire==2 & next_node_wire==3)
	begin
      BDM_CSU1_B3_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="3" & node_wire==4 & next_node_wire==5)
	begin
      BDM_CSU2_B3_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="3" & node_wire==6 & next_node_wire==7)
	begin
      BDM_CSU3_B3_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="3" & node_wire==12 & next_node_wire==13)
	begin
      BDM_RSU4_B3_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="3" & node_wire==15 & next_node_wire==16)
	begin
      BDM_RSU3_B3_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="3" & node_wire==16 & next_node_wire==17)
	begin
      BDM_RSU2_B3_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="3" & node_wire==18 & next_node_wire==19)
	begin
      BDM_RSU1_B3_toggle<=1;
	end

	else if(data0_w =="P" & data8_w =="4" & node_wire==24 & next_node_wire==25)
	begin
      BDM_ESU1_B4_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="4" & node_wire==27 & next_node_wire==26)
	begin
      BDM_ESU2_B4_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="4" & node_wire==28 & next_node_wire==29)
	begin
      BDM_ESU3_B4_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="4" & node_wire==2 & next_node_wire==3)
	begin
      BDM_CSU1_B4_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="4" & node_wire==4 & next_node_wire==5)
	begin
      BDM_CSU2_B4_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="4" & node_wire==6 & next_node_wire==7)
	begin
      BDM_CSU3_B4_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="4" & node_wire==12 & next_node_wire==13)
	begin
      BDM_RSU4_B4_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="4" & node_wire==15 & next_node_wire==16)
	begin
      BDM_RSU3_B4_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="4" & node_wire==16 & next_node_wire==17)
	begin
      BDM_RSU2_B4_toggle<=1;
	end
	else if(data0_w =="P" & data8_w =="4" & node_wire==18 & next_node_wire==19)
	begin
      BDM_RSU1_B4_toggle<=1;
	end



	if(BDM_ESU1_B1_toggle==1 & state_w==41 & node_wire==24 & next_node_wire==25)
	begin
      BDM[4] <="E"; BDM[10] <="1";
	end
	else if(BDM_ESU2_B1_toggle==1 & state_w==41 & node_wire==27 & next_node_wire==26)
	begin
      BDM[4] <="E"; BDM[10] <="1";
	end
	else if(BDM_ESU3_B1_toggle==1 & state_w==41 & node_wire==28 & next_node_wire==29)
	begin
      BDM[4] <="E"; BDM[10] <="1";
	end
	else if(BDM_CSU1_B1_toggle==1 & state_w==41 & node_wire==2 & next_node_wire==3)
	begin
      BDM[4] <="C"; BDM[10] <="1";
	end
	else if(BDM_CSU2_B1_toggle==1 & state_w==41 & node_wire==4 & next_node_wire==5)
	begin
      BDM[4] <="C"; BDM[10] <="1";
	end
	else if(BDM_CSU3_B1_toggle==1 & state_w==41 & node_wire==6 & next_node_wire==7)
	begin
      BDM[4] <="C"; BDM[10] <="1";
	end
	else if(BDM_RSU4_B1_toggle==1 & state_w==41 & node_wire==12 & next_node_wire==13)
	begin
      BDM[4] <="R"; BDM[10] <="1";
	end
	else if(BDM_RSU3_B1_toggle==1 & state_w==41 & node_wire==15 & next_node_wire==16)
	begin
      BDM[4] <="R"; BDM[10] <="1";
	end
	else if(BDM_RSU2_B1_toggle==1 & state_w==41 & node_wire==16 & next_node_wire==17)
	begin
      BDM[4] <="R"; BDM[10] <="1";
	end
	else if(BDM_RSU1_B1_toggle==1 & state_w==41 & node_wire==18 & next_node_wire==19)
	begin
      BDM[4] <="R"; BDM[10] <="1";
	end

	else if(BDM_ESU1_B2_toggle==1 & state_w==41 & node_wire==24 & next_node_wire==25)
	begin
      BDM[4] <="E"; BDM[10] <="2";
	end
	else if(BDM_ESU2_B2_toggle==1 & state_w==41 & node_wire==27 & next_node_wire==26)
	begin
      BDM[4] <="E"; BDM[10] <="2";
	end
	else if(BDM_ESU3_B2_toggle==1 & state_w==41 & node_wire==28 & next_node_wire==29)
	begin
      BDM[4] <="E"; BDM[10] <="2";
	end
	else if(BDM_CSU1_B2_toggle==1 & state_w==41 & node_wire==2 & next_node_wire==3)
	begin
      BDM[4] <="C"; BDM[10] <="2";
	end
	else if(BDM_CSU2_B2_toggle==1 & state_w==41 & node_wire==4 & next_node_wire==5)
	begin
      BDM[4] <="C"; BDM[10] <="2";
	end
	else if(BDM_CSU3_B2_toggle==1 & state_w==41 & node_wire==6 & next_node_wire==7)
	begin
      BDM[4] <="C"; BDM[10] <="2";
	end
	else if(BDM_RSU4_B2_toggle==1 & state_w==41 & node_wire==12 & next_node_wire==13)
	begin
      BDM[4] <="R"; BDM[10] <="2";
	end
	else if(BDM_RSU3_B2_toggle==1 & state_w==41 & node_wire==15 & next_node_wire==16)
	begin
      BDM[4] <="R"; BDM[10] <="2";
	end
	else if(BDM_RSU2_B2_toggle==1 & state_w==41 & node_wire==16 & next_node_wire==17)
	begin
      BDM[4] <="R"; BDM[10] <="2";
	end
	else if(BDM_RSU1_B2_toggle==1 & state_w==41 & node_wire==18 & next_node_wire==19)
	begin
      BDM[4] <="R"; BDM[10] <="2";
	end

	else if(BDM_ESU1_B3_toggle==1 & state_w==41 & node_wire==24 & next_node_wire==25)
	begin
      BDM[4] <="E"; BDM[10] <="3";
	end
	else if(BDM_ESU2_B3_toggle==1 & state_w==41 & node_wire==27 & next_node_wire==26)
	begin
      BDM[4] <="E"; BDM[10] <="3";
	end
	else if(BDM_ESU3_B3_toggle==1 & state_w==41 & node_wire==28 & next_node_wire==29)
	begin
      BDM[4] <="E"; BDM[10] <="3";
	end
	else if(BDM_CSU1_B3_toggle==1 & state_w==41 & node_wire==2 & next_node_wire==3)
	begin
      BDM[4] <="C"; BDM[10] <="3";
	end
	else if(BDM_CSU2_B3_toggle==1 & state_w==41 & node_wire==4 & next_node_wire==5)
	begin
      BDM[4] <="C"; BDM[10] <="3";
	end
	else if(BDM_CSU3_B3_toggle==1 & state_w==41 & node_wire==6 & next_node_wire==7)
	begin
      BDM[4] <="C"; BDM[10] <="3";
	end
	else if(BDM_RSU4_B3_toggle==1 & state_w==41 & node_wire==12 & next_node_wire==13)
	begin
      BDM[4] <="R"; BDM[10] <="3";
	end
	else if(BDM_RSU3_B3_toggle==1 & state_w==41 & node_wire==15 & next_node_wire==16)
	begin
      BDM[4] <="R"; BDM[10] <="3";
	end
	else if(BDM_RSU2_B3_toggle==1 & state_w==41 & node_wire==16 & next_node_wire==17)
	begin
      BDM[4] <="R"; BDM[10] <="3";
	end
	else if(BDM_RSU1_B3_toggle==1 & state_w==41 & node_wire==18 & next_node_wire==19)
	begin
      BDM[4] <="R"; BDM[10] <="3";
	end

	else if(BDM_ESU1_B4_toggle==1 & state_w==41 & node_wire==24 & next_node_wire==25)
	begin
      BDM[4] <="E"; BDM[10] <="4";
	end
	else if(BDM_ESU2_B4_toggle==1 & state_w==41 & node_wire==27 & next_node_wire==26)
	begin
      BDM[4] <="E"; BDM[10] <="4";
	end
	else if(BDM_ESU3_B4_toggle==1 & state_w==41 & node_wire==28 & next_node_wire==29)
	begin
      BDM[4] <="E"; BDM[10] <="4";
	end
	else if(BDM_CSU1_B4_toggle==1 & state_w==41 & node_wire==2 & next_node_wire==3)
	begin
      BDM[4] <="C"; BDM[10] <="4";
	end
	else if(BDM_CSU2_B4_toggle==1 & state_w==41 & node_wire==4 & next_node_wire==5)
	begin
      BDM[4] <="C"; BDM[10] <="4";
	end
	else if(BDM_CSU3_B4_toggle==1 & state_w==41 & node_wire==6 & next_node_wire==7)
	begin
      BDM[4] <="C"; BDM[10] <="4";
	end
	else if(BDM_RSU4_B4_toggle==1 & state_w==41 & node_wire==12 & next_node_wire==13)
	begin
      BDM[4] <="R"; BDM[10] <="4";
	end
	else if(BDM_RSU3_B4_toggle==1 & state_w==41 & node_wire==15 & next_node_wire==16)
	begin
      BDM[4] <="R"; BDM[10] <="4";
	end
	else if(BDM_RSU2_B4_toggle==1 & state_w==41 & node_wire==16 & next_node_wire==17)
	begin
      BDM[4] <="R"; BDM[10] <="4";
	end
	else if(BDM_RSU1_B4_toggle==1 & state_w==41 & node_wire==18 & next_node_wire==19)
	begin
      BDM[4] <="R"; BDM[10] <="4";
	end

////////////////////////////////////////////////////////////////////

		if(fault==1 & (seach_EU_w==1 || seach_CU_w==1 || seach_RU_w==1) & ((CSU3_fixed_w==0 & node_wire==6 & csu3_done==0) || (CSU1_fixed_w==0 & node_wire==2 & csu1_done==0) || (CSU2_fixed_w==0 & node_wire==4 & csu2_done==0) || ( node_wire==24 & esu1_done==0) || ( node_wire==27 & esu2_done==0) || ( node_wire==28 & esu3_done==0) || (node_wire==18 & rsu1_done==0) || ( node_wire==16 & rsu2_done==0) || ( node_wire==15 & rsu3_done==0) || (node_wire==12 & rsu4_done==0)) & fim_after_bdm==0) begin
			pbm_after_fim<=0;
			fim_after_bdm <= 1;
			state <=  FIM_s;

		end
		else if(fault==1 & (node_wire==21 | node_wire==22 | node_wire==9 | node_wire==10 | node_wire==23  | node_wire==11 ) & pbm_after_fim==0) begin
			bdm_after_pbm<=0;
			pbm_after_fim <= 1;
			state <=  BPM_s;

		end
 		else if(fault==1 & (reach_CSU3_w==1 | reach_CSU2_w==1 | reach_CSU1_w==1 | reach_ESU1_w==1 | reach_ESU2_w==1 | reach_ESU3_w==1 | reach_RSU1_w==1 | reach_RSU2_w==1 | reach_RSU3_w==1 | reach_RSU4_w==1 ) & ( (node_wire==6 & CSU3_fixed_w==0 & bdm_csu3_done==0 ) | (node_wire==4 & CSU2_fixed_w==0 & bdm_csu2_done==0 ) | (node_wire==2 & CSU1_fixed_w==0 & bdm_csu1_done==0 )  | (node_wire==24 & ESU1_fixed_w==0 & bdm_esu1_done==0 )  | (node_wire==27 & ESU2_fixed_w==0 & bdm_esu2_done==0 ) | (node_wire==28 & ESU3_fixed_w==0 & bdm_esu3_done==0 )  | (node_wire==18 & RSU1_fixed_w==0 & bdm_rsu1_done==0 )  | (node_wire==16 & RSU2_fixed_w==0 & bdm_rsu2_done==0 )  | (node_wire==15 & RSU3_fixed_w==0 & bdm_rsu3_done==0 )  | (node_wire==12 & RSU4_fixed_w==0 & bdm_rsu4_done==0 )) & bdm_after_pbm==0) begin
			fim_after_bdm<=0;
			bdm_after_pbm<= 1;
			state <=  BDM_s;
		end

		if(state_w==18 & end_toggle==0) begin
			state <= end_state;
		    end_toggle<=1;
		end

		
/////////////////////////////////////////////////////////////////////////
		case(state) 


		FIM_s: begin
					

					if(node_wire==24) begin
						esu1_done <= 1;
					end 
					else if(node_wire==27) begin
						esu2_done <= 1;
					end 
					else if(node_wire==28) begin
						esu3_done <= 1;
					end 
					else if(node_wire==2) begin
						csu1_done <= 1;
					end 
					else if(node_wire==4) begin
						csu2_done <= 1;
					end 
					else if(node_wire==6) begin
						csu3_done <= 1;
					end 
					else if(node_wire==18) begin
						rsu1_done <= 1;
					end 
					else if(node_wire==16) begin
						rsu2_done <= 1;
					end 
					else if(node_wire==15) begin
						rsu3_done <= 1;
					end
					else if(node_wire==12) begin
						rsu4_done <= 1;
					end 


					if(counter < 2000000) begin
						counter <= counter +1;
					end
					else begin
						counter <= 0;
					state <= message1;
					end


		end

		BPM_s : begin
				
					if(counter < 2000000) begin
						counter <= counter +1;
					end
					else begin
						counter <= 0;
					state <= message11;
					end
				
		end

		BDM_s: begin
			if(node_wire==24 | node_wire==27 | node_wire== 28) begin
			
			end

					if(node_wire==24) begin
						bdm_esu1_done <= 1;
					end 
					else if(node_wire==27) begin
						bdm_esu2_done <= 1;
					end 
					else if(node_wire==28) begin
						bdm_esu3_done <= 1;
					end
					else if(node_wire==2) begin
						bdm_csu1_done <= 1;
					end
					else if(node_wire==4) begin
						bdm_csu2_done <= 1;
					end
					else if(node_wire==6) begin
						bdm_csu3_done <= 1;
					end
					else if(node_wire==18) begin
						bdm_rsu1_done <= 1;
					end
					else if(node_wire==16) begin
						bdm_rsu2_done <= 1;
					end
					else if(node_wire==15) begin
						bdm_rsu3_done <= 1;
					end
					else if(node_wire==12) begin
						bdm_rsu4_done <= 1;
					end
	


					if(counter < 2000000) begin
						counter <= counter +1;
					end
					else begin
						counter <= 0;
					state <= message22;
					end

		end

		end_state : begin
			if(counter < 2000000) begin
						counter <= counter +1;
					end
					else begin
						counter <= 0;
					state <= message35;
					end
		end


		message1 : begin
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[0];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
			state<= message2;
		end
		end

		message2 : begin		 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[1];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message3;
		end
		end

		message3 : begin					 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[2];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message4;
		end
		end

		message4 : begin			 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[3];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message5;
		end
		end

		message5 : begin			 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[4];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message6;
		end
		end

		message6 : begin			 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[5];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message7;
		end
		end

		message7 : begin			 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[6];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message8;
		end
		end

		message8 : begin			 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[7];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message9;
		end
		end
		message9 : begin
		 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[8];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message10;
		end
		end
		message10 : begin
		 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= FIM[9];
		end
		else if(data_sent==1) begin
			data<= 0;
		start_rcv <= 0;
		state <= end_message1;
		end
		end

	    end_message1 : begin

	    end



///////////////////////////////////////////MSG_1 ENDS////////////////////////////////////////


		message11 : begin

	
		
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[0];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message12;
		end
		end


		message12 : begin

			 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[1];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message13;
		end
		end
		message13 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[2];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message14;
		end
		end
	


		message14 : begin

					 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[3];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message15;
		end
		end
		message15 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[4];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message16;
		end
		end
		message16 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[5];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message17;
		end
		end
	


		message17 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[6];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message18;
		end
		end



		message18 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[7];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message19;
		end
		end
	



		message19 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[8];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message20;
		end
		end



		message20 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[9];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message21;
		end
		end


		message21 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BPM[10];
		end
		else if(data_sent==1) begin
			data<= 0;
		start_rcv <= 0;
		state<= end_message2;
		end
		end

		end_message2: begin

		end

///////////////////////////////////////////MSG_2 ENDS////////////////////////////////////////
		
	
		message22 : begin

		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[0];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
			state<= message23;
		end
		end
	

		message23 : begin

		 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[1];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message24;
		end
		end


		message24 : begin

			 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[2];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message25;
		end
		end
	


		message25 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[3];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message26;
		end
		end




		message26 : begin

					 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[4];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message27;
		end
		end
		



		message27 : begin
	 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[5];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message28;
		end
		end
	


		message28 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[6];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message29;
		end
		end
	


		message29 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[7];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message30;
		end
		end




		message30 : begin
		 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[8];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message31;
		end
		end
	


		message31 : begin

			 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[9];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message32;
		end
		end
	

		message32 : begin

					 
		if(data_sent==0)
		begin


		start_rcv <= 1;
		data<= BDM[10];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message33;
		end
		end


		message33 : begin

				 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[11];
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message34;
		end
		end


		message34 : begin

					 
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= BDM[12];
		end
		else if(data_sent==1) begin
			data<= 0;
		start_rcv <= 0;
		state<= end_message3;
		end
		end

		end_message3: begin

		end

		message35 : begin
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= "E";
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message36;
		end
		end

		message36 : begin
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= "N";
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message37;
		end
		end

		message37 : begin
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= "D";
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message38;
		end
		end

		message38 : begin
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= "-";
		end
		else if(data_sent==1) begin
		start_rcv <= 0;
		state<= message39;
		end
		end

		message39 : begin
		if(data_sent==0)
		begin
		start_rcv <= 1;
		data<= "#";
		end
		else if(data_sent==1) begin
		data<=0;
		start_rcv <= 0;
		state<= message40;
		end
		end

		message40 : begin

		end


	endcase
	 end

endmodule