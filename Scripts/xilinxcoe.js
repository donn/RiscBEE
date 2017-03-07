//Creates COE files for use with Xilinx ISE.
//Just paste your Oak.js-generated machine code in x and you're good to go.

var x = "93 62 00 FF 03 A4 02 00 83 A4 42 00 33 09 94 00 23 A4 22 01 37 F3 FF FF 13 63 F3 FF 23 A6 62 00 93 08 A0 00";
 
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
