@ Data Section
.data
    question: .asciz "Enter the value of the width \n"          @String with question1
    question2: .asciz "Enter the value of the length \n"        @String with question2

.align 4                                                        @Aligned the data to appropriate boundaries.
    width: .single 0.0                                          @Initialize width with 0.0
.align 4
    buffer: .asciz "%f"                                         @Create the buffer to store the value
.align 4    
    length: .single 0.0                                         @Initialize length with 0.0

result:  .asciz "The rectangle area is: %lf\n"              @String with the answer


.arch armv8-a                                                   @Needed to use float values
.section .text
.global main
.arm


main:
    BL _rectanglearea           @Calls _rectanglearea function
    B _exit

_rectanglearea:
    PUSH {LR}                   @Push the Link Register value
    LDR R0, =question           @Loads the question in R0
    BL printf                   @Prints the question

    LDR R0, =buffer             @Loads buffer in R0
    LDR R1, =width              @Loads the width value in R1
    BL scanf                    @Scans the value

    LDR R1, =width              @Loads the width value in R1
    VLDR S1, [R1]               @Loads the value of width in S1, S because we want float 

    LDR R0, =question2          @Loads the question2 in R0
    BL printf                   @Print the question2

    LDR R0, =buffer             @Loads buffer in R0
    LDR R1, =length             @Loads the length value in R1
    BL scanf                    @Scans the value
    LDR R1, =length             @Loads the length value in R1
    VLDR S2, [R1]               @Loads the value of length in S2, S because we want float 
    
    VMUL.F32 S1 , S1 , S2       @Store in S1 the value of width * length
    VCVT.F64.F32 D8, S1         @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result             @Loads the result in R0
    BL printf                   @Print the result

    POP {LR}                    @POP Link Register
    BX LR                       @Branch and exchange to Link Register

_exit:
    MOV R7, #1
    SVC 0
