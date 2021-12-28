#  This is a makefile for ATL/1.  Phil Nelson
PROG 	= atl0cc
OBJS 	= main.o parse.o scan.o util.o
DERIVED = parse.c scan.c y.tab.h
CC 		= clang++
CFLAGS 	= -g -Wall -Wno-write-strings
LIBS	= -ll
YACC	= byacc

all: $(PROG)

$(PROG): $(OBJS)
	$(CC) -o $(PROG) $(CFLAGS) $(OBJS) $(LIBS)

parse.c: ATL0.y
	$(YACC) -d ATL0.y
	mv y.tab.c parse.c

scan.c: scan.l
	flex scan.l
	mv lex.yy.c scan.c

clean:
	rm -f $(OBJS) atl.out atl.asm .atl.* *~

realclean: clean
	rm -f $(PROG) $(DERIVED)

y.tab.h: ATL0.y parse.c
parse.o: defs.h global.h
scan.o:  y.tab.h 
util.o:  defs.h global.h
main.o:  defs.h global.h
