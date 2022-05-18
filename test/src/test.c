#include <stdio.h>
#include <string.h>
#include "library.h"
#include "library.asm.h"
#include "test.h"

void
t_strlen(const char *names[], int lenght)
{
    int len_names[20] = {-1};       // Lunghezza array names
    int len_str_null = -1;          // Lunghezza stringa nulla
    const char str_null[] = "";     // Stringa nulla

    // Calcolo della lunghezza stringa nulla
    len_str_null = asm_strlen(str_null);

    // Calcolo della lunghezza delle stringhe in names
    for (int i = 0; i < lenght; i++) {
        len_names[i] = asm_strlen(names[i]);
    }

    // Stampa lunghezza stringa nulla
    printf("La lunghezza di '%s' è %i\n", str_null, len_str_null);

    // Stampa lunghezza delle stringhe in names
    for (int i = 0; i < lenght; i++) {
        printf("La lunghezza di '%s' è %i\n", names[i], len_names[i]);
    }
}

void
t_strtoi(void)
{
    const char *str[] = {       // Array di stringhe
        "",
        "1234567890  ",
        "  1234567890",
        "A123B123C123",
        "123A123B123C",
        "123 123 123 ",
        "A 1 2 3 4 5 ",
        "-1          "
    };

    // Conversione da stringa a numero
    for (int i = 0; i < 8; i++) {
        int res = asm_strtoi(str[i], 10);
        printf("'%s' -> '%i'\n", str[i], res);
    }
}

void
t_itostr(void)
{
    int num[4] = {              // Array di interi
        0,
        -1,
        1,
        123456789
    };
    char str_num[10] = {0};     // Stringa temporanea

    // Conversione da intero a stringa
    for (int i = 0; i < 4; i++) {
        printf("%i -> '%s'\n", num[i], asm_itostr(num[i], str_num, 10));
    }
}

void
t_strnrev(void)
{
    char str1[] = "Pippo";      // Stringa prova 1
    char str2[] = "12345";      // Stringa prova 2
    char str3[] = "Ugo";        // Stringa prova 3
    char *strB[3] = {           // Stringhe di backup
        "Pippo",
        "12345",
        "Ugo"
    };

    // Ribaltamento stringa
    printf("'%s' -> '%s'\n", strB[0], asm_strnrev(str1, 2));
    printf("'%s' -> '%s'\n", strB[1], asm_strnrev(str2, 1));
    printf("'%s' -> '%s'\n", strB[2], asm_strnrev(str3, 0));
}

void
t_strncmp(void)
{
    const char *str[4] = {      // Array di stringe
        "",
        "Pippo",
        " Pippo",
        "Lando Norris"
    };

    // Comparazione delle stringhe
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            int len = asm_strlen(str[j]);
            printf("'%s' == '%s' -> %i\n", str[i], str[j], asm_strncmp(str[i], str[j], len));
        }
    }
}

void
t_strncpy(void)
{
    char *src = strdup("prova");    // Stringa di prova
    char *dst = strdup("?????");    // Stringa di destinazione
    int  len  = 0;                  // Lunghezza

    // Stampa delle due stringhe
    printf("'%s' -> '%s'\n", src, dst);

    // Copia dei primi due caratteri della prima stringa
    len = asm_strncpy(dst, src, 2);

    // Stampa delle due stringhe
    printf("'%s' -> '%s'\n\n", src, dst);

    // Stampa della stringa destinazione
    printf("'%s' + %i = '%s'\n\n", dst, len, dst + len);

    // Stampa dei valori della stringa di destinazione
    for (int i = 0; i < 6; ++i)
        printf("%03i, %c\n", dst[i], dst[i]);
}

void
t_strlcpy(void)
{
    char *src = strdup("prova");    // Stringa di prova
    char *dst = strdup("?????");    // Stringa di destinazione
    int  len  = 0;                  // Lunghezza

    // Stampa delle due stringhe
    printf("'%s' -> '%s'\n", src, dst);

    // Copia dei primi due caratteri della prima stringa
    len = asm_strlcpy(dst, src, 2);

    // Stampa delle due stringhe
    printf("'%s' -> '%s'\n\n", src, dst);

    // Stampa della stringa destinazione
    printf("'%s' + %i = '%s'\n\n", dst, len, dst + len);

    // Stampa dei valori della stringa di destinazione
    for (int i = 0; i < 6; ++i)
        printf("%03i, %c\n", dst[i], dst[i]);
}

void
t_strsep(char *itext)
{
    // Stampa dell'id pilota
    printf("'%s'\n", asm_strsep(&itext, '\n'));

    // Stampa di tutti i primi 10 valori separati dalla virgola
    for (int i = 0; i < 5; i++) {
        printf("'%s'\n", asm_strsep(&itext, ','));
    }
}

void
t_strnsep(char *itext)
{
    int toks = 0;
    char *strings[5] = {0};

    asm_strsep(&itext, '\n');

    while (itext != 0) {
        char *iline = asm_strsep(&itext, '\n');

        if (iline != 0 && *iline != 0) {
            toks = asm_strnsep(strings, 5, &iline, ',');

            printf("Token: %i\n\t", toks);
            for (int i = 0; i < 5; ++i)
                printf("[%8s],\t", strings[i]);
            printf("\n");
        }
    }
}

void
t_arrfind(const char *names[], int lenght)
{
    int poasm_str_err[4] = {-2};  // Array contenente gli indici
    const char *str[4] = {      // Array contenente le stringhe
        "",
        "Pippo",
        " Pippo",
        "Lando Norris"
    };

    // Stampa dell'array di giocatori
    print_str_arr(names, lenght);
    printf("\n\n");

    // Calcolo della posizione
    for (int i = 0; i < 4; i++) {
        poasm_str_err[i] = asm_arrfind(names, lenght , str[i]);
        printf("'%s' -> %i\n", str[i], poasm_str_err[i]);
    }
}

void
testing(char *itext, char *otext, const char *names[], int lenght)
{
    printf("\t\t\t\t\t\t\t\tTESTING!!!!!!\n");
    printsep();

    // Test strlen
    printf("\nIn esecuzione strlen()!\n\n");
    t_strlen(names, lenght);
    printsep();

    // Test strtoi
    printf("\nIn esecuzione strtoi()!\n\n");
    t_strtoi();
    printsep();

    // Test itostr
    printf("\nIn esecuzione itostr()!\n\n");
    t_itostr();
    printsep();

    // Test strnrev
    printf("\nIn esecuzione strnrev()!\n\n");
    t_strnrev();
    printsep();

    // Test strncmp
    printf("\nIn esecuzione strncmp()!\n\n");
    t_strncmp();
    printsep();

    // Test strncpy
    printf("\nIn esecuzione strncpy()!\n\n");
    t_strncpy();
    printsep();

    // Test strlcpy
    printf("\nIn esecuzione strlcpy()!\n\n");
    t_strlcpy();
    printsep();

    // Test strsep
    printf("\nIn esecuzione strsep()!\n\n");
    t_strsep(strdup(itext));
    printsep();

    // Test strlsep
    printf("\nIn esecuzione strnsep()!\n\n");
    t_strnsep(strdup(itext));
    printsep();

    // Test arrfind
    printf("\n\nIn esecuzione arrfind()!\n\n");
    t_arrfind(names, lenght);
    printsep();
}

// --------------
// FUNZIONI EXTRA
// --------------

void
printsep(void)
{
    // Stampa del separatore
    printf("\n---------------------------------------------------------------------------------\n\n");
}

void
print_str_arr(const char *str[], int dim) {
    // Stampa dell'array di stringhe
    for (int i = 0; i < dim; i++) {
        printf("%i -> '%s'\n", i, str[i]);
    }
}
