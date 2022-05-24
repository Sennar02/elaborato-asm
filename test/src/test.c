#include "test.h"

int
test(int fails[], tTest tests[], int len)
{
    int j = 0;

    for (int i = 0; i < len; ++i)
        if (tests[i]() == 0) fails[j++] = i;

    return j;
}
