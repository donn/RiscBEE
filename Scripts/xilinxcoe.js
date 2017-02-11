//Creates COE files for use with Xilinx ISE.
//Just paste your Oak.js-generated machine code in x and you're good to go.

var x = "37 F4 FF FF 13 64 F4 FF 23 00 80 00 23 10 80 00 23 20 80 00 6F 00 00 00";

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