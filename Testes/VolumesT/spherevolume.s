@ Data Section
.data

.align 4                                                     @Aligned the data to appropriate boundaries.
    radius: .float 21.4                                      @Initialize radius with 21.4
.align 4
    buffer: .asciz "%f"                                      @Create the buffer to store the value
.align 4
    pi: .single  3.141592653                                 @Declare the value of pi
.align 4
    fourdivthree: .single 1.333333333                        @Declare the value of 4/3

result:  .asciz "The sphere volume is: %lf\n"                @String with the answer

.arch armv8-a                                                @Needed to use float values
.section .text
.global main
.arm

main:
    BL _spherevolume                 @Calls _spherevolume function
    B _exit


_spherevolume:   
    PUSH {LR}                        @Push the Link Register value

    LDR R1, =radius
    VLDR S1, [R1]                    @Loads the value of radius in S1, S because we want float 

    LDR R2, =pi                      @Loads the pi value in R2    
    VLDR S2, [R2]                    @Loads the value of pi in S2, S because we want float 

    LDR R3, =fourdivthree            @Loads the fourdivthree value in R2  
    VLDR S3, [R3]                    @Loads the value of fourdivthree in S3, S because we want float 

    VMUL.F32 S4 , S1 , S1            @Store in S4 the value of radius * radius
    VMUL.F32 S1 , S4 , S1            @Store in S1 the value of (radius * radius) * radius
    VMUL.F32 S1, S1, S2              @Store in S1 the value of (radius^3) * pi
    VMUL.F32 S1, S1 , S3             @Store in S1 the value of (radius^3 * pi) * 4/3
    VCVT.F64.F32 D8, S1              @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result                  @Loads the result in R0
    BL printf                        @Print the result

    POP {LR}                         @POP Link Register
    BX LR                            @Branch and exchange to Link Register

_exit:
    MOV R7, #1
    SVC 0
