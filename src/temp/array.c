#include "array.h"
#include "string.h"

int
array_find(const char **arr, int len, const char *key)
{
    if (arr != 0 && key != 0) {
        int num = string_len(key) + 1;

        for (int i = 0; i < len; i++) {
            if (string_ncmp(key, arr[i], num) == 0)
                return i;
        }
    }

    return -1;
}
