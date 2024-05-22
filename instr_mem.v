/* 
▪ * Team Id: eYRC#AB#3265
▪ * Author List: Md Faizan, Sudhanshu Ranjan, Sumit Saroj
▪ * Filename:instr_mem
▪ * Theme: Astro Tinker Bot 
▪ * Functions:instr_mem
▪ * Global Variables: None
▪ */

// instr_mem.v - instruction memory for single-cycle RISC-V CPU

module instr_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 512) (
    input       reset2,
    input       [ADDR_WIDTH-1:0] instr_addr,
    output      [DATA_WIDTH-1:0] instr
);

// array of 64 32-bit words or instructions
reg [DATA_WIDTH-1:0] instr_ram [0:MEM_SIZE-1];

initial begin
    $readmemh("program_dump.hex", instr_ram);
end

// word-aligned memory access
// combinational read logic
assign instr = ((reset2==0) ? instr_ram[instr_addr[31:2]] : 32'b0 );
assign instr = instr_ram[instr_addr[31:2]] ;
endmodule


// module instr_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 512) (
//     input       [ADDR_WIDTH-1:0] instr_addr,
//     output      [DATA_WIDTH-1:0] instr
// );

// // array of 64 32-bit words or instructions
// reg [DATA_WIDTH-1:0] instr_ram [0:MEM_SIZE-1];

// initial begin
//     instr_ram[0] = 32'h02000117;
//     instr_ram[1] = 32'h10010113;
//     instr_ram[2] = 32'h02000197;
//     instr_ram[3] = 32'h7F818193;
//     instr_ram[4] = 32'h02000517;
//     instr_ram[5] = 32'hFF050513;
//     instr_ram[6] = 32'h4A800593;
//     instr_ram[7] = 32'h00000613;
//     instr_ram[8] = 32'h444000EF;
//     instr_ram[9] = 32'h02000517;
//     instr_ram[10] = 32'hFDC50513;
//     instr_ram[11] = 32'h00000593;
//     instr_ram[12] = 32'h00000613;
//     instr_ram[13] = 32'h454000EF;
//     instr_ram[14] = 32'h02000517;
//     instr_ram[15] = 32'hFC850513;
//     instr_ram[16] = 32'h41C000EF;
//     instr_ram[17] = 32'h00000513;
//     instr_ram[18] = 32'h00000593;
//     instr_ram[19] = 32'h008000EF;
//     instr_ram[20] = 32'h0000006F;
//     instr_ram[21] = 32'hFF010113;
//     instr_ram[22] = 32'h00812423;
//     instr_ram[23] = 32'h00112623;
//     instr_ram[24] = 32'h00912223;
//     instr_ram[25] = 32'h020007B7;
//     instr_ram[26] = 32'h0007A823;
//     instr_ram[27] = 32'h02000437;
//     instr_ram[28] = 32'h01D00713;
//     instr_ram[29] = 32'h01042783;
//     instr_ram[30] = 32'h28F75463;
//     instr_ram[31] = 32'h00100593;
//     instr_ram[32] = 32'h00000513;
//     instr_ram[33] = 32'h398000EF;
//     instr_ram[34] = 32'h00200593;
//     instr_ram[35] = 32'h00100513;
//     instr_ram[36] = 32'h38C000EF;
//     instr_ram[37] = 32'h01D00593;
//     instr_ram[38] = 32'h00100513;
//     instr_ram[39] = 32'h380000EF;
//     instr_ram[40] = 32'h00300593;
//     instr_ram[41] = 32'h00200513;
//     instr_ram[42] = 32'h374000EF;
//     instr_ram[43] = 32'h00800593;
//     instr_ram[44] = 32'h00200513;
//     instr_ram[45] = 32'h368000EF;
//     instr_ram[46] = 32'h00400593;
//     instr_ram[47] = 32'h00300513;
//     instr_ram[48] = 32'h35C000EF;
//     instr_ram[49] = 32'h01C00593;
//     instr_ram[50] = 32'h00300513;
//     instr_ram[51] = 32'h350000EF;
//     instr_ram[52] = 32'h00500593;
//     instr_ram[53] = 32'h00400513;
//     instr_ram[54] = 32'h344000EF;
//     instr_ram[55] = 32'h00600593;
//     instr_ram[56] = 32'h00400513;
//     instr_ram[57] = 32'h338000EF;
//     instr_ram[58] = 32'h00700593;
//     instr_ram[59] = 32'h00600513;
//     instr_ram[60] = 32'h32C000EF;
//     instr_ram[61] = 32'h00800593;
//     instr_ram[62] = 32'h00700513;
//     instr_ram[63] = 32'h320000EF;
//     instr_ram[64] = 32'h00900593;
//     instr_ram[65] = 32'h00800513;
//     instr_ram[66] = 32'h314000EF;
//     instr_ram[67] = 32'h00C00593;
//     instr_ram[68] = 32'h00800513;
//     instr_ram[69] = 32'h308000EF;
//     instr_ram[70] = 32'h00A00593;
//     instr_ram[71] = 32'h00900513;
//     instr_ram[72] = 32'h2FC000EF;
//     instr_ram[73] = 32'h00B00593;
//     instr_ram[74] = 32'h00900513;
//     instr_ram[75] = 32'h2F0000EF;
//     instr_ram[76] = 32'h00D00593;
//     instr_ram[77] = 32'h00C00513;
//     instr_ram[78] = 32'h2E4000EF;
//     instr_ram[79] = 32'h01300593;
//     instr_ram[80] = 32'h00C00513;
//     instr_ram[81] = 32'h2D8000EF;
//     instr_ram[82] = 32'h00E00593;
//     instr_ram[83] = 32'h00D00513;
//     instr_ram[84] = 32'h2CC000EF;
//     instr_ram[85] = 32'h00F00593;
//     instr_ram[86] = 32'h00E00513;
//     instr_ram[87] = 32'h2C0000EF;
//     instr_ram[88] = 32'h01000593;
//     instr_ram[89] = 32'h00E00513;
//     instr_ram[90] = 32'h2B4000EF;
//     instr_ram[91] = 32'h01100593;
//     instr_ram[92] = 32'h01000513;
//     instr_ram[93] = 32'h2A8000EF;
//     instr_ram[94] = 32'h01200593;
//     instr_ram[95] = 32'h01000513;
//     instr_ram[96] = 32'h29C000EF;
//     instr_ram[97] = 32'h01300593;
//     instr_ram[98] = 32'h01200513;
//     instr_ram[99] = 32'h290000EF;
//     instr_ram[100] = 32'h01400593;
//     instr_ram[101] = 32'h01300513;
//     instr_ram[102] = 32'h284000EF;
//     instr_ram[103] = 32'h01500593;
//     instr_ram[104] = 32'h01400513;
//     instr_ram[105] = 32'h278000EF;
//     instr_ram[106] = 32'h01800593;
//     instr_ram[107] = 32'h01400513;
//     instr_ram[108] = 32'h26C000EF;
//     instr_ram[109] = 32'h01D00593;
//     instr_ram[110] = 32'h01400513;
//     instr_ram[111] = 32'h260000EF;
//     instr_ram[112] = 32'h01600593;
//     instr_ram[113] = 32'h01500513;
//     instr_ram[114] = 32'h254000EF;
//     instr_ram[115] = 32'h01700593;
//     instr_ram[116] = 32'h01500513;
//     instr_ram[117] = 32'h248000EF;
//     instr_ram[118] = 32'h01900593;
//     instr_ram[119] = 32'h01800513;
//     instr_ram[120] = 32'h23C000EF;
//     instr_ram[121] = 32'h01A00593;
//     instr_ram[122] = 32'h01900513;
//     instr_ram[123] = 32'h230000EF;
//     instr_ram[124] = 32'h01B00593;
//     instr_ram[125] = 32'h01A00513;
//     instr_ram[126] = 32'h224000EF;
//     instr_ram[127] = 32'h01C00593;
//     instr_ram[128] = 32'h01A00513;
//     instr_ram[129] = 32'h218000EF;
//     instr_ram[130] = 32'h01D00593;
//     instr_ram[131] = 32'h01C00513;
//     instr_ram[132] = 32'h20C000EF;
//     instr_ram[133] = 32'h00044703;
//     instr_ram[134] = 32'h00444503;
//     instr_ram[135] = 32'h00042823;
//     instr_ram[136] = 32'h0FF77713;
//     instr_ram[137] = 32'h0FF57513;
//     instr_ram[138] = 32'h020007B7;
//     instr_ram[139] = 32'h01D00613;
//     instr_ram[140] = 32'h02800593;
//     instr_ram[141] = 32'hFFF00813;
//     instr_ram[142] = 32'h0107A683;
//     instr_ram[143] = 32'h0ED65063;
//     instr_ram[144] = 32'h00E78733;
//     instr_ram[145] = 32'h08070A23;
//     instr_ram[146] = 32'h0007AC23;
//     instr_ram[147] = 32'h020007B7;
//     instr_ram[148] = 32'h01D00813;
//     instr_ram[149] = 32'h02800313;
//     instr_ram[150] = 32'h09478E13;
//     instr_ram[151] = 32'h020005B7;
//     instr_ram[152] = 32'h01C00893;
//     instr_ram[153] = 32'h0007A823;
//     instr_ram[154] = 32'h0007AA23;
//     instr_ram[155] = 32'h0147A683;
//     instr_ram[156] = 32'h0107A703;
//     instr_ram[157] = 32'h0CD85663;
//     instr_ram[158] = 32'h00170713;
//     instr_ram[159] = 32'h00E7A823;
//     instr_ram[160] = 32'hFEE854E3;
//     instr_ram[161] = 32'h0185A703;
//     instr_ram[162] = 32'h00170713;
//     instr_ram[163] = 32'h00E5AC23;
//     instr_ram[164] = 32'hFCE8DAE3;
//     instr_ram[165] = 32'h0E058723;
//     instr_ram[166] = 32'h0EA58C23;
//     instr_ram[167] = 32'h020007B7;
//     instr_ram[168] = 32'h0FF00613;
//     instr_ram[169] = 32'h0F87C703;
//     instr_ram[170] = 32'h0EC71A63;
//     instr_ram[171] = 32'h0EE7C703;
//     instr_ram[172] = 32'h0007A823;
//     instr_ram[173] = 32'hFFF70713;
//     instr_ram[174] = 32'h00E7AA23;
//     instr_ram[175] = 32'h020007B7;
//     instr_ram[176] = 32'h0107A703;
//     instr_ram[177] = 32'h0147A683;
//     instr_ram[178] = 32'h0ED74C63;
//     instr_ram[179] = 32'h0EE7C683;
//     instr_ram[180] = 32'h0007A823;
//     instr_ram[181] = 32'h020007B7;
//     instr_ram[182] = 32'h0107A703;
//     instr_ram[183] = 32'h12D74463;
//     instr_ram[184] = 32'h00100713;
//     instr_ram[185] = 32'h00E78623;
//     instr_ram[186] = 32'h00C12083;
//     instr_ram[187] = 32'h00812403;
//     instr_ram[188] = 32'h00412483;
//     instr_ram[189] = 32'h00000513;
//     instr_ram[190] = 32'h01010113;
//     instr_ram[191] = 32'h00008067;
//     instr_ram[192] = 32'h00279793;
//     instr_ram[193] = 32'h00F407B3;
//     instr_ram[194] = 32'h0007AE23;
//     instr_ram[195] = 32'h01042783;
//     instr_ram[196] = 32'h00178793;
//     instr_ram[197] = 32'h00F42823;
//     instr_ram[198] = 32'hD5DFF06F;
//     instr_ram[199] = 32'h00D786B3;
//     instr_ram[200] = 32'h08B68A23;
//     instr_ram[201] = 32'h0107A683;
//     instr_ram[202] = 32'h00D786B3;
//     instr_ram[203] = 32'h0B068923;
//     instr_ram[204] = 32'h0107A683;
//     instr_ram[205] = 32'h00168693;
//     instr_ram[206] = 32'h00D7A823;
//     instr_ram[207] = 32'hEFDFF06F;
//     instr_ram[208] = 32'h00271613;
//     instr_ram[209] = 32'h00C78633;
//     instr_ram[210] = 32'h01C62603;
//     instr_ram[211] = 32'h40D65633;
//     instr_ram[212] = 32'h00167613;
//     instr_ram[213] = 32'h0EC78923;
//     instr_ram[214] = 32'h02060A63;
//     instr_ram[215] = 32'h00E78733;
//     instr_ram[216] = 32'h09474703;
//     instr_ram[217] = 32'h02670463;
//     instr_ram[218] = 32'h01C686B3;
//     instr_ram[219] = 32'h0006C603;
//     instr_ram[220] = 32'h00170713;
//     instr_ram[221] = 32'h00C75C63;
//     instr_ram[222] = 32'h00E68023;
//     instr_ram[223] = 32'h0147A703;
//     instr_ram[224] = 32'h0107A683;
//     instr_ram[225] = 32'h00E78733;
//     instr_ram[226] = 32'h0AD70923;
//     instr_ram[227] = 32'h0147A703;
//     instr_ram[228] = 32'h00170713;
//     instr_ram[229] = 32'h00E7AA23;
//     instr_ram[230] = 32'hED5FF06F;
//     instr_ram[231] = 32'h0EE7C683;
//     instr_ram[232] = 32'h00168593;
//     instr_ram[233] = 32'h0EB78723;
//     instr_ram[234] = 32'h00D786B3;
//     instr_ram[235] = 32'h0CE68823;
//     instr_ram[236] = 32'h00E78733;
//     instr_ram[237] = 32'h0B274703;
//     instr_ram[238] = 32'h0EE78C23;
//     instr_ram[239] = 32'hEE9FF06F;
//     instr_ram[240] = 32'h00E78733;
//     instr_ram[241] = 32'h0D074603;
//     instr_ram[242] = 32'h00D786B3;
//     instr_ram[243] = 32'h0EC789A3;
//     instr_ram[244] = 32'h0D06C683;
//     instr_ram[245] = 32'h0CD70823;
//     instr_ram[246] = 32'h0147A703;
//     instr_ram[247] = 32'h0F37C683;
//     instr_ram[248] = 32'h00E78733;
//     instr_ram[249] = 32'h0CD70823;
//     instr_ram[250] = 32'h0107A703;
//     instr_ram[251] = 32'h00170713;
//     instr_ram[252] = 32'h00E7A823;
//     instr_ram[253] = 32'h0147A703;
//     instr_ram[254] = 32'hFFF70713;
//     instr_ram[255] = 32'h00E7AA23;
//     instr_ram[256] = 32'hEC1FF06F;
//     instr_ram[257] = 32'h00E78633;
//     instr_ram[258] = 32'h0D064603;
//     instr_ram[259] = 32'h00170713;
//     instr_ram[260] = 32'h00E7A823;
//     instr_ram[261] = 32'h00C78423;
//     instr_ram[262] = 32'hEC1FF06F;
//     instr_ram[263] = 32'h02000737;
//     instr_ram[264] = 32'h00251693;
//     instr_ram[265] = 32'h01C70713;
//     instr_ram[266] = 32'h00E686B3;
//     instr_ram[267] = 32'h0006A603;
//     instr_ram[268] = 32'h00100793;
//     instr_ram[269] = 32'h00B79833;
//     instr_ram[270] = 32'h01066633;
//     instr_ram[271] = 32'h00259593;
//     instr_ram[272] = 32'h00C6A023;
//     instr_ram[273] = 32'h00E585B3;
//     instr_ram[274] = 32'h00A797B3;
//     instr_ram[275] = 32'h0005A503;
//     instr_ram[276] = 32'h00F567B3;
//     instr_ram[277] = 32'h00F5A023;
//     instr_ram[278] = 32'h00008067;
//     instr_ram[279] = 32'h00050213;
//     instr_ram[280] = 32'h00008067;
//     instr_ram[281] = 32'h00050313;
//     instr_ram[282] = 32'h00060E63;
//     instr_ram[283] = 32'h00058383;
//     instr_ram[284] = 32'h00730023;
//     instr_ram[285] = 32'hFFF60613;
//     instr_ram[286] = 32'h00130313;
//     instr_ram[287] = 32'h00158593;
//     instr_ram[288] = 32'hFE0616E3;
//     instr_ram[289] = 32'h00008067;
//     instr_ram[290] = 32'h00050313;
//     instr_ram[291] = 32'h00060A63;
//     instr_ram[292] = 32'h00B30023;
//     instr_ram[293] = 32'hFFF60613;
//     instr_ram[294] = 32'h00130313;
//     instr_ram[295] = 32'hFE061AE3;
//     instr_ram[296] = 32'h00008067;
//     instr_ram[297] = 32'h00000000;

   
// end

// // word-aligned memory access
// // combinational read logic
// assign instr = instr_ram[instr_addr[31:2]];

// endmodule
