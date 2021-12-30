#include "defs.h"
#include "global.h"

bool debug, list_src, had_errors = false;
char *src_name = NULL;

int main(int argc, char **argv) {
    src_name = "ex_programs/sample.atl";

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