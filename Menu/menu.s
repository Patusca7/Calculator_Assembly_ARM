@ Cod Description Menu that calculates volumes and areas acording to user input
@ Author Diogo Patusca 23925, João Costa 22890
@ Date 17/06/2023

//.include "functions.s" @ place where the menu gets the necessary functions to calculate areas and volumes
.include "functions.s"
.section .text
.global main 
.arm

main:
  @ Prints to the terminal a string of the main menu
  LDR  R0, =menu_main
  BL   printf  

  @ Asks the user for input
  LDR R0, =str_in_s  
  LDR R1, =buffer_in
  BL scanf
  LDR  R2, =buffer_in   
  LDRB R0, [R2, #0]  @ Loads the first byte of the input in R0

  @ Compares the user input and acts accordingly
  CMP R0, #'1'
  BEQ op_area
  CMP R0, #'2'
  BEQ op_volume
  CMP R0, #'0'
  BEQ _exit
  B main

@ Area that manages the area menu
op_area: 
  @ Prints the area menu to the terminal
  LDR  R0, =menu_area   
  BL   printf   

  @ Asks the user for input
  LDR R0, =str_in_s 
  LDR R1, =buffer_in 
  BL scanf
  LDR  R2, =buffer_in
  LDRB R0, [R2, #0]  @ Loads the first byte of the input in R0

  @ Compares the user input and acts accordingly
  CMP R0, #'1' @ calculates square area ask for input and prints the result on the terminal
  BEQ square_area
  
  CMP R0, #'2' @ calculates rectangle area ask for input and prints the result on the terminal
  BEQ rect_area

  CMP R0, #'3' @ calculates circle area ask for input and prints the result on the terminal
  BEQ circle_area

  CMP R0, #'4' @ calculates triangle area ask for input and prints the result on the terminal
  BEQ triangle_area

  CMP R0, #'5' @ calculates trapeze area ask for input and prints the result on the terminal
  BEQ trap_area

  CMP R0, #'6' @ calculates diamond area ask for input and prints the result on the terminal
  BEQ diamond_area

  CMP R0, #'7' @ calculates regular polygon area ask for input and prints the result on the terminal
  BEQ regular_polygon_area

  

  CMP R0, #'0' @ gets back to the main menu
  BEQ main
  B op_area

    
@ Area that manages the volume menu 
op_volume: 
  @ Prints the volume menu to the terminal
  LDR  R0, =menu_volume  
  BL   printf 

  @ Asks the user for input
  LDR R0, =str_in_s 
  LDR R1, =buffer_in 
  BL scanf    
  LDR  R2, =buffer_in
  LDRB R0, [R2, #0]  @ Loads the first byte of the input in R0 

  CMP R0, #'1'  @ calculates cube volume ask for input and prints the result on the terminal
  BEQ cube_volume

  CMP R0, #'2' @ calculates cylinder volume ask for input and prints the result on the terminal
  BEQ cylinder_volume

  CMP R0, #'3' @ calculates cone volume ask for input and prints the result on the terminal
  BEQ cone_volume
  
  CMP R0, #'4' @ calculates paralellipipedo volume ask for input and prints the result on the terminal
  BEQ parallelipipedo_volume

  CMP R0, #'5' @ calculates triangle prism volume ask for input and prints the result on the terminal
  BEQ triangle_prism_volume

  CMP R0, #'6' @ calculates rectangel piramid volume ask for input and prints the result on the terminal
  BEQ rect_piramid_volume

  CMP R0, #'7' @ calculates sphere volume ask for input and prints the result on the terminal
  BEQ sphere_volume

  CMP R0, #'0' @ gets back to the main menu
  BEQ main 
  B op_volume




@ Exits the program  
_exit:
  MOV R7, #1         @ Exit syscall
  SVC 0              @ Invoke

@ data section
.data
buffer_in: .fill 4, 1, 0 @ buffer to put input int
str_in_s: .asciz "%s" @ Data format
@ Main menu
menu_main:      .asciz "\n--------MENU-----------\n 1) Cálculo de áreas\n 2) Cálculo de volumes\n 0) Sair\n-----------------------\n Introduza a sua opção: "
@ Area menu
menu_area:      .asciz "\n--CÁLCULO DE ÁREAS-----\n 1) Quadrado\n 2) Retangulo\n 3) Circulo\n 4) Triângulo\n 5) Trapezio\n 6) Losango\n 7) EXTRA: Poligno Regular\n 0) Sair\n-----------------------\n Introduza a sua opção: "
@ Volume menu
menu_volume:    .asciz "\n-CÁLCULO DE VOLUMES----\n 1) Cubo\n 2) Cilindro\n 3) Cone\n 4) Paralelipipedo\n 5) Prisma Triângular \n 6) Piramide Rectangular\n 7) EXTRA: Esfera\n 0) Sair\n-----------------------\n Introduza a sua opção: " 
