@ Data Section
.data

.align 4                                                @Aligned the data to appropriate boundaries.
    smallbase: .single 2.0                              @Initialize smallbase with 2.0
.align 4
    buffer: .asciz "%f"                                 @Create the buffer to store the value
.align 4    
    largbase: .single 3.5                               @Initialize largbase with 3.5
.align 4
    height: .single 5.0                                 @Initialize height with 5.0

.align 4
    half: .single 0.5                                   @Constant 0.5

result:  .asciz "The trap area is: %lf\n"               @String with the answer


.arch armv8-a                                           @Needed to use float values
.section .text
.global main
.arm


main:
    BL _traparea            @Calls _traparea function                    
    B _exit

_traparea:
    PUSH {LR}               @Push the Link Register value

    LDR R1, =smallbase      @Loads the smallbase value in R1
    VLDR S1, [R1]           @Loads the value of smallbase in S1, S because we want float 

    LDR R1, =largbase       @Loads the largbase value in R1
    VLDR S2, [R1]           @Loads the value of largbase in S2, S because we want float 

    LDR R1, =height         @Loads the height value in R1
    VLDR S4, [R1]           @Loads the value of heigth in S4, S because we want float 

    LDR R1, =half           @Loads half in R1
    VLDR S5,[R1]            @Loads half in S5, S because we want float 


    VADD.F32 S3, S1, S2     @Store in S3 the value of smallbase + largbase
    VMUL.F32 S3, S3, S4     @Store in S3 the value of S3(smallbase + largbase) * height
    VMUL.F32 S3, S3, S5     @Store in S3 the value of S3((smallbase + largbase) * height) * 0.5
    VCVT.F64.F32 D8, S3     @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result         @Loads the result in R0
    BL printf               @Print the result

    POP {LR}                @POP Link Register
    BX LR                   @Branch and exchange to Link Register
   

_exit:
    MOV R7, #1
    SVC 0
