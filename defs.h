/*  defs.h:  Common definitions and includes for ATL/1.

    Alex Gavin
*/

/* Includes */
#include <ctype.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/* Preprocessor definitions */
#define FALSE 0
#define TRUE 1

/* Global function prototypes. */
/* From scan.c */
int yylex(void);

/* From parse.c */
int yyparse(void);

/* From util.c */
void dump_errors(void);
void yyerror(char *mesg, ...);