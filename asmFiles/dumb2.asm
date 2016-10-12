
org 0x0000
ori $2, $2, 0x0F00
lw $3, 0($2)
addi $4, $3, 1
halt



org 0x0F00
cfw 1
