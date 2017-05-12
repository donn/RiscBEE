//This script turns flat binaries into ROM that is accepted by Verilog testbenches
var x = "03 24 C1 FF 13 01 C1 FF 93 12 04 01 23 2E 51 FE 13 01 C1 FF B7 04 FF FF B3 72 94 00 23 2E 51 FE 13 01 C1 FF 6F 00 00 00";

var y = x.split(" ").reverse();

var z = ""
var a = 0;
var b = [];

for (var i in y)
{
  if (a === 0)
  {
    z += `rom[${(y.length / 4) - 1 - b.length}] = 32'h`;
  }
  z += y[i];
  a++;
  if (a === 4)
  {
    b.push(z + ";");
    z = "";
    a = 0;
  }
  
}

b.reverse();


console.log(b.join("\n"));