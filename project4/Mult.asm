    @R2
    M=0

    @R0
    D=M
    @END
    D;JEQ

    @R1
    D=M
    @END
    D;JEQ

    @i
    M=D

(LOOP)
    @R0
    D=M
    @R2
    M=D+M
    @i
    M=M-1
    D=M
    @LOOP
    D;JGT
    @END

(END)
    0;JMP

