%: %.o
	gcc $< -o $@

%.o: %.asm
	as -mfpu=vfp -g $< -o $@