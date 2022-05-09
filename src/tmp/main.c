#include <stdio.h>
#include <string.h>
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
    if (argc != 2) {
        return -1;
    }

    printf("%i\n", find(argv[1]));
    return 0;
}
