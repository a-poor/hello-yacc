// Code
%{
package main

import (
    "fmt"
)

%}

// Type defs
%union{
    val int
}

%type <val> expr number

%token <val> DIGIT LETTER

%left '|'
%left '&'
%left '+'  '-'
%left '*'  '/'  '%'
%left UMINUS


%%
// Rules

list	: /* empty */
	| list stat '\n'
	;

stat	:    expr
		{
			fmt.Printf( "%d\n", $1 );
		}
	|    LETTER '=' expr
		{
			fmt.Println("letter = %q\n", $1)
		}
	;

expr	:    '(' expr ')'
		{ $$  =  $2 }
	|    expr '+' expr
		{ $$  =  $1 + $3 }
	|    expr '-' expr
		{ $$  =  $1 - $3 }
	|    expr '*' expr
		{ $$  =  $1 * $3 }
	|    expr '/' expr
		{ $$  =  $1 / $3 }
	|    expr '%' expr
		{ $$  =  $1 % $3 }
	|    expr '&' expr
		{ $$  =  $1 & $3 }
	|    expr '|' expr
		{ $$  =  $1 | $3 }
	|    '-'  expr        %prec  UMINUS
		{ $$  = -$2  }
	|    LETTER
		{ fmt.Println("LETTER = %q\n", $1) }
	|    number
	;

number	:    DIGIT
		{
			$$ = $1;
		}
	|    number DIGIT
		{ $$ = $1 + $2 }
	;

%%
// More code
