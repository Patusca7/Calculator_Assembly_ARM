@ Data Section
.data
question: .asciz "Enter the value of the side \n"           @String with the question

.align 4                                                    @Aligned the data to appropriate boundaries.
    side: .single 0.0                                       @Initialize side with 0.0
.align 4
    buffer: .asciz "%f"                                     @Create the buffer to store the value

result:  .asciz "The cube volume is: %lf\n"                 @String with the answer
 
.arch armv8-a                                               @Needed to use float values
.section .text
.global main
.arm


main:
    BL cubevolume              @Calls cubevolume function
    B _exit

cubevolume:    
    PUSH {LR}                   @Push the Link Register value
    LDR R0, =question           @Loads the question in R0
    BL printf                   @Prints the question

    LDR R0, =buffer             @Loads buffer in R0
    LDR R1, =side               @Loads the side value in R1
    BL scanf                    @Scans the value

    LDR R1, =side               @Loads the side value in R1
    VLDR S1, [R1]               @Loads the value of side in S1, S because we want float 

    VMUL.F32 S2 , S1 , S1       @Store in S2 the value of side * side
    VMUL.F32 S2, S1, S2         @Store in S2 the value of S2(side * side) * side
    VCVT.F64.F32 D8, S2         @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result             @Loads the result in R0
    BL printf                   @Print the result

    POP {LR}                    @POP Link Register
    BX LR                       @Branch and exchange to Link Register

_exit:
    MOV R7, #1
    SVC 0
