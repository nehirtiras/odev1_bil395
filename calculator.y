%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <ctype.h>


void yyerror(char *);
int yylex(void);

struct symbol {
    char *name;
    double value;
} symbol[100];

int count = 0;

struct symbol *lookup(char *name) {
    for (int i = 0; i < count; i++)
        if (strcmp(symbol[i].name, name) == 0)
            return &symbol[i];
    
    symbol[count].name = strdup(name);
    symbol[count].value = 0;
    return &symbol[count++];
}

%}

%union {
    double dval;
    char *sval;
}

%token <dval> NUMBER
%token <sval> VARIABLE
%token NEWLINE
%token PLUS MINUS TIMES DIVIDE EXP
%token LPAREN RPAREN
%token ASSIGN

%type <dval> expr

%left PLUS MINUS
%left TIMES DIVIDE
%left EXP
%left UMINUS

%%

input: 
    | input line
    ;

line: NEWLINE
    | expr NEWLINE { printf("= %g\n", $1); }
    | VARIABLE ASSIGN expr NEWLINE { 
        lookup($1)->value = $3; 
        printf("Assigned %g to %s\n", $3, $1); 
        free($1); 
      }
    ;

expr: NUMBER { $$ = $1; }
    | VARIABLE { $$ = lookup($1)->value; free($1); }
    | expr PLUS expr { $$ = $1 + $3; }
    | expr MINUS expr { $$ = $1 - $3; }
    | expr TIMES expr { $$ = $1 * $3; }
    | expr DIVIDE expr { 
        if ($3 == 0.0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
      }
    | expr EXP expr { $$ = pow($1, $3); }
    | MINUS expr %prec UMINUS { $$ = -$2; }
    | LPAREN expr RPAREN { $$ = $2; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("***CALCULATOR***\n");
    yyparse();
    return 0;
}


