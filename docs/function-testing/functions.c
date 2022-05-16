#include "functions.h"

int
c_strlen(const char *str)
{
    const char *s = str;

    while (*s++ != 0);

    return s - str - 1;
}

int
c_strtoi(const char *str, int base)
{
    int res = 0;

    while (*str >= 48 && *str <= 57)
        res = res * base + *str++ - 48;

    return res;
}

char *
c_itostr(unsigned int   num, char *str, int base)
{
    char *s = str;

    if (num != 0) {
        do {
            *s++ = (num % base) + 48;
        }  while (num /= base);
    } else
        *s++ = 48;

    *s = 0;

    c_strnrev(str, s - str - 1);
    return str;
}

char *
c_strnrev(char *str, int num)
{
    char *s = str, *d = str + num, c = 0;

    for (; s < d; ++s, --d)
        c = *s, *s = *d, *d = c;

    return str;
}

int
c_strncmp(const char *str1, const char *str2, int num)
{
    unsigned char c1 = 0, c2 = 0;

    do {
        c1 = (unsigned char) *str1++;
        c2 = (unsigned char) *str2++;

        if (c1 == 0 || c1 != c2)
            return c1 - c2;
    } while (num-- > 0);

    return c1 - c2;
}

int
c_strncpy(char *dst, const char *src, int num)
{
    const char *s = src;
    char *d = dst;

    while (num-- > 0) {
        if ((*d++ = *s++) == 0)
            break;
    }

    return d - dst;
}

int
c_strlcpy(char *dst, const char *src, int num)
{
    int n = num;
    const char *s = src;
    char *d = dst;

    while (--num > 0) {
        if ((*d++ = *s++) == 0)
            break;
    }

    if (n > 0 && num == 0)
        *d = 0;

    return d - dst;
}

char*
c_strsep(char **strp, char sep)
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
c_arrfind(const char *arr[], int len, const char *key)
{
    int num = c_strlen(key) + 1;

    for (int i = 0; i < len; ++i) {
        if (c_strncmp(key, arr[i], num) == 0)
            return i;
    }

    return -1;
}
