%{
#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
void yyerror(char *);
%}

%option noyywrap

DIGIT    [0-9]
INTEGER  {DIGIT}+
FLOAT    {DIGIT}+"."{DIGIT}*|"."{DIGIT}+
EXPONENT [eE][+-]?{DIGIT}+
NUMBER   {INTEGER}|{FLOAT}{EXPONENT}?
VAR      [a-zA-Z][a-zA-Z0-9]*

%%

[ \t]    ; 
\n       return NEWLINE;
"+"      { return PLUS; }
"-"      { return MINUS; }
"*"      { return TIMES; }
"/"      { return DIVIDE; }
"^"      { return EXP; }
"("      { return LPAREN; }
")"      { return RPAREN; }
"="      { return ASSIGN; }
{NUMBER} {
    yylval.dval = atof(yytext);
    return NUMBER;
}
{VAR}    {
    yylval.sval = strdup(yytext);
    return VARIABLE;
}
.        { 
    fprintf(stderr, "Invalid character: '%c'\n", *yytext); 
    yyerror("Invalid character");
}

%%
