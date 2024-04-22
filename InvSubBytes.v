
module SubBytes2 (instate,outstate);
input[127:0]instate;
output[127:0]outstate;
genvar  i;
// Setting the Rijndael Inv_S_box as a 1D array (flattened)
reg [7:0] Inv_S_box [0:255];
initial
 begin
      Inv_S_box[0]  = 8'h52; Inv_S_box[1]  = 8'h09; Inv_S_box[2]  = 8'h6A; Inv_S_box[3]  = 8'hD5;
    Inv_S_box[4]  = 8'h30; Inv_S_box[5]  = 8'h36; Inv_S_box[6]  = 8'hA5; Inv_S_box[7]  = 8'h38;
    Inv_S_box[8]  = 8'hBF; Inv_S_box[9]  = 8'h40; Inv_S_box[10] = 8'hA3; Inv_S_box[11] = 8'h9E;
    Inv_S_box[12] = 8'h81; Inv_S_box[13] = 8'hF3; Inv_S_box[14] = 8'hD7; Inv_S_box[15] = 8'hFB;
    Inv_S_box[16] = 8'h7C; Inv_S_box[17] = 8'hE3; Inv_S_box[18] = 8'h39; Inv_S_box[19] = 8'h82;
    Inv_S_box[20] = 8'h9B; Inv_S_box[21] = 8'h2F; Inv_S_box[22] = 8'hFF; Inv_S_box[23] = 8'h87;
    Inv_S_box[24] = 8'h34; Inv_S_box[25] = 8'h8E; Inv_S_box[26] = 8'h43; Inv_S_box[27] = 8'h44;
    Inv_S_box[28] = 8'hC4; Inv_S_box[29] = 8'hDE; Inv_S_box[30] = 8'hE9; Inv_S_box[31] = 8'hCB;
    Inv_S_box[32] = 8'h54; Inv_S_box[33] = 8'h7B; Inv_S_box[34] = 8'h94; Inv_S_box[35] = 8'h32;
    Inv_S_box[36] = 8'hA6; Inv_S_box[37] = 8'hC2; Inv_S_box[38] = 8'h23; Inv_S_box[39] = 8'h3D;
    Inv_S_box[40] = 8'hEE; Inv_S_box[41] = 8'h4C; Inv_S_box[42] = 8'h95; Inv_S_box[43] = 8'h0B;
    Inv_S_box[44] = 8'h42; Inv_S_box[45] = 8'hFA; Inv_S_box[46] = 8'hC3; Inv_S_box[47] = 8'h4E;
    Inv_S_box[48] = 8'h08; Inv_S_box[49] = 8'h2E; Inv_S_box[50] = 8'hA1; Inv_S_box[51] = 8'h66;
    Inv_S_box[52] = 8'h28; Inv_S_box[53] = 8'hD9; Inv_S_box[54] = 8'h24; Inv_S_box[55] = 8'hB2;
    Inv_S_box[56] = 8'h76; Inv_S_box[57] = 8'h5B; Inv_S_box[58] = 8'hA2; Inv_S_box[59] = 8'h49;
    Inv_S_box[60] = 8'h6D; Inv_S_box[61] = 8'h8B; Inv_S_box[62] = 8'hD1; Inv_S_box[63] = 8'h25;
    Inv_S_box[64] = 8'h72; Inv_S_box[65] = 8'hF8; Inv_S_box[66] = 8'hF6; Inv_S_box[67] = 8'h64;
    Inv_S_box[68] = 8'h86; Inv_S_box[69] = 8'h68; Inv_S_box[70] = 8'h98; Inv_S_box[71] = 8'h16;
    Inv_S_box[72] = 8'hD4; Inv_S_box[73] = 8'hA4; Inv_S_box[74] = 8'h5C; Inv_S_box[75] = 8'hCC;
    Inv_S_box[76] = 8'h5D; Inv_S_box[77] = 8'h65; Inv_S_box[78] = 8'hB6; Inv_S_box[79] = 8'h92;
    Inv_S_box[80] = 8'h6C; Inv_S_box[81] = 8'h70; Inv_S_box[82] = 8'h48; Inv_S_box[83] = 8'h50;
    Inv_S_box[84] = 8'hFD; Inv_S_box[85] = 8'hED; Inv_S_box[86] = 8'hB9; Inv_S_box[87] = 8'hDA;
    Inv_S_box[88] = 8'h5E; Inv_S_box[89] = 8'h15; Inv_S_box[90] = 8'h46; Inv_S_box[91] = 8'h57;
    Inv_S_box[92] = 8'hA7; Inv_S_box[93] = 8'h8D; Inv_S_box[94] = 8'h9D; Inv_S_box[95] = 8'h84;
    Inv_S_box[96] = 8'h90; Inv_S_box[97] = 8'hD8; Inv_S_box[98] = 8'hAB; Inv_S_box[99] = 8'h00;
    Inv_S_box[100] = 8'h8C; Inv_S_box[101] = 8'hBC; Inv_S_box[102] = 8'hD3; Inv_S_box[103] = 8'h0A;
    Inv_S_box[104] = 8'hF7; Inv_S_box[105] = 8'hE4; Inv_S_box[106] = 8'h58; Inv_S_box[107] = 8'h05;
    Inv_S_box[108] = 8'hB8; Inv_S_box[109] = 8'hB3; Inv_S_box[110] = 8'h45; Inv_S_box[111] = 8'h06;
    Inv_S_box[112] = 8'hD0; Inv_S_box[113] = 8'h2C; Inv_S_box[114] = 8'h1E; Inv_S_box[115] = 8'h8F;
    Inv_S_box[116] = 8'hCA; Inv_S_box[117] = 8'h3F; Inv_S_box[118] = 8'h0F; Inv_S_box[119] = 8'h02;
    Inv_S_box[120] = 8'hC1; Inv_S_box[121] = 8'hAF; Inv_S_box[122] = 8'hBD; Inv_S_box[123] = 8'h03;
    Inv_S_box[124] = 8'h01; Inv_S_box[125] = 8'h13; Inv_S_box[126] = 8'h8A; Inv_S_box[127] = 8'h6B;
    Inv_S_box[128] = 8'h3A; Inv_S_box[129] = 8'h91; Inv_S_box[130] = 8'h11; Inv_S_box[131] = 8'h41;
    Inv_S_box[132] = 8'h4F; Inv_S_box[133] = 8'h67; Inv_S_box[134] = 8'hDC; Inv_S_box[135] = 8'hEA;
    Inv_S_box[136] = 8'h97; Inv_S_box[137] = 8'hF2; Inv_S_box[138] = 8'hCF; Inv_S_box[139] = 8'hCE;
    Inv_S_box[140] = 8'hF0; Inv_S_box[141] = 8'hB4; Inv_S_box[142] = 8'hE6; Inv_S_box[143] = 8'h73;
    Inv_S_box[144] = 8'h96; Inv_S_box[145] = 8'hAC; Inv_S_box[146] = 8'h74; Inv_S_box[147] = 8'h22;
    Inv_S_box[148] = 8'hE7; Inv_S_box[149] = 8'hAD; Inv_S_box[150] = 8'h35; Inv_S_box[151] = 8'h85;
    Inv_S_box[152] = 8'hE2; Inv_S_box[153] = 8'hF9; Inv_S_box[154] = 8'h37; Inv_S_box[155] = 8'hE8;
    Inv_S_box[156] = 8'h1C; Inv_S_box[157] = 8'h75; Inv_S_box[158] = 8'hDF; Inv_S_box[159] = 8'h6E;
    Inv_S_box[160] = 8'h47; Inv_S_box[161] = 8'hF1; Inv_S_box[162] = 8'h1A; Inv_S_box[163] = 8'h71;
    Inv_S_box[164] = 8'h1D; Inv_S_box[165] = 8'h29; Inv_S_box[166] = 8'hC5; Inv_S_box[167] = 8'h89;
    Inv_S_box[168] = 8'h6F; Inv_S_box[169] = 8'hB7; Inv_S_box[170] = 8'h62; Inv_S_box[171] = 8'h0E;
    Inv_S_box[172] = 8'hAA; Inv_S_box[173] = 8'h18; Inv_S_box[174] = 8'hBE; Inv_S_box[175] = 8'h1B;
    Inv_S_box[176] = 8'hFC; Inv_S_box[177] = 8'h56; Inv_S_box[178] = 8'h3E; Inv_S_box[179] = 8'h4B;
    Inv_S_box[180] = 8'hC6; Inv_S_box[181] = 8'hD2; Inv_S_box[182] = 8'h79; Inv_S_box[183] = 8'h20;
    Inv_S_box[184] = 8'h9A; Inv_S_box[185] = 8'hDB; Inv_S_box[186] = 8'hC0; Inv_S_box[187] = 8'hFE;
    Inv_S_box[188] = 8'h78; Inv_S_box[189] = 8'hCD; Inv_S_box[190] = 8'h5A; Inv_S_box[191] = 8'hF4;
    Inv_S_box[192] = 8'h1F; Inv_S_box[193] = 8'hDD; Inv_S_box[194] = 8'hA8; Inv_S_box[195] = 8'h33;
    Inv_S_box[196] = 8'h88; Inv_S_box[197] = 8'h07; Inv_S_box[198] = 8'hC7; Inv_S_box[199] = 8'h31;
    Inv_S_box[200] = 8'hB1; Inv_S_box[201] = 8'h12; Inv_S_box[202] = 8'h10; Inv_S_box[203] = 8'h59;
    Inv_S_box[204] = 8'h27; Inv_S_box[205] = 8'h80; Inv_S_box[206] = 8'hEC; Inv_S_box[207] = 8'h5F;
    Inv_S_box[208] = 8'h60; Inv_S_box[209] = 8'h51; Inv_S_box[210] = 8'h7F; Inv_S_box[211] = 8'hA9;
    Inv_S_box[212] = 8'h19; Inv_S_box[213] = 8'hB5; Inv_S_box[214] = 8'h4A; Inv_S_box[215] = 8'h0D;
    Inv_S_box[216] = 8'h2D; Inv_S_box[217] = 8'hE5; Inv_S_box[218] = 8'h7A; Inv_S_box[219] = 8'h9F;
    Inv_S_box[220] = 8'h93; Inv_S_box[221] = 8'hC9; Inv_S_box[222] = 8'h9C; Inv_S_box[223] = 8'hEF;
    Inv_S_box[224] = 8'hA0; Inv_S_box[225] = 8'hE0; Inv_S_box[226] = 8'h3B; Inv_S_box[227] = 8'h4D;
    Inv_S_box[228] = 8'hAE; Inv_S_box[229] = 8'h2A; Inv_S_box[230] = 8'hF5; Inv_S_box[231] = 8'hB0;
    Inv_S_box[232] = 8'hC8; Inv_S_box[233] = 8'hEB; Inv_S_box[234] = 8'hBB; Inv_S_box[235] = 8'h3C;
    Inv_S_box[236] = 8'h83; Inv_S_box[237] = 8'h53; Inv_S_box[238] = 8'h99; Inv_S_box[239] = 8'h61;
    Inv_S_box[240] = 8'h17; Inv_S_box[241] = 8'h2B; Inv_S_box[242] = 8'h04; Inv_S_box[243] = 8'h7E;
    Inv_S_box[244] = 8'hBA; Inv_S_box[245] = 8'h77; Inv_S_box[246] = 8'hD6; Inv_S_box[247] = 8'h26;
    Inv_S_box[248] = 8'hE1; Inv_S_box[249] = 8'h69; Inv_S_box[250] = 8'h14; Inv_S_box[251] = 8'h63;
    Inv_S_box[252] = 8'h55; Inv_S_box[253] = 8'h21; Inv_S_box[254] = 8'h0C; Inv_S_box[255] = 8'h7D;
end 
generate                         
for(i=0;i<128;i=i+8)
begin:inverseSubBytes
/*
row=instate[(i+4)+:4];
 col=instate[i+:4];*/
assign outstate[i +: 8]=Inv_S_box[instate[(i+4)+:4]*16+instate[i+:4]];
end
endgenerate
endmodule


// test_bench for SubBytes 
module InvSubBytes_DUT();
reg [127:0]instate;
wire [127:0]out;
initial                                                 //expected output
begin //...xxxxx  93      e1       4d       89       76   ===============>...xxxxx  22      e0       65       f2       0f
instate=128'bx10010011_11100001_01001101_10001001_01110110;
end
InvSubBytes ss(instate,out);
endmodule

