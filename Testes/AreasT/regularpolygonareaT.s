@ Data Section
.data

.align 4
    number_side: .single 4                                  @Initialize the number_size with 4.0
.align 4                                                    @Aligned the data to appropriate boundaries.
    side: .single 2.3                                       @Initialize side with 2.3
.align 4
    apothema: .single 6                                     @Initialize apothema with 6.0
.align 4
    buffer: .asciz "%f"                                     @Create the buffer to store the value
.align 4
    two: .single 2.0                                        @Constant two

result:  .asciz "The polygon area is: %lf\n"                @String with the answer
 
.arch armv8-a                                               @Needed to use float values
.section .text
.global main
.arm

main:
    BL _regularpolygon              @Calls _regularpolygon function
    B _exit

_regularpolygon:    
    PUSH {LR}                   @Push the Link Register value

    LDR R1, =number_side        @Loads the side value in R1
    VLDR S1, [R1]               @Loads the value of side in S1, S because we want float 

    LDR R1, =side               @Loads the side value in R1
    VLDR S2, [R1]               @Loads the value of side in S2, S because we want float 

    LDR R1, =apothema           @Loads the aphotema value in R1
    VLDR S3, [R1]               @Loads the value of side in S3, S because we want float 

    LDR R1, =two                @Loads the two value in R1
    VLDR S4, [R1]               @Loads the value of two in S4, S because we want float 

    VMUL.F32 S1 , S1 , S2       @Store in S1 the value of number_side * side
    VMUL.F32 S1, S1, S3         @Store in S1 the value of (number_side * side)* apothema
    VDIV.F32 S1, S1, S4         @Store in S1 the value of (number_side * side* apothema) / 2
    VCVT.F64.F32 D8, S1         @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result             @Loads the result in R0
    BL printf                   @Print the result

    POP {LR}                    @POP Link Register
    BX LR                       @Branch and exchange to Link Register

_exit:
    MOV R7, #1
    SVC 0
