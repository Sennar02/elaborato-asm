int
strlen(const char *str)
{
    const char *s = str;

    while (*s++ != 0) {}

    return s - str - 1;
}

int
strtoi(const char *str, int base)
{
    int res = 0;

    while (*str >= 48 && *str <= 57)
        res = res * base + *str++ - 48;

    return res;
}

char *
itostr(int num, char *str, int base)
{
    char *s = str;

    if (num != 0) {
        do {
            *s++ = (num % base) + 48;
        }  while (num /= base);
    } else
        *s++ = 48;

    *s = 0;

    strnrev(str, s - str - 1);
    return str;
}

char *
strnrev(char *str, int num)
{
    char *s = str, *d = str + num, c = 0;

    for (; s < d; ++s, --d)
        c = *s, *s = *d, *d = c;

    return str;
}

int
strncmp(const char *str1, const char *str2, int num)
{
    char c1 = 0, c2 = 0;

    while (num-- > 0) {
        c1 = *str1++, c2 = *str2++;

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
strsep(char **ptr, char sep)
{
    char *s = *ptr, *d = *ptr;

    while (*s != 0 && *s != sep)
        ++s;

    if (*s != 0) {
        *s++ = 0;
        *ptr = s;
    } else
        *ptr = 0;

    return d;
}

int
arrfind(const char *arr[], int len, const char *key)
{
    int num = strlen(key) + 1;

    for (int i = 0; i < len; ++i) {
        if (strncmp(key, arr[i], num) == 0)
            return i;
    }

    return -1;
}