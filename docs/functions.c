#include "functions.h"

int
strlen(const char *str)
{
    const char *s = str;
    while (*s++ != 0);

    return s - str;
}

int
strtoi(const char *str)
{
    int res = 0;

    while (*str >= 48 && *str <= 57)
        res = res * 10 + *str++ - 48;

    return res;
}

int
strncmp(const char *str1, const char *str2, int num)
{
    unsigned char c1 = 0, c2 = 0;

    while (num-- > 0) {
        c1 = (unsigned char) *str1++;
        c2 = (unsigned char) *str2++;

        if (c1 == 0 || c1 != c2)
            return c1 - c2;
    }

    return c1 - c2;
}

char *
strncpy(const char *src, char *dst, int num)
{
    const char *s = src;
    char *d = dst;

    if (num != 0) {
        while (num-- != 0) {
            if ((*d++ = *s++) == 0)
                break;
        }
    }

    return dst;
}

char *
strlcpy(const char *src, char *dst, int num)
{
    int n = num;
    const char *s = src;
    char *d = dst;

    if (n != 0) {
        while (--n != 0) {
            if ((*d++ = *s++) == 0)
                break;
        }
    }

    if (n == 0 && num != 0)
        *d = 0;

    return dst;
}

char*
strsep(char **strp, char sep)
{
    char *cur = *strp, *res = *strp;

    while (*cur != 0 && *cur != sep)
        ++cur;

    if (*cur != 0) {
        *cur++ = 0;
        *strp = cur;
    } else
        *strp = 0;

    return res;
}

int
arrfind(const char *arr[], int len, const char *key)
{
    int num = c_strlen(key) + 1;

    for (int i = 0; i < len; i++) {
        if (c_strncmp(key, arr[i], num) == 0)
            return i;
    }

    return -1;
}
