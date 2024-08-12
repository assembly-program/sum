sum: sum.s 
	as sum.s -o sum.o
	ld sum.o -o sum
	rm *.o
