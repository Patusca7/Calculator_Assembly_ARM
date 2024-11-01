@ Data Section
.data
question: .asciz "Enter the value of the radius \n"          @String with the question
question2: .asciz "Enter the value of the height \n"          @String with the question2

.align 4
    height: .float 0.0                                       @Initialize height with 0.0
.align 4                                                     @Aligned the data to appropriate boundaries.
    radius: .float 0.0                                       @Initialize radius with 0.0
.align 4
    buffer: .asciz "%f"                                      @Create the buffer to store the value
.align 4
    pi: .single  3.141592653                                 @Declare the value of pi
.align 4
    three: .single 3                                         @Constant three
result:  .asciz "The cylinder volume is: %lf\n"              @String with the answer

.arch armv8-a                                                @Needed to use float values
.section .text
.global main
.arm

main:
    BL _cylindervolume                   @Calls _cylindervolume function
    B _exit


_cylindervolume:   
    PUSH {LR}                        @Push the Link Register value
    LDR R0, =question                @Loads the question in R0
    BL printf                        @Prints the question

    LDR R0, =buffer                  @Loads buffer in R0
    LDR R1, =radius                  @Loads the radius value in R1
    BL scanf                         @Scans the value
    
    LDR R0, =question2               @Loads the question2 in R0
    BL printf                        @Prints the question2

    LDR R0, =buffer                  @Loads buffer in R0
    LDR R1, =height                  @Loads the height value in R1
    BL scanf                         @Scans the value

    LDR R1, =height
    VLDR S3, [R1]                    @Loads the value of height in S3, S because we want float 

    LDR R1, =radius
    VLDR S1, [R1]                    @Loads the value of radius in S1, S because we want float 

    LDR R2, =pi                      @Loads the pi value in R2    
    VLDR S2, [R2]                    @Loads the value of pi in S2, S because we want float 

    LDR R3, =three                   @Loads the three value in R3
    VLDR S4, [R3]                    @Loads the value of three in S4, S because we want float 

    VMUL.F32 S1 , S1 , S1            @Store in S1 the value of radius * radius
    VMUL.F32 S1 , S2, S1             @Store in S1 the value of S1(r^2) * pi
    VMUL.F32 S1, S1, S3              @Store in S1 the value of S1((r^2) * pi) * height
    VDIV.F32 S1, S1 , S4             @Store in S1 the value of S1 ((r^2) * pi * height)/3
    VCVT.F64.F32 D8, S1              @Convert into 64bits so we can print the result
    VMOV R1, R2, D8

    LDR R0, =result                  @Loads the result in R0
    BL printf                        @Print the result

    POP {LR}                         @POP Link Register
    BX LR                            @Branch and exchange to Link Register

_exit:
    MOV R7, #1
    SVC 0
