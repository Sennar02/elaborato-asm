#include "string.h"

int
string_len(const char* str)
{
    const char* ptr;

    for (ptr = str; ptr != 0; ++ptr)
        if (*ptr == '\0')
            return ptr - str;

    return 0;
}

int
string_ncmp(const char* str1, const char* str2, int len)
{
    unsigned char chr1 = '\0',
                  chr2 = '\0';

    while (len-- > 0) {
        chr1 = (unsigned char) *str1++;
        chr2 = (unsigned char) *str2++;

        if (chr1 == '\0' || chr1 != chr2)
            return chr1 - chr2;
    }

    return chr1 - chr2;
}
