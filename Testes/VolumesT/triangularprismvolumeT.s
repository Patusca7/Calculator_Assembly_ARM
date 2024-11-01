@ Data Section
.data

.align 4                                                    @Aligned the data to appropriate boundaries.
    base: .single 1.7                                       @Initialize base with 1.7
.align 4
    buffer: .asciz "%f"                                     @Create the buffer to store the value
.align 4    
    base_height: .single 1.7                                @Initialize base_height with 1.7
.align 4
    half: .single 0.5                                       @Constant 0.5  
.align 4
    height: .single 1.7                                     @Initialize height with 1.7
result:  .asciz "The triangular prism volume is: %lf\n"     @String with the result


.arch armv8-a                                               @Needed to use float numbers
.section .text
.global main
.arm


main:   
    BL _trianglearea        @Calls _trianglearea function
    B _exit

_trianglearea:
    PUSH {LR}               @Push the Link Register value

    LDR R1, =base           @Loads the base value in R1
    VLDR S1, [R1]           @Loads the value of base in S1, S because we want float 

    LDR R1, =base_height    @Loads the base_height value in R1
    VLDR S2, [R1]           @Loads the value of heigth in S2, S because we want float 

    LDR R1, =height         @Loads the height value in R1
    VLDR S5, [R1]           @Loads the value of heigth in S2, S because we want float 

    LDR R1, =half           @Loads half in R1
    VLDR S4,[R1]            @Loads half in S4, S because we want float 

    VMUL.F32 S3 , S1 , S2   @Store in S3 the value of base * heigth
    VMUL.F32 S3, S3, S4     @Store in S3 the value of S3(base * heigth) * 0.5
    VMUL.F32 S3, S3, S5     @Store in S3 the value of S3(base * heigth * 0.5) * height
    VCVT.F64.F32 D8, S3     @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result         @Loads the result in R0
    BL printf               @Print the result

    POP {LR}                @POP Link Register
    BX LR                   @Branch and exchange to Link Register    

_exit:
    MOV R7, #1
    SVC 0
