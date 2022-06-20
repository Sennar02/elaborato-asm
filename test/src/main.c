#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "tests.h"

// static const char *names[] = {
//     "Pierre Gasly",
//     "Charles Leclerc",
//     "Max Verstappen",
//     "Lando Norris",
//     "Sebastian Vettel",
//     "Daniel Ricciardo",
//     "Lance Stroll",
//     "Carlos Sainz",
//     "Antonio Giovinazzi",
//     "Kevin Magnussen",
//     "Alexander Albon",
//     "Nicholas Latifi",
//     "Lewis Hamilton",
//     "Romain Grosjean",
//     "George Russell",
//     "Sergio Perez",
//     "Daniil Kvyat",
//     "Kimi Raikkonen",
//     "Esteban Ocon",
//     "Valtteri Bottas"
// };

// static int ths[] = {
//     5000, 10000, // giri
//     90,   110,   // temperatura
//     100,  250,   // velocità
// };

// static char *outputs[] = {
//     "LOW", "MEDIUM", "HIGH"
// };

// int
// c_telemetry_line(int arr[], char *dst)
// {
//     char *d = dst, *out = 0;
//     int idx = 0, siz = 0;

//     for (int i = 0; i < 3; ++i) {
//         idx = c_select(arr[i], ths + i * 2, 2);
//         out = outputs[idx];
//         siz = c_strlen(out);
//         dst += c_strncpy(dst, out, siz);

//         if (i != 2)
//             *dst++ = ',';
//         else
//             *dst++ = '\n';
//     }

//     return dst - d;
// }

// void
// c_telemetry_last(int arr[], char *src, char *dst)
// {
//     int siz = 0;

//     for (int i = 0; i < 4; ++i) {
//         c_itostr(arr[i], src, 10);

//         siz = c_strlen(src);
//         dst += c_strncpy(dst, src, siz);

//         if (i != 3)
//             *dst++ = ',';
//         else
//             *dst++ = '\n';
//     }
// }

// int
// c_max(int val, int max)
// {
//     if (val > max)
//         return val;
//     else
//         return max;
// }

// int
// c_sum(int val, int sum)
// {
//     return val + sum;
// }

// int
// c_mean(int sum, int cnt)
// {
//     return sum / cnt;
// }

// void
// c_telemetry_loop(int idx, char *src, char *dst)
// {
//     char *s = src, *lin = 0, *str[5] = {0};
//     int cnt = 0, pid = 0, val[4] = {0}, tst[4] = {0};

//     for (cnt = 0; src != 0;) {
//         lin = c_strsep(&src, '\n');

//         if (lin != 0)
//             c_strnsep(str, 5, &lin, ',');

//         if (str[1] != 0) {
//             pid = c_strtoi(str[1], 10);

//             if (pid == idx) {
//                 val[0] = c_strtoi(str[3], 10);
//                 val[1] = c_strtoi(str[4], 10);
//                 val[2] = c_strtoi(str[2], 10);

//                 dst += c_strncpy(dst, str[0], 7);
//                 *dst++ = ',';

//                 dst += c_telemetry_line(val, dst);

//                 tst[0] = c_max(tst[0], val[0]);
//                 tst[1] = c_max(tst[1], val[1]);
//                 tst[2] = c_max(tst[2], val[2]);
//                 tst[3] = c_sum(tst[3], val[2]);

//                 cnt += 1;
//             }
//         }
//     }

//     tst[3] = c_mean(tst[3], cnt);
//     c_telemetry_last(tst, s, dst);
// }

// int
// c_telemetry(char *src, char *dst)
// {
//     char *lin = c_strsep(&src, '\n');
//     int idx = c_arrfind(names, 20, lin);

//     if (idx >= 0)
//         c_telemetry_loop(idx, src, dst);
//     else
//         c_strlcpy(dst, "Invalid", 8);

//     return 0;
// }

// int
// main(int argc, const char *argv[])
// {
//     file_t *src = 0, *dst = 0;

//     if (argc != 3) {
//         fprintf(stderr, "\x1b[1m\x1b[31mE:\x1b[0m Attesi due parametri.\n");
//         return -1;
//     }

//     src = file_create(argv[1], "r");
//     dst = file_create(argv[2], "w");

//     if (src != 0 && dst != 0) {
//         char *str = (char*) file_read(src);
//         char *out = malloc( strlen(str) );

//         printf("\x1b[33mSource\x1b[0m:\n\n%s\n", str);

//         if (str != 0 && out != 0) {
//             c_telemetry(str, out);

//             printf("\x1b[33mResult\x1b[0m:\n\n%s\n", out);
//             file_write(dst, out);
//         }
//     }

//     file_close(src);
//     file_close(dst);

//     free(src), free(dst);
//     return 0;
// }

int
main(int argc, const char *argv[])
{
    int fails[7] = {0};

    int res = test(fails, (test_t[]) {
            test_select
        }, 1);

    for (int i = 0; i < res; ++i)
        printf("E: %i\n", fails[i]);

    return 0;
}
