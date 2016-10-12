





  org 0x0000

  addi $29, $0, 65532
  addi $2, $0, 4
  addi $14, $0, 1 #myone
  addi $1, $0, 4
  addi $12, $0, 32
  addi $3, $0, 0
  addi $23, $0, 0
  multiply:
    andi $4,$2,1
    beq $4, $0, clear
    bne $12, $0, firstword
    beq $12, $0, secondword
  clear:
    sll $1, $1, 1
    srl $2, $2, 1
    sub $12, $12, $14
    bne $2,$0,multiply
    beq $2, $0, end
  firstword:
    addu $3, $3, $1
    J clear
  secondword:
    addu $23, $23, $1
    J clear
  end:
  halt

