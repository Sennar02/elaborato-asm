#include <malloc.h>
#include <string.h>
#include "tests.h"
#include "asm/asm.h"

uint8_t
test_strlen()
{
    uint8_t res[] = {
        asm_strlen("") == 0,
        asm_strlen("ABC") == 3
    };

    for (uint8_t i = 0; i < 2; ++i)
        if (res[i] == 0)
            return 0;

    return 1;
}

uint8_t
test_strncmp()
{
    uint8_t res[] = {
        asm_strncmp("", "ABC", 3) == -65,
        asm_strncmp("ABC", "", 3) == 65,
        asm_strncmp("", "ABC", 0) == -65,
        asm_strncmp("ABC", "", 0) == 65,
        asm_strncmp("A", "ABC", 1) == -66,
        asm_strncmp("ABC", "AB", 3) == 67,
    };

    for (uint8_t i = 0; i < 6; ++i)
        if (res[i] == 0) return 0;

    return 1;
}

uint8_t
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

    uint8_t res[] = {
        asm_strncpy(str[0], "ABC", 0) == 0,
        asm_strncpy(str[1], "ABC", 2) == 2,
        asm_strncpy(str[2], "ABC", 5) == 4
    };

    for (uint8_t i = 0; i < 3; ++i)
        if (res[i] == 0 || strcmp(str[i], val[i]) != 0)
            return 0;

    return 1;
}


uint8_t
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

    uint8_t res[] = {
        asm_strlcpy(str[0], "ABC", 0) == 0,
        asm_strlcpy(str[1], "ABC", 2) == 1,
        asm_strlcpy(str[2], "ABC", 5) == 4
    };

    for (uint8_t i = 0; i < 3; ++i)
        if (res[i] == 0 || strcmp(str[i], val[i]) != 0)
            return 0;

    return 1;
}

uint8_t
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

    uint8_t res[] = {
        asm_strnrev(str[0], 0) == str[0],
        asm_strnrev(str[1], 0) == str[1],
        asm_strnrev(str[2], 1) == str[2],
        asm_strnrev(str[3], 2) == str[3]
    };

    for (uint8_t i = 0; i < 3; ++i)
        if (res[i] == 0 || strcmp(str[i], val[i]) != 0)
            return 0;

    return 1;
}

uint8_t
test_strsep()
{
    return 1;
}

uint8_t
test_strnsep()
{
    return 1;
}

uint8_t
test_strtoi()
{
    int res[] = {
        asm_strtoi("10")        == 10,
        asm_strtoi("2")         == 2,
        asm_strtoi("100")       == 100,
        asm_strtoi("4")         == 4,
    };

    for (uint8_t i = 0; i < 6; ++i)
        if (res[i] == 0)
            return 0;

    return 1;
}

uint8_t
test_select()
{
    int arr[] = {
        10, 100, 1000
    };

    int res[] = {
        asm_select(5, arr, 3)        == 0,
        asm_select(15, arr, 3)       == 1,
        asm_select(100, arr, 3)      == 1,
        asm_select(999, arr, 3)      == 2,
        asm_select(1000, arr, 3)     == 2,
        asm_select(10001, arr, 3)    == 3
    };

    for (uint8_t i = 0; i < 6; ++i)
        if (res[i] == 0)
            return 0;

    return 1;
}

uint8_t
test_arrfind()
{
    const char *arr[] = {
        "Primo", "Esempio",
        "Ciao", "Array"
    };

    int res[] = {
        asm_arrfind(arr, 4, "Primo")    == 0,
        asm_arrfind(arr, 4, "Esempio")  == 1,
        asm_arrfind(arr, 4, "Array")    == 3,
        asm_arrfind(arr, 4, "A")        == -1
    };

    for (uint8_t i = 0; i < 4; ++i)
        if (res[i] == 0)
            return 0;

    return 1;
}
