#include <malloc.h>
#include <string.h>
#include "tests.h"
#include "asm/asm.h"

int
test_strlen()
{
    int res[] = {
        asm_strlen("") == 0,
        asm_strlen("ABC") == 3
    };

    for (int i = 0; i < 2; ++i)
        if (res[i] == 0)
            return 0;

    return 1;
}

int
test_strncmp()
{
    int res[] = {
        asm_strncmp("", "ABC", 3) == -65,
        asm_strncmp("ABC", "", 3) == 65,
        asm_strncmp("", "ABC", 0) == -65,
        asm_strncmp("ABC", "", 0) == 65,
        asm_strncmp("A", "ABC", 1) == -66,
        asm_strncmp("ABC", "AB", 3) == 67,
    };

    for (int i = 0; i < 6; ++i)
        if (res[i] == 0) return 0;

    return 1;
}

int
test_strncpy()
{
    char *str[] = {
        calloc(5, 1),
        calloc(5, 1),
        calloc(5, 1)
    };

    char *val[] = {
        "", "AB", "ABC"
    };

    int res[] = {
        asm_strncpy(str[0], "ABC", 0) == 0,
        asm_strncpy(str[1], "ABC", 2) == 2,
        asm_strncpy(str[2], "ABC", 5) == 4
    };

    for (int i = 0; i < 3; ++i)
        if (res[i] == 0 || strcmp(str[i], val[i]) != 0)
            return 0;

    return 1;
}


int
test_strlcpy()
{
    char *str[] = {
        calloc(5, 1),
        calloc(5, 1),
        calloc(5, 1)
    };

    char *val[] = {
        "", "A", "ABC"
    };

    int res[] = {
        asm_strlcpy(str[0], "ABC", 0) == 0,
        asm_strlcpy(str[1], "ABC", 2) == 1,
        asm_strlcpy(str[2], "ABC", 5) == 4
    };

    for (int i = 0; i < 3; ++i)
        if (res[i] == 0 || strcmp(str[i], val[i]) != 0)
            return 0;

    return 1;
}

int
test_strnrev()
{
    char *str[] = {
        strdup(""),
        strdup("ABC"),
        strdup("ABC"),
        strdup("ABC")
    };

    char *val[] = {
        "", "ABC", "BAC", "CBA"
    };

    int res[] = {
        asm_strnrev(str[0], 0) == str[0],
        asm_strnrev(str[1], 0) == str[1],
        asm_strnrev(str[2], 1) == str[2],
        asm_strnrev(str[3], 2) == str[3]
    };

    for (int i = 0; i < 3; ++i)
        if (res[i] == 0 || strcmp(str[i], val[i]) != 0)
            return 0;

    return 1;
}

int
test_strsep()
{
    return 1;
}

int
test_strnsep()
{
    return 1;
}
