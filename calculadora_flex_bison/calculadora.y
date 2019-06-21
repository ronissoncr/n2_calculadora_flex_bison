%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int valor_inteiro;
	float valor_float;
}

%token<valor_inteiro> V_INT
%token<valor_float> V_FLOAT
%token SOMA SUBTRAI MULTIPLICA DIVIDE ABREPARAENTESES FECHARPARAENTESES
%token NOVALINHA SAIR
%left SOMA SUBTRAI
%left MULTIPLICA DIVIDE

%type<valor_inteiro> expressao
%type<valor_float> expressao_mista   


%start calculadora

%%

calculadora:
	   | calculadora line
;

line: NOVALINHA
    | expressao_mista NOVALINHA { printf("\tResultado: %f\n", $1);}
    | expressao NOVALINHA { printf("\tResultado: %i\n", $1); }
    | SAIR NOVALINHA { printf("fim!\n"); exit(0); }
;

expressao_mista: V_FLOAT                 		 { $$ = $1; }
	  | expressao_mista SOMA expressao_mista	 { $$ = $1 + $3; }
	  | expressao_mista SUBTRAI expressao_mista	 { $$ = $1 - $3; }
	  | expressao_mista MULTIPLICA expressao_mista { $$ = $1 * $3; }
	  | expressao_mista DIVIDE expressao_mista	 { $$ = $1 / $3; }
	  | ABREPARAENTESES expressao_mista FECHARPARAENTESES		 { $$ = $2; }
	  | expressao SOMA expressao_mista	 	 { $$ = $1 + $3; }
	  | expressao SUBTRAI expressao_mista	 	 { $$ = $1 - $3; }
	  | expressao MULTIPLICA expressao_mista 	 { $$ = $1 * $3; }
	  | expressao DIVIDE expressao_mista	 { $$ = $1 / $3; }
	  | expressao_mista SOMA expressao	 	 { $$ = $1 + $3; }
	  | expressao_mista SUBTRAI expressao	 	 { $$ = $1 - $3; }
	  | expressao_mista MULTIPLICA expressao 	 { $$ = $1 * $3; }
	  | expressao_mista DIVIDE expressao	 { $$ = $1 / $3; }
	  | expressao DIVIDE expressao		 { $$ = $1 / (float)$3; }
;

expressao: V_INT				{ $$ = $1; }
	  | expressao SOMA expressao	{ $$ = $1 + $3; }
	  | expressao SUBTRAI expressao	{ $$ = $1 - $3; }
	  | expressao MULTIPLICA expressao	{ $$ = $1 * $3; }
	  | ABREPARAENTESES expressao FECHARPARAENTESES		{ $$ = $2; }
;

%%

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
