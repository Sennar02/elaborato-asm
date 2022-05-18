#include <stdio.h>
#include "stream.h"
#include "test.h"

#define DIM_NAMES 20

static const char *names[DIM_NAMES] = {
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
main(int argc, const char *argv[])
{
    stream_t istr = {-1}, ostr = {-1};

    if (argc != 3) {
        fprintf(stderr, "\x1b[1m\x1b[31mE:\x1b[0m Attesi due parametri.\n");
        return -1;
    }

    stream_open(&istr, argv[1], "r");
    stream_open(&ostr, argv[2], "w");

    if (istr.file != 0 && ostr.file != 0) {
        stream_read(&istr);
        stream_prep(&ostr, istr.size);

        if (istr.body != 0 && ostr.body != 0) {
            // Call Testing
            testing(istr.body, ostr.body, names, DIM_NAMES);

            stream_write(&ostr);
            stream_close(&istr);
            stream_close(&ostr);
        }
    }

    return 0;
}

int
c_telemetry(char *istr, char *ostr)
{
    char *iline = c_strsep(&istr, '\n');
    int pilot = c_arrfind(names, 20, iline);

    char *itoks[5] = {0};

    if (pilot != -1) {
        while (istr != 0) {
            iline = c_strsep(&istr, '\n');

            if (*iline != 0) {
                c_strnsep(itoks, 5, &iline, ',');
                int index = c_strtoi(itoks[1], 10);

                if (index == pilot) {
                    // Calcolare le soglie e stamparle...
                    // Calcolare valori max e media...
                    // telemetry_line(&ostr, itoks, 5);
                    // telemetry_acc(...);
                }
            }
        }

        // Stampare valori max e media...
        // telemetry_end(...);
    } else
        return c_strlcpy(ostr, "Invalid", 8) == 7;
}
