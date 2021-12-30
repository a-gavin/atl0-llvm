/*  global.h:  The global variables!
    For all files except main, these should be extern variables.
*/

/* The name of the source file. */
extern char *src_name;

/* The input and output streams. */
extern FILE *yyin;
extern FILE *yyout;
extern FILE *asm_out;

/* Option switches. */
extern bool debug;
extern bool list_src;

/* Set to true if an error was found. */
extern bool had_errors;

/* Variables for the Scanner.  (You may want more.) */
extern int line_no;