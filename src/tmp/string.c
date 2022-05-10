#include "string.h"

int
string_len(const char *str)
{
    const char *end;

    for (end = str; end != 0; ++end)
        if (*end == 0) return end - str;

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
    char *end = 0, *beg = 0;

    if (strp != 0 && *strp != 0) {
        beg = end = *strp;

        for (; end != 0 && *end != 0; ++end)
            if (*end == sep) break;

        if (*end != 0) {
            *end++ = 0;
            *strp = end;
        } else {
            *strp = 0;
        }
    }

    return beg;
}
