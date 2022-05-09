#include <stdio.h>
#include <malloc.h>
#include "string.h"

const char* names[] = {
    "Pierre Gasly",
    "Charles Leclerc",
    "Max Verstappen",
    "Lando Norris",
    "Sebastian Vettel",
    "Daniel Ricciardo",
    "Lance Stroll",
    "Carlos Sainz",
    "Antonio Giovinazzi",
    "Kevin Magnussen",
    "Alexander Albon",
    "Nicholas Latifi",
    "Lewis Hamilton",
    "Romain Grosjean",
    "George Russell",
    "Sergio Perez",
    "Daniil Kvyat",
    "Kimi Raikkonen",
    "Esteban Ocon",
    "Valtteri Bottas"
};

int
find(const char* name)
{
    int len1 = 0, len2 = 0;

    if (name) {
        len1 = string_len(name);

        for (int i = 0; i < 20; ++i) {
            len2 = string_len(names[i]);

            if (len1 == len2 && string_ncmp(name, names[i], len1) == 0) {
                return i;
            }
        }
    }

    return -1;
}

int
main(int argc, const char** argv)
{
    FILE *infile = fopen("input.txt", "r");
    long  insize = 0;
    char *string = 0;

    if (infile != 0) {
        fseek(infile, 0, SEEK_END);
        insize = ftell(infile);
        string = calloc(insize, sizeof(char));
        fseek(infile, 0, SEEK_SET);

        if (string != 0) {
            fread(string, sizeof(char), insize, infile);
            fclose(infile);
        }
    }

    for (int i = 0; string != 0; i++) {
        char *line = string_sep(&string, 10);

        if (i == 0) {
            fprintf(stdout, "Index: %u\n", find(line));
        }

        while (line != 0) {
            char *item = string_sep(&line, ',');

            if (item != 0)
                fprintf(stdout, "[%s]", item);
        }
        fprintf(stdout, "\n");


        if (line != 0) {
            fprintf(stdout, "\"%s\"\n", line);
        }
    }
    fprintf(stdout, "\n");

    return 0;
}
