#include "library.h"
#include "telemetry.h"
#include <stdio.h>

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
    "Valtteri Bottas",
};

static int treshs[] = {
    5000, // giri
    10000,
    90, // temperatura
    110,
    100, // velocità
    250,
};

static const char *levels[] = {
    "LOW",
    "MEDIUM",
    "HIGH",
};

int
c_telemetry_line(int arr[], char *dst)
{
    char       *d   = dst;
    const char *out = 0;
    int         idx = 0, siz = 0;

    for (int i = 0; i < 3; ++i) {
        idx = c_select(arr[i], treshs + i * 2, 2);
        out = levels[idx];
        siz = c_strlen(out);
        dst += c_strncpy(dst, out, siz);

        if (i != 2)
            *dst++ = ',';
        else
            *dst++ = '\n';
    }

    return dst - d;
}

void
c_telemetry_last(int arr[], char *src, char *dst)
{
    int siz = 0;

    for (int i = 0; i < 4; ++i) {
        c_itostr(arr[i], src);

        siz = c_strlen(src);
        dst += c_strncpy(dst, src, siz);

        if (i != 3)
            *dst++ = ',';
        else
            *dst++ = '\n';
    }
}

void
c_telemetry_loop(int idx, char *src, char *dst)
{
    char *s = src, *lin = 0, *str[5] = {0};
    int   cnt = 0, pid = 0, val[4] = {0}, tst[4] = {0};

    for (cnt = 0; src != 0;) {
        lin = c_strsep(&src, '\n');

        if (lin != 0)
            c_strnsep(str, 5, &lin, ',');

        if (str[1] != 0) {
            pid = c_strtoi(str[1]);

            if (pid == idx) {
                val[0] = c_strtoi(str[3]);
                val[1] = c_strtoi(str[4]);
                val[2] = c_strtoi(str[2]);

                dst += c_strncpy(dst, str[0], c_strlen(str[0]));
                *dst++ = ',';

                dst += c_telemetry_line(val, dst);

                tst[0] = c_max(tst[0], val[0]);
                tst[1] = c_max(tst[1], val[1]);
                tst[2] = c_max(tst[2], val[2]);
                tst[3] += val[2];

                cnt += 1;
            }
        }
    }

    tst[3] = tst[3] / cnt;
    c_telemetry_last(tst, s, dst);
}

int
c_telemetry(char *src, char *dst)
{
    char *lin = c_strsep(&src, '\n');
    int   idx = c_arrfind(names, 20, lin);

    if (idx >= 0)
        c_telemetry_loop(idx, src, dst);
    else
        c_strlcpy(dst, "Invalid\n", 9);

    return 0;
}
