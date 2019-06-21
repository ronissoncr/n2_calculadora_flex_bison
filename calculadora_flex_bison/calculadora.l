%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "calculadora.tab.h"

%}

%%

[ \t]	;
[0-9]+\.[0-9]+ 	{yylval.valor_float = atof(yytext); return V_FLOAT;}
[0-9]+		{yylval.valor_inteiro = atoi(yytext); return V_INT;}
\n		{return NOVALINHA;}
"+"		{return SOMA;}
"-"		{return SUBTRAI;}
"*"		{return MULTIPLICA;}
"/"		{return DIVIDE;}
"("		{return ABREPARAENTESES;}
")"		{return FECHARPARAENTESES;}
"exit"		{return SAIR;}
"quit"		{return SAIR;}

%%
