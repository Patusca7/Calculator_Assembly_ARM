@ Data Section
.data
question: .asciz "Enter the value of the smaller diagonal \n"       @String with question
question2: .asciz "Enter the value of the larger diagonal \n"       @String with question2

.align 4                                                @Aligned the data to appropriate boundaries.
    smalldiag: .single 0.0                              @Initialize smalldiag with 0.0
.align 4
    buffer: .asciz "%f"                                 @Create the buffer to store the value
.align 4    
    largdiag: .single 0.0                               @Initialize largdiag with 0.0
.align 4
    half: .single 0.5                                   @Constant 0.5  

result:  .asciz "The diamond area is: %lf\n"            @String with the answer

.arch armv8-a                                           @Needed to use float numbers
.section .text
.global main
.arm


main:
    BL _diamondarea         @Calls _diamondarea function
    B _exit

_diamondarea:
    PUSH {LR}               @Push the Link Register value
    LDR R0, =question       @Loads the question in R0
    BL printf               @Prints the question

    LDR R0, =buffer         @Loads buffer in R0
    LDR R1, =smalldiag      @Loads the smalldiag value in R1
    BL scanf                @Scans the value

    LDR R1, =smalldiag      @Loads the smalldiag value in R1

    LDR R0, =question2      @Loads the question2 in R0
    BL printf               @Print the question2

    LDR R0, =buffer         @Loads buffer in R0
    LDR R1, =largdiag       @Loads the largdiag value in R1
    BL scanf                @Scans the value
    LDR R1, =largdiag       @Loads the largdiag value in R1
    VLDR S2, [R1]           @Loads the value of largdiag in S2, S because we want float 

    LDR R1, =half           @Loads half in R1
    VLDR S4,[R1]            @Loads half in S4, S because we want float 

    VMUL.F32 S3 , S1 , S2   @Store in S3 the value of smalldiag * largdiag
    VMUL.F32 S3, S3, S4     @Stire in S3 the value of S3(smalldiag * largdiag) * 0.5
    VCVT.F64.F32 D8, S3     @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result         @Loads the result in R0
    BL printf               @Print the result

    POP {LR}                @POP Link Register
    BX LR                   @Branch and exchange to Link Register   

_exit:
    MOV R7, #1
    SVC 0
