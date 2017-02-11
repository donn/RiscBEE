//Generates a barrel shifter. Because let's be honest, Verilog generate statements are the devil.

for (var i = 0; i < 7; i++) {
    for (var j = 0; j < 32; j++)
    {
        if (i === 0) {
          console.log("Mux2 #(1) mux" + i + "_" + j + "(.A(A[" + j + "]), .B(A[" + (31 - j) + "]), .sel(right), .O(C[" + i + "][" + j +"]));");
        } else if (i == 6) {
          console.log("Mux2 #(1) mux" + i + "_" + j + "(.A(C[" + (i - 1) +"][" + j + "]), .B(C[" + (i - 1) + "][" + (31 - j) + "]), .sel(right),   .O(O[" + (j) + "]));");
        } else {
          var c = "C["+(i-1)+"]["+((-6+i)+j)+"]";
          var b = "lastbit";
          var v = ((-6+i)+j < 0) ? b : c;
          console.log("Mux2 #(1) mux" + i + "_" + j + "(.A(C[" + (i - 1) +"][" + j + "]), .B("+v+"), .sel(shamt[" + (5-i) + "]), .O(C[" + i + "][" + j +"]));");
        }
    }
}
