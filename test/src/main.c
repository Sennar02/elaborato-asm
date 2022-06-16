#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "lib.h"
#include "stream.h"
#include "tests.h"

static const char *names[] = {
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

// Definisce un array di soglie in ordine
// rispetto alle colonne dell'input.
static int tresholds[] = {
    100,  250,   // velocità
    5000, 10000, // giri
    90,   110,   // temperatura
};

// Definisce un array contenente tutti gli output
// possibili dal più piccolo al più grande.
static const char *outputs[] = {
    "LOW", "MEDIUM", "HIGH"
};

int
c_select(int val, int arr[], int len)
{
    for (int i = 0; i < len; ++i)
        if (val <= arr[i]) return i;

    return len;
}

int
c_telemetry_line(const char *arr[], int len, char *dst)
{
    char *d = dst;
    int val = 0, idx = 0, siz = 0;

    // Per tutte e tre le colonne di cui deve stampare.
    for (int i = 0; i < 3; ++i) {
        val = c_strtoi(arr[i + 2], 10);
        // Trova l'indice della stringa da stampare.
        idx = c_select(val, tresholds + i * 2, 2);
        // Accede alla suddetta stringa.
        const char *out = outputs[idx];
        // Calcola la sua lunghezza.
        siz = c_strlen(out);
        // Stampa la stringa in output.
        dst += c_strncpy(dst, out, siz);

        if (i + 1 != 3)
            *dst++ = ',';
        else
            *dst++ = '\n';
    }

    return dst - d;
}

int
c_telemetry(char *src, char *dst)
{
    // Ottiene un puntatore alla prima riga.
    char *lin = c_strsep(&src, '\n');
    // Cerca all'interno dell'array se la prima
    // riga corrisponde ad uno dei piloti.
    int pilot = c_arrfind(names, 20, lin);

    char *arr[5] = {0};

    // Se la ricerca ha avuto successo.
    if (pilot != -1) {
        // Finché la stringa non è stata consumata
        // interamente.
        while (src != 0) {
            // Ottiene un puntatore ad una nuova riga.
            lin = c_strsep(&src, '\n');

            // Se il puntatore è valido e la riga non è
            // vuota.
            if (lin != 0) {
                // Separa la riga 5 token delimitati dalla virgola
                // e li salva nell'array.
                c_strnsep(arr, 5, &lin, ',');

                if (arr[1] != 0) {
                    // Converte il secondo elemento in un intero in base 10.
                    int idx = c_strtoi(arr[1], 10);
                    // Se il valore calcolato è lo stesso del pilota che
                    // si vuole analizzare.
                    if (idx == pilot) {
                        // Calcola e stampa le soglie.
                        dst += c_telemetry_line((const char **) arr, 5, dst);

                        // Aggiorna i valori di max e media...
                        // ??? telemetry_acc(...);
                    }
                }
            }
        }

        // Stampa i valori max e media...
        // ??? telemetry_end(...);
    } else
        return c_strlcpy(dst, "Invalid", 8) == 7;
}

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
            c_telemetry(istr.body, ostr.body);

            stream_write(&ostr);
            stream_close(&istr);
            stream_close(&ostr);
        }
    }

    return 0;
}

// int
// main(int argc, const char *argv[])
// {
//     int fails[7] = {0};

//     int res = test(fails, (tTest[]) {
//             &test_strlen,
//             &test_strncmp,
//             &test_strncpy
//         }, 3);

//     for (int i = 0; i < res; ++i)
//         printf("E: %i\n", fails[i]);

//     return 0;
// }
