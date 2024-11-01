@ Data Section
.data

.align 4                                                        @Aligned the data to appropriate boundaries.
    width: .single 3.2                                          @Initialize width with 3.2
.align 4
    buffer: .asciz "%f"                                         @Create the buffer to store the value
.align 4    
    length: .single 2.3                                         @Initialize length with 2.3
.align 4
    height: .single 1.2                                         @Initialize heigth with 1.2
    
result:  .asciz "The parallelipiped volume is: %lf\n"           @String with the answer


.arch armv8-a                                                   @Needed to use float values
.section .text
.global main
.arm


main:
    BL _parallelipipedvolume           @Calls _parallelipipedvolume function
    B _exit

_parallelipipedvolume:
    PUSH {LR}                   @Push the Link Register value

    LDR R1, =width              @Loads the width value in R1
    VLDR S1, [R1]               @Loads the value of width in S1, S because we want float 

    LDR R1, =length             @Loads the length value in R1
    VLDR S2, [R1]               @Loads the value of length in S2, S because we want float 

    LDR R1, =height             @Loads the height value in R1
    VLDR S3, [R1]               @Loads the value of height in S3, S because we want float 


    VMUL.F32 S1 , S1 , S2       @Store in S1 the value of width * length
    VMUL.F32 S1, S1 , S3        @Store in S1 the value of S1(width * length) * heigth
    VCVT.F64.F32 D8, S1         @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result             @Loads the result in R0
    BL printf                   @Print the result

    POP {LR}                    @POP Link Register
    BX LR                       @Branch and exchange to Link Register

_exit:
    MOV R7, #1
    SVC 0
