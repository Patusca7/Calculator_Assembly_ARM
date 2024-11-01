.section .text
.arch armv8-a
.arm
@ Author Diogo Patusca 23925
@ Date 17/06/2023

@ asks the user for one input value returns input in D0
ask_one:
    PUSH {LR}                        @ Saves curent LR

    LDR R0, =question                @ Loads the question in R0
    BL printf                        @ Prints the question

    LDR R0, =buffer                  @ Loads buffer in R0
    LDR R1, =in                      @ Loads the input value in R1
    BL scanf                         @ Scans the value
    LDR R1, =in
    VLDR D0, [R1]                    @ Loads the value of the input in D0


    POP {LR}                        @ Pops LR so its possible to return to the place where the function was called
    BX LR                           @ Returns to the place from where the funtion as called


@ asks the user for two input values returns inputs in D1, D0
ask_two:
    PUSH {LR}                        @ Saves curent LR

    LDR R0, =question                @Loads the question in R0
    BL printf                        @Prints the question

    LDR R0, =buffer                  @Loads buffer in R0
    LDR R1, =in                      @Loads the input value in R1
    BL scanf                         @Scans the value
    LDR R1, =in
    VLDR D1, [R1]                    @Loads the value of the input in D1

    LDR R0, =question                @Loads the question in R0
    BL printf                        @Prints the question

    LDR R0, =buffer2                 @Loads buffer2 in R0
    LDR R1, =in2                     @Loads the second input value in R1
    BL scanf                         @Scans the value
    LDR R1, =in2
    VLDR D0, [R1]                    @Loads the value of the second input in D0 

    POP {LR}                         @ Pops LR so its possible to return to the place where the function was called
    BX LR                            @ Returns to the place from where the funtion as called


@ asks the user for three input value returns inputs in D2, D1, D0
ask_three:
    PUSH {LR}                        @ Saves curent LR

    LDR R0, =question                @Loads the question in R0
    BL printf                        @Prints the question

    LDR R0, =buffer                  @Loads buffer in R0
    LDR R1, =in                      @Loads the input value in R1
    BL scanf                         @Scans the value
    LDR R1, =in
    VLDR D2, [R1]                    @Loads the value of the input in D2 

    LDR R0, =question                @Loads the question in R0
    BL printf                        @Prints the question

    LDR R0, =buffer2                 @Loads buffer2 in R0
    LDR R1, =in2                     @Loads the value of the second input in R1
    BL scanf                         @Scans the value
    LDR R1, =in2
    VLDR D1, [R1]                    @Loads the value of the second input in D1 

    LDR R0, =question                @Loads the question in R0
    BL printf                        @Prints the question

    LDR R0, =buffer3                 @Loads buffer3 in R0
    LDR R1, =in3                     @Loads the value of the third input in R1
    BL scanf                         @Scans the value
    LDR R1, =in3
    VLDR D0, [R1]                    @Loads the value of the third input in D0

    POP {LR}                         @ Pops LR so its possible to return to the place where the function was called
    BX LR                            @ Returns to the place from where the funtion as called


square_area: @Calculates the area of a square
    MOV R5, LR                       @ Saves curent LR in R5

    LDR R1, =square                  @ Loads square in R1
    LDR R0, =choose                  @ Loads choose in R0
    BL printf                        @ Prints choose with square in terminal

    BL ask_one                       @ Calls ask_one Function 
    VMUL.F64 D8 , D0 , D0            @ Stores in D8 the value of Side*Side
    
    CMP R8, #1                       @ If function as called by another that needs D8 values
    BEQ break                        @ square_area breaks here and the program returns to the previus function throw the value in R5


    B exit_area_calc                      @ Else prints the result on the terminal


rect_area: @calculates the area of a rectangle
    MOV R5, LR                       @ Saves curent LR in R5     

    LDR R1, =rect                    @ Loads rect in R1              
    LDR R0, =choose                  @ Loads choose in R0           
    BL printf                        @ Prints choose with rect in terminal             

    BL ask_two                       @ Calls ask_two Function                    
    VMUL.F64 D8, D0, D1              @ Stores in D8 the value of lenght*width    
                                    
    CMP R8, #1                       @ If function as called by another that needs D8 values     
    BEQ break                        @ rect_area breaks here and the program returns to the previus function throw the value in R5

    B exit_area_calc                      @ Else prints the result on the terminal         


circle_area: @calculates the area of a circle
    MOV R5, LR                      @ Saves curent LR in R5  

    LDR R1, =circle                 @ Loads circle in R1  
    LDR R0, =choose                 @ Loads choose in R0             
    BL printf                       @ Prints choose with circle in terminal

    BL ask_one                      @ Calls ask_one Function

    LDR R9, =pi                      @ Loads the pi value in R9    
    VLDR D1, [R9]                    @ Loads the value of pi in D1 

    VMUL.F64 D2 , D0 , D0            @ Stores in D2 the value of radius * radius
    VMUL.F64 D8 , D1, D2             @ Stores in D8 the value of D2(r^2) * pi

    CMP R8, #1                       @ If function as called by another that needs D8 values      
    BEQ break                        @ circle_area breaks here and the program returns to the previus function throw the value in R5

    B exit_area_calc                      @ Else prints the result on the terminal         


triangle_area: @calculates the area of a triangle
    MOV R5, LR                       @ Saves curent LR in R5 

    LDR R1, =triangle                @ Loads triangle in R1
    LDR R0, =choose                  @ Loads choose in R0         
    BL printf                        @ Prints choose with triangle in terminal

    BL ask_two                       @ Calls ask_two Function

    LDR R9, =half                    @Loads half in R9
    VLDR D2,[R9]                     @Loads half in D2

    VMUL.F64 D0 , D0 , D1            @ Stores in D0 the value of Base*Heigth
    VMUL.F64 D8 , D0, D2             @ Stores in D8 the value of D0(Base*Heigth)*1/2

    CMP R8, #1                       @ If function as called by another that needs D8 values      
    BEQ break                        @ triangle_area breaks here and the program returns to the previus function throw the value in R5

    B exit_area_calc                      @ Else prints the result on the terminal         


trap_area: @calculates the area of a trapeze
    LDR R1, =trap                    @ Loads trap in R1
    LDR R0, =choose                  @ Loads choose in R0                   
    BL printf                        @ Prints choose with trap in terminal

    BL ask_three                     @ Calls ask_three Function

    LDR R9, =half                    @Loads half in R9
    VLDR D5,[R9]                     @Loads half in D5         

    VADD.F64 D3, D1, D2              @Store in D3 the value of smallbase + largbase
    VMUL.F64 D3, D3, D0              @Store in D3 the value of D3(smallbase + largbase) * height
    VMUL.F64 D8, D3, D5              @Store in D8 the value of D3((smallbase + largbase) * height) * 0.5

    B exit_area_calc                      @ prints the result on the terminal         


diamond_area: @calculates the area of a diamond
    LDR R1, =diamond                 @ Loads diamond in R1
    LDR R0, =choose                  @ Loads choose in R0
    BL printf                        @ Prints choose with diamond in terminal

    BL ask_two                       @ Calls ask_two Function

    LDR R9, =half                    @Loads half in R9
    VLDR D2,[R9]                     @Loads half in D2  

    VMUL.F64 D0, D0, D1              @Stores in D0 the value of smalldiag * largdiag
    VMUL.F64 D8, D0, D2              @Stores in D8 the value of D0(smalldiag * largdiag) * 0.5

    B exit_area_calc                      @ prints the result on the terminal

regular_polygon_area: @calculates the area of a regular polygon
    LDR R1, =polygon                 @ Loads polygon in R1
    LDR R0, =choose                  @ Loads choose in R0           
    BL printf                        @ Prints choose with polygon in terminal

    BL ask_three                     @ Calls ask_three Function

    LDR R9, =half                    @ Loads half in R9
    VLDR D3,[R9]                     @ Loads half in D3

    VMUL.F64 D0, D0, D1              @ Stores in D0 the value of number_side * side
    VMUL.F64 D0, D0, D2              @ Stores in D0 the value of (number_side * side)* apothema
    VMUL.F64 D8, D0, D3              @ Stores in D8 the value of (number_side * side* apothema) / 2

    B exit_area_calc                      @ prints the result on the terminal

cube_volume: @calculates the volume of a cube
    MOV R8, #1                       @ Sets R8 to 1 to inform other function that needs the values

    BL square_area                   @ Call square_area funtion values Side = D0, square area = D8 
    VMUL.F64 D0, D8, D0              @ Stores in D0 the value of square area * side

    B exit_vol_calc                  @ prints the result on the terminal

parallelipipedo_volume: @calculates the volume of a parallelipipedo
    MOV R8, #1                       @ Sets R8 to 1 to inform other function that needs the values
    BL rect_area                     @ Call rect_area funtion values rect area = D8 

    LDR R1, =height                  @ Loads height in R1
    LDR R0, =choose                  @ Loads choose in R0
    BL printf                        @ Prints choose with height in terminal

    BL ask_one                       @ Calls ask_one Function

    VMUL.F64 D0, D8, D0              @ Stores in D0 the value of rect area * height

    B exit_vol_calc                  @ prints the result on the terminal


cylinder_volume: @calculates the volume of a cylinder
    MOV R8, #1                       @ Sets R8 to 1 to inform other function that needs the values
    BL circle_area                   @ Calls circle_area funtion values circle area = D8 

    LDR R1, =height                  @ Loads height in R1
    LDR R0, =choose                  @ Loads choose in R0
    BL printf                        @ Prints choose with height in terminal 

    BL ask_one                       @ Calls ask_one Function
    VMUL.F64 D0, D8, D0              @ Stores in D0 the value of circle area * height

    LDR R4, =three                   @ Loads three in R4
    VLDR D2,[R4]                     @ Loads three in D2
    
    CMP R6, #1                       @ If function as called by cone does cone volume  
    VDIVEQ.F64 D0, D0, D2            @ cone volume = cilinder volume/3
    
    B exit_vol_calc                  @ Else prints the result on the terminal


cone_volume: @calculates the volume of a cone
    MOV R6, #1                       @ Moves R6 to 1 to inform cylider_volume to get cone volume
    B cylinder_volume                @ Calls cylinder_volume function


triangle_prism_volume: @calculates the volume of a triangular prism
    MOV R8, #1                       @ Sets R8 to 1 to inform other function that needs the values
    BL triangle_area                 @ Calls triangle_area funtion values triangle area = D8 

    LDR R1, =height                  @ Loads height in R1
    LDR R0, =choose                  @ Loads choose in R0
    BL printf                        @ Prints choose with height in terminal 

    BL ask_one                       @ Calls ask_one Function

    VMUL.F64 D0, D8, D0              @ Stores in D0 the value of triangle area * height

    B exit_vol_calc                  @ prints the result on the terminal

rect_piramid_volume: @calculates the volume of a retangular piramid
    MOV R8, #1                       @ Sets R8 to 1 to inform other function that needs the values
    BL rect_area                     @ Calls triangle_area funtion values rect area = D8 

    LDR R1, =height                  @ Loads height in R1
    LDR R0, =choose                  @ Loads choose in R0
    BL printf                        @ Prints choose with height in terminal 

    BL ask_one                       @ Calls ask_one Function

    LDR R9, =half                    @ Loads half in R9
    VLDR D5,[R9]                     @ Loads half in D3

    VMUL.F64 D0, D8, D0              @ Stores in D0 the value of rect area * height
    VMUL.F64 D0, D0, D5              @ Stores in D0 the value of D0(rect area * height)/2

    B exit_vol_calc                  @ prints the result on the terminal

sphere_volume: @calculates the volume of a sphere
    MOV R8, #1                       @ Sets R8 to 1 to inform other function that needs the values
    BL circle_area                   @ Calls circle_area funtion values circle area = D8, radius = D0

    LDR R9, =three                   @ Loads half in R9
    VLDR D5,[R9]                     @ Loads half in D3

    LDR R9, =four                    @ Loads half in D3
    VLDR D4,[R9]                     @ Loads half in D3

    VMUL.F64 D0, D0, D8              @ Stores in D0 the value of circle area * radius
    VDIV.F64 D1, D4, D5              @ Stores in D1 the value of rect 4/3
    VMUL.F64 D0, D0, D1              @ Stores in D0 the value of D0(circle area * radius)*4/3

    B exit_vol_calc                  @ prints the result on the terminal


exit_area_calc: @ funtion that prints area results
    VMOV R2, R3, D8                  @ Moves D8 to R2, R3 to be printed
    LDR R0, =result                  @ Loads the result in R0
    BL printf                        @ Print the result with D8 value
    B main                           @ Comes back to main


exit_vol_calc: @ function that prints volume results
    VMOV R2, R3, D0                  @ Moves D0 to R2, R3 to be printed
    LDR R0, =result2                 @Loads the result in R0
    BL printf                        @Print the result with D0 value

    MOV R8, #0                       @ clears values used to comunicate between functions
    MOV R6, #0                       @ clears values used to comunicate between functions

    B main                           @ Comes back to main

break:
    MOV LR, R5                       @ Restores Link register value
    BX LR                            @ Branches to LR


@ data section
.data
question: .asciz "Enter value: "      @String with the question
choose: .asciz "Escolhe valor%s"      @String with the question
square: .asciz " do Lado do Quadrado:\n" @String with the square info
circle: .asciz " do Raio do Circulo:\n"  @String with the circle info 
rect: .asciz "es da Largura e Comprimento do Retangulo na respetiva ordem:\n" @String with the rect info
triangle: .asciz "es da Base e da height do Triângulo na respetiva ordem:\n"  @String with the triangle info
trap: .asciz "es da Base Maior, Base Menor e height do Trapezio na respetiva ordem:\n" @String with the trapaze info
diamond: .asciz "es da Diagonal Maior e Menor do Losango na respetiva ordem:\n" @String with the diamond info
polygon: .asciz "es da Apotema, do tamanho do lado e do número de lados na respetiva ordem:\n" @String with the polygon info
height: .asciz " da altura\n"         @String ask for height
.align 4                              @Aligned the data to appropriate boundaries.
    in: .double 0.0                   @Initialize in with 0.0
.align 4                              @Aligned the data to appropriate boundaries.
    buffer: .asciz "%lf"              @Create the buffer to store the value
.align 4                              @Aligned the data to appropriate boundaries.
    in2: .double 0.0                  @Initialize in2 with 0.0
.align 4                              @Aligned the data to appropriate boundaries.
    buffer2: .asciz "%lf"             @Create the buffer2 to store the value
.align 4                              @Aligned the data to appropriate boundaries.
    in3: .double 0.0                  @Initialize in3 with 0.0
.align 4                              @Aligned the data to appropriate boundaries.
    buffer3: .asciz "%lf"             @Create the buffer3 to store the value
.align 4                              @Aligned the data to appropriate boundaries.
    pi: .double 3.141592653           @Declare the value of pi
.align 4                              @Aligned the data to appropriate boundaries.
    half: .double 0.5                 @Constant 0.5
.align 4                              @Aligned the data to appropriate boundaries.
    three: .double 3.0                @Constant 3.0
.align 4                              @Aligned the data to appropriate boundaries.
    four: .double 4.0                 @Constant 4.0

result:  .asciz "A Area é: %lf\n"      @String with the answer for area
result2:  .asciz "O Volume é: %lf\n"   @String with the answer for volume
