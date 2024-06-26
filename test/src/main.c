#include "../../src/asm/library.h"
#include "../../src/telemetry.h"
#include "file.h"
#include "library.h"
#include "telemety.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int
main(int argc, const char *argv[])
{
    file_t *src = 0, *dst = 0;

    if (argc != 3) {
        fprintf(stderr, "\x1b[1m\x1b[31mE:\x1b[0m Attesi due parametri.\n");
        return -1;
    }

    src = file_create(argv[1], "r");
    dst = file_create(argv[2], "w");

    if (src != 0 && dst != 0) {
        char *str = (char *) file_read(src);
        int   len = strlen(str);
        char *out = calloc(len + 1, 1);

        // printf("\x1b[33mSource\x1b[0m:\n\n%s\n", str);

        if (str != 0 && out != 0) {
            c_telemetry(str, out);

            // printf("\x1b[33mResult\x1b[0m:\n\n%s\n", out);
            file_write(dst, out);
        }
    }

    file_close(src);
    file_close(dst);

    free(src), free(dst);
    return 0;
}
