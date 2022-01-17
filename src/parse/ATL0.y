%{
/*  This is the grammar for 'ATL/0', Another Teaching Language/Level 0.
    This language is designed for use by CS 450, Fall 1992 at Western
    Washington University.

    ATL/0 is a revised version of ATL from Pacific Union College, 1981,
    designed and used for 'Translation Techniques.'

    This is in yacc format.

	Alex Gavin
*/

/* Includes needed.   */
#include "defs.h"
#include "global.h"

int line_no = 1;

/* Move this */
enum ID_Kind {
    ik_List,
    ik_Variable
};

ast::ExprAST *make_id(char *s_value...);
%}

%start program

%union {
    int             i_value;
    char* 	        s_value;
    ast::ExprAST*   ast_expr_value;
}

/* Reserved words for ATL0. */
%token PROGRAM BEGINSY END VARIABLE INTEGER

/*  <--    */
%token ASSIGN

%token STRING INT_CONST
%token<s_value> IDENTIFIER

/* Association */
%left '+' '-'

/* Token types */
%type<ast_expr_value> id_list

%%
program : PROGRAM IDENTIFIER ';' var_decl BEGINSY statement_list END IDENTIFIER '.'
    ;

var_decl : VARIABLE var_dec_list
	  ;

var_dec_list : id_list ':' INTEGER ';' 
	|  var_dec_list id_list ':' INTEGER ';'
	;

id_list	: IDENTIFIER
        { $$ = make_id($1); }
	|  id_list ',' IDENTIFIER
        { $$ = make_id($3, $1); }
	;

statement_list : statement
	| statement_list statement ';'
	;

statement : IDENTIFIER ASSIGN expression
	| error ';' { yyerrok; }
	;

expression : expression '-' expression
	|  expression '+' expression
	|  '-' expression
	|  '(' expression ')'
	|  IDENTIFIER
	|  STRING
	|  INT_CONST
	;

%%

ast::ExprAST *make_id(char *string, ID_Kind kind...) {
    va_list args;
    va_start(args, kind);

    switch (kind) {
        case ik_Variable:
            break;
        case ik_List:
            break;
    }

    va_end(args);

    return nullptr;
}