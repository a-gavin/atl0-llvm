/* Get the standard definitions and includes. */
#include "defs.h"

/* Variable Definitions ... */
#define MAIN
#include "global.h"

int main(int argc, char **argv) {
    char *src_name = "sample.atl";

    yyin = fopen(src_name, "r");
    if (yyin == NULL) {
        fprintf(stderr, "%s: Could not open %s.\n", argv[0], src_name);
        exit(1);
    }

    yyout = stdout;
    if (list_src)
        fprintf(yyout, "%5d:  ", line_no);

    if (debug)
        printf("Starting parse\n");
    yyparse();

    /* Cleanup */
    fclose(yyin);
}