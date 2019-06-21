all: calculadora

calculadora.tab.c calculadora.tab.h:	calculadora.y
	bison -d calculadora.y

lex.yy.c: calculadora.l calculadora.tab.h
	flex calculadora.l

calculadora: lex.yy.c calculadora.tab.c calculadora.tab.h
	gcc -o calculadora calculadora.tab.c lex.yy.c

clean:
	rm calculadora calculadora.tab.c lex.yy.c calculadora.tab.h
