#include "array.h"
#include "string.h"

int
array_search(const char **arr, int len, const char *key)
{
    if (arr != 0 && key != 0) {
        for (int i = 0; i < len; i++) {
            if (string_ncmp(key, arr[i], 20) == 0)
                return i;
        }
    }

    return -1;
}
