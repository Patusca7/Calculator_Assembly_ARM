@ Data Section
.data

.align 4                                                    @Aligned the data to appropriate boundaries.
    side: .single 2.5                                       @Initialize side with 2.5
.align 4
    buffer: .asciz "%f"                                     @Create the buffer to store the value

result:  .asciz "The square area is: %lf\n"             @String with the answer
 


.arch armv8-a                                               @Needed to use float values
.section .text
.global main
.arm


main:
    BL _squarearea              @Calls _squarearea function
    B _exit

_squarearea:    
    PUSH {LR}                   @Push the Link Register value

    LDR R1, =side               @Loads the side value in R1
    VLDR S1, [R1]               @Loads the value of side in S1, S because we want float 

    VMUL.F32 S1 , S1 , S1       @Store in S1 the value of side * side
    VCVT.F64.F32 D8, S1         @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result             @Loads the result in R0
    BL printf                   @Print the result

    POP {LR}                    @POP Link Register
    BX LR                       @Branch and exchange to Link Register

_exit:
    MOV R7, #1
    SVC 0
