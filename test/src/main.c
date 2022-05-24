#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "tests.h"

int
main(int argc, const char *argv[])
{
    int fails[7] = {0};

    int res =
        test(fails, (tTest[]) {
            &test_strlen
            }, 1);

    for (int i = 0; i < res; ++i)
        printf("E: %i\n", fails[i]);

    return 0;
}
