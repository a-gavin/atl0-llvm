%{
/*  scan.l:  An ATL/1 scanner.  10/7/97, updated 03/19/21
  
	Alex Gavin
*/

#include "defs.h"
#include "global.h"
#include "y.tab.h"

#define YY_NO_UNPUT

char get_input();

%}

%%
%{
	/* Scanner rules */
%}
[ \t]+ { /* ignore spaces and tabs */
    if (list_src) ECHO;}

\n { 
    line_no++; 
    dump_errors();
}

%{
	/* Integer constants */
%}
[0-9]+ {
    if (list_src) ECHO;
    yylval.i_value = atoi(yytext); 
    return(INT_CONST);}

%{
	/* Strings */
%}
\"\" {
    if (list_src) ECHO;
    yylval.s_value = strdup(yytext);
    return(STRING);
}

%{
	/* Reserved words */
%}
(?i:end) { 
    if (list_src) ECHO;
    return(END);
}

(?i:begin) { 
    if (list_src) ECHO;
    return(BEGINSY);
}

(?i:program) { 
    if (list_src) ECHO;
    return(PROGRAM);
}

(?i:variable) { 
    if (list_src) ECHO;
    return(VARIABLE);
}

(?i:integer) { 
    if (list_src) ECHO;
    return(INTEGER);
}

\<-- {
    if (list_src) ECHO;
    return(ASSIGN);
}

%{
	/* Remaining operators, punctuation */
%}
"+"|"-"|"("|")"|";"|","|":"|"." {
    if (list_src) ECHO;
    return((int)yytext[0]);
}

%{
	/* Identifiers */
%}
[a-zA-Z][a-zA-Z0-9_]* {
  if (list_src) ECHO;
  yylval.s_value = strdup(yytext);
  return(IDENTIFIER);
}

%{
/* Default rule, should be last to guarantee a match. */
%}
. {
    if (list_src) ECHO;
    if (yytext[0] < ' ')
        yyerror ("illegal character: ^%c",yytext[0] + '@');
    else {
        if (yytext[0] > '~') {
            yyerror ("illegal character: \\%3d", (int) yytext[0]);
        } else {
            yyerror ("illegal character: %s",yytext);
        }
    }
}
%%

#include <stdio.h>

extern YYSTYPE yylval;

char get_input()
{
    char c;

    c = input();
    if (c == '\n') {
      line_no++;
      if (list_src) fprintf (yyout, "\n");
      //dump_errors ();
      if (list_src) fprintf (yyout, "%5d:  ", line_no);
    } else {
        if (list_src) fprintf (yyout, "%c", c);
    }

    return c;
}
