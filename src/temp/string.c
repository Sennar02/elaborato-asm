#include "string.h"

int
string_len(const char *str)
{
    const char *end = str;

    while (*end != 0)
        ++end;

    return end - str;
}

int
string_ncmp(const char *str1, const char *str2, int num)
{
    unsigned char chr1 = 0, chr2 = 0;

    while (num-- > 0) {
        chr1 = (unsigned char) *str1++;
        chr2 = (unsigned char) *str2++;

        if (chr1 == 0 || chr1 != chr2)
            return chr1 - chr2;
    }

    return chr1 - chr2;
}

char*
string_sep(char **strp, char sep)
{
    char *end = *strp, *beg = *strp;

    while (*end != 0 && *end != sep)
        ++end;

    if (*end != 0) {
        *end++ = 0;
        *strp = end;
    } else {
        *strp = 0;
    }

    return beg;
}
