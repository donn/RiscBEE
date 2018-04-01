# Wait some cycles for initialization
li x0, 0
li x0, 0
li x0, 0
li x0, 0
li x0, 0
li x0, 0
li x0, 0
li x0, 0

# Execute
li a0, 4
lw a1, 1028(x0)
add a2, a0, a1
add a2, a2, a2
sw a2, 1024(x0)
inf: jal x0, inf