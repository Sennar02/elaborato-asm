#include "string.h"
#include <stdio.h>

int
string_len(const char *str)
{
    const char *chrp;

    for (chrp = str; chrp != 0; ++chrp)
        if (*chrp == 0) return chrp - str;

    return 0;
}

int
string_ncmp(const char *str1, const char *str2, int len)
{
    unsigned char chr1 = 0, chr2 = 0;

    while (len-- > 0) {
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
    char *chrp = 0, *begp = 0;

    if (strp != 0 && *strp != 0) {
        chrp = *strp;
        begp = *strp;

        while (chrp != 0 && *chrp != 0 && *chrp != sep)
            ++chrp;

        if (*chrp != 0) {
            *chrp = 0;
            *strp = ++chrp;
        } else {
            *strp = 0;
        }
    }

    return begp;
}
