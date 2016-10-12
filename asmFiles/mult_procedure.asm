
org 0x0000
addi $29, $0, 0xFFFC
addi $18, $0, 2
addi $19, $0, 3
addi $20, $0, 2
addi $22, $0, 0xFFFFFFF8
push $18
push $19
push $20
jal mult
var:
  beq $29, $22,Exit
  jal mult
  j var
Exit:
  halt

mult:
  pop $1
  pop $2
  addi $3, $0, 0
  addi $23, $0, 0
  multiply:
    andi $4,$2,1
    beq $4, $0, clear
    addu $3, $3, $1
  clear:
    sll $1, $1, 1
    srl $2, $2, 1
    bne $2,$0,multiply
  push $3
  jr $ra

