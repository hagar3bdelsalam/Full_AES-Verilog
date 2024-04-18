module SubBytes (instate,outstate);
input[127:0]instate;
output[127:0]outstate;
reg[7:0]prev_state[0:15];
reg[7:0]new_state[0:15];
reg[127:0]out_state;
reg[3:0]row;
reg[3:0]col;
integer  i;
integer  j;
integer  k;
// Setting the Rijndael S-box as a 1D array (flattened)
reg [7:0] S_box [0:255];
initial
 begin
    S_box[0]  = 8'h63; S_box[1]  = 8'h7C; S_box[2]  = 8'h77; S_box[3]  = 8'h7B;
    S_box[4]  = 8'hF2; S_box[5]  = 8'h6B; S_box[6]  = 8'h6F; S_box[7]  = 8'hC5;
    S_box[8]  = 8'h30; S_box[9]  = 8'h01; S_box[10] = 8'h67; S_box[11] = 8'h2B;
    S_box[12] = 8'hFE; S_box[13] = 8'hD7; S_box[14] = 8'hAB; S_box[15] = 8'h76;
    S_box[16] = 8'hCA; S_box[17] = 8'h82; S_box[18] = 8'hC9; S_box[19] = 8'h7D;
    S_box[20] = 8'hFA; S_box[21] = 8'h59; S_box[22] = 8'h47; S_box[23] = 8'hF0;
    S_box[24] = 8'hAD; S_box[25] = 8'hD4; S_box[26] = 8'hA2; S_box[27] = 8'hAF;
    S_box[28] = 8'h9C; S_box[29] = 8'hA4; S_box[30] = 8'h72; S_box[31] = 8'hC0;
    S_box[32] = 8'hB7; S_box[33] = 8'hFD; S_box[34] = 8'h93; S_box[35] = 8'h26;
    S_box[36] = 8'h36; S_box[37] = 8'h3F; S_box[38] = 8'hF7; S_box[39] = 8'hCC;
    S_box[40] = 8'h34; S_box[41] = 8'hA5; S_box[42] = 8'hE5; S_box[43] = 8'hF1;
    S_box[44] = 8'h71; S_box[45] = 8'hD8; S_box[46] = 8'h31; S_box[47] = 8'h15;
    S_box[48] = 8'h04; S_box[49] = 8'hC7; S_box[50] = 8'h23; S_box[51] = 8'hC3;
    S_box[52] = 8'h18; S_box[53] = 8'h96; S_box[54] = 8'h05; S_box[55] = 8'h9A;
    S_box[56] = 8'h07; S_box[57] = 8'h12; S_box[58] = 8'h80; S_box[59] = 8'hE2;
    S_box[60] = 8'hEB; S_box[61] = 8'h27; S_box[62] = 8'hB2; S_box[63] = 8'h75;
    S_box[64] = 8'h09; S_box[65] = 8'h83; S_box[66] = 8'h2C; S_box[67] = 8'h1A;
    S_box[68] = 8'h1B; S_box[69] = 8'h6E; S_box[70] = 8'h5A; S_box[71] = 8'hA0;
    S_box[72] = 8'h52; S_box[73] = 8'h3B; S_box[74] = 8'hD6; S_box[75] = 8'hB3;
    S_box[76] = 8'h29; S_box[77] = 8'hE3; S_box[78] = 8'h2F; S_box[79] = 8'h84;
    S_box[80] = 8'h53; S_box[81] = 8'hD1; S_box[82] = 8'h00; S_box[83] = 8'hED;
    S_box[84] = 8'h20; S_box[85] = 8'hFC; S_box[86] = 8'hB1; S_box[87] = 8'h5B;
    S_box[88] = 8'h6A; S_box[89] = 8'hCB; S_box[90] = 8'hBE; S_box[91] = 8'h39;
    S_box[92] = 8'h4A; S_box[93] = 8'h4C; S_box[94] = 8'h58; S_box[95] = 8'hCF;
    S_box[96] = 8'hD0; S_box[97] = 8'hEF; S_box[98] = 8'hAA; S_box[99] = 8'hFB;
    S_box[100] = 8'h43; S_box[101] = 8'h4D; S_box[102] = 8'h33; S_box[103] = 8'h85;
    S_box[104] = 8'h45; S_box[105] = 8'hF9; S_box[106] = 8'h02; S_box[107] = 8'h7F;
    S_box[108] = 8'h50; S_box[109] = 8'h3C; S_box[110] = 8'h9F; S_box[111] = 8'hA8;
    S_box[112] = 8'h51; S_box[113] = 8'hA3; S_box[114] = 8'h40; S_box[115] = 8'h8F;
    S_box[116] = 8'h92; S_box[117] = 8'h9D; S_box[118] = 8'h38; S_box[119] = 8'hF5;
    S_box[120] = 8'hBC; S_box[121] = 8'hB6; S_box[122] = 8'hDA; S_box[123] = 8'h21;
    S_box[124] = 8'h10; S_box[125] = 8'hFF; S_box[126] = 8'hF3; S_box[127] = 8'hD2;
    S_box[128] = 8'hCD; S_box[129] = 8'h0C; S_box[130] = 8'h13; S_box[131] = 8'hEC;
    S_box[132] = 8'h5F; S_box[133] = 8'h97; S_box[134] = 8'h44; S_box[135] = 8'h17;
    S_box[136] = 8'hC4; S_box[137] = 8'hA7; S_box[138] = 8'h7E; S_box[139] = 8'h3D;
    S_box[140] = 8'h64; S_box[141] = 8'h5D; S_box[142] = 8'h19; S_box[143] = 8'h73;
    S_box[144] = 8'h60; S_box[145] = 8'h81; S_box[146] = 8'h4F; S_box[147] = 8'hDC;
    S_box[148] = 8'h22; S_box[149] = 8'h2A; S_box[150] = 8'h90; S_box[151] = 8'h88;
    S_box[152] = 8'h46; S_box[153] = 8'hEE; S_box[154] = 8'hB8; S_box[155] = 8'h14;
    S_box[156] = 8'hDE; S_box[157] = 8'h5E; S_box[158] = 8'h0B; S_box[159] = 8'hDB;
    S_box[160] = 8'hE0; S_box[161] = 8'h32; S_box[162] = 8'h3A; S_box[163] = 8'h0A;
    S_box[164] = 8'h49; S_box[165] = 8'h06; S_box[166] = 8'h24; S_box[167] = 8'h5C;
    S_box[168] = 8'hC2; S_box[169] = 8'hD3; S_box[170] = 8'hAC; S_box[171] = 8'h62;
    S_box[172] = 8'h91; S_box[173] = 8'h95; S_box[174] = 8'hE4; S_box[175] = 8'h79;
    S_box[176] = 8'hE7; S_box[177] = 8'hC8; S_box[178] = 8'h37; S_box[179] = 8'h6D;
    S_box[180] = 8'h8D; S_box[181] = 8'hD5; S_box[182] = 8'h4E; S_box[183] = 8'hA9;
    S_box[184] = 8'h6C; S_box[185] = 8'h56; S_box[186] = 8'hF4; S_box[187] = 8'hEA;
    S_box[188] = 8'h65; S_box[189] = 8'h7A; S_box[190] = 8'hAE; S_box[191] = 8'h08;
    S_box[192] = 8'hBA; S_box[193] = 8'h78; S_box[194] = 8'h25; S_box[195] = 8'h2E;
    S_box[196] = 8'h1C; S_box[197] = 8'hA6; S_box[198] = 8'hB4; S_box[199] = 8'hC6;
    S_box[200] = 8'hE8; S_box[201] = 8'hDD; S_box[202] = 8'h74; S_box[203] = 8'h1F;
    S_box[204] = 8'h4B; S_box[205] = 8'hBD; S_box[206] = 8'h8B; S_box[207] = 8'h8A;
    S_box[208] = 8'h70; S_box[209] = 8'h3E; S_box[210] = 8'hB5; S_box[211] = 8'h66;
    S_box[212] = 8'h48; S_box[213] = 8'h03; S_box[214] = 8'hF6; S_box[215] = 8'h0E;
    S_box[216] = 8'h61; S_box[217] = 8'h35; S_box[218] = 8'h57; S_box[219] = 8'hB9;
    S_box[220] = 8'h86; S_box[221] = 8'hC1; S_box[222] = 8'h1D; S_box[223] = 8'h9E;
    S_box[224] = 8'hE1; S_box[225] = 8'hF8; S_box[226] = 8'h98; S_box[227] = 8'h11;
    S_box[228] = 8'h69; S_box[229] = 8'hD9; S_box[230] = 8'h8E; S_box[231] = 8'h94;
    S_box[232] = 8'h9B; S_box[233] = 8'h1E; S_box[234] = 8'h87; S_box[235] = 8'hE9;
    S_box[236] = 8'hCE; S_box[237] = 8'h55; S_box[238] = 8'h28; S_box[239] = 8'hDF;
    S_box[240] = 8'h8C; S_box[241] = 8'hA1; S_box[242] = 8'h89; S_box[243] = 8'h0D;
    S_box[244] = 8'hBF; S_box[245] = 8'hE6; S_box[246] = 8'h42; S_box[247] = 8'h68;
    S_box[248] = 8'h41; S_box[249] = 8'h99; S_box[250] = 8'h2D; S_box[251] = 8'h0F;
    S_box[252] = 8'hB0; S_box[253] = 8'h54; S_box[254] = 8'hBB; S_box[255] = 8'h16;
end 
initial
begin
#1;                           // (it will not work with out it)small delay to make sure of recieving the whole input bits
k=0;
for(i=0;i<16;i=i+1)
begin
   for(j=0;j<8;j=j+1)
   begin 
       prev_state[i][j]=instate[k];    // transforming input from flattened array to array of bytes
       k=k+1;
   end
 end


for(i=0;i<16;i=i+1)
begin
  row=prev_state[i][7:4];
  col=prev_state[i][3:0];
  new_state[i]=S_box[row*16+col];
end

k=0;

for(i=0;i<16;i=i+1)
begin
   for(j=0;j<8;j=j+1)
   begin 
	out_state[k]=new_state[i][j];    // transforming output to flattened array
        k=k+1;   
   end
end
end
assign outstate=out_state;
endmodule




// test_bench for SubBytes 
module SubBytes_DUT();
reg [127:0]instate;
wire [127:0]out;
wire [127:0]out2;
initial                                                 //expected output
begin //...xxxxx  22      e0       65       f2       0f   ===============>...xxxxx   93   e1  4d  89  76
instate=128'bx00100010_11100000_01100101_11110010_00001111;
end
SubBytes ss(instate,out);
endmodule