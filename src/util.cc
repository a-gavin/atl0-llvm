/*  util.c: Utility routines for use with ATL/1.

    Alex Gavin
*/

/* Includes */
#include "defs.h"
#include "global.h"

struct list {
    char *error;
    struct list *next;
};
struct list *first = NULL, *last, *tmp;

/* The standard yyerror routine.  Built with variable number of argumnets.
   Errors are accumulated until the end of the line.  At that point, all
   errors are printed.
*/
void yyerror(char *str, ...) {
    char buff1[256];
    char buff2[256];
    va_list args;

    va_start(args, str);
    sprintf(buff1, "%s:%d: ", src_name, line_no);
    vsprintf(buff2, str, args);
    strcat(buff1, buff2);

    if (list_src) {
        tmp = (struct list *)malloc(sizeof(struct list));
        tmp->error = strdup(buff1);
        tmp->next = NULL;

        if (first == NULL)
            first = tmp;
        else
            last->next = tmp;

        last = tmp;
    } else {
        fprintf(stderr, "%s\n", buff1);
    }

    va_end(args);
    had_errors = true;
}

void dump_errors(void) {
    struct list *temp;

    while (first != NULL) {
        fprintf(stderr, "%s\n", first->error);
        free(first->error);
        temp = first;
        first = first->next;
        free(temp);
    }
}
