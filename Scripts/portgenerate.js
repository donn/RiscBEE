//Generates connections out of a list of ports.

var x = `
    word,
    Z,
    C,
    N,
    V,
    rs1, 
    rs2, 
    rd,
    alu_op,
    imm_uj, 
    imm_u, 
    imm_i, 
    imm_s, 
    imm_sb,
    r,
    uj,
    u,
    u_control,
    i,
    s,
    sb,
    load_pc,
    mem_read,
    mem_read_sext,
    iobytes
`;

var y = x.split("\n").join("").split(" ").join("").split(",");

var z = ""
for (var i in y)
{
  z += "." + y[i] + "(" + y[i] +"), ";
}

console.log(z);