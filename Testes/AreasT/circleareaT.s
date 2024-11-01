@ Data Section
.data

.align 4                                                     @Aligned the data to appropriate boundaries.
    radius: .float 2.0                                       @Initialize radius with 2
.align 4
    buffer: .asciz "%f"                                      @Create the buffer to store the value
.align 4
    pi: .single  3.141592653                                 @Declare the value of pi

result:  .asciz "The circle area is: %lf\n"              @String with the answer

.arch armv8-a                                                @Needed to use float values
.section .text
.global main
.arm

main:
    BL _circlearea                   @Calls _circlearea function
    B _exit


_circlearea:   
    PUSH {LR}                        @Push the Link Register value

    LDR R1, =radius                  @Loads the radius value in R1
    VLDR S1, [R1]                    @Loads the value of radius in S1, S because we want float 

    LDR R2, =pi                      @Loads the pi value in R2    
    VLDR S2, [R2]                    @Loads the value of pi in S2, S because we want float 

    VMUL.F32 S1 , S1 , S1            @Store in S1 the value of radius * radius
    VMUL.F32 S1 , S2, S1             @Store in S1 the value of S1(r^2) * pi
    VCVT.F64.F32 D8, S1              @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result                  @Loads the result in R0
    BL printf                        @Print the result

    POP {LR}                         @POP Link Register
    BX LR                            @Branch and exchange to Link Register

_exit:
    MOV R7, #1
    SVC 0
