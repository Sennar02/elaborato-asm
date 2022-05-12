// #include <stdlib.h>
// #include <string.h>
#include <stdio.h>

// #define max(a, b) ((a) > (b) ? (a) : (b))

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

// /**
//  * @brief
//  */
// typedef struct file
// {
//     long  size;
//     FILE *stream;
//     char *body;
// }
// file_t;

// /**
//  * @brief
//  * @param file
//  * @param name
//  * @param mode
//  */
// void
// file_open(file_t *file, const char *name, const char *mode);

// /**
//  * @brief
//  * @param file
//  * @return long
//  */
// long
// file_size(file_t *file);

// /**
//  * @brief
//  * @param file
//  */
// void
// file_read(file_t *file);

// /**
//  * @brief
//  * @param file
//  * @param size
//  */
// void
// file_prep(file_t *file, long size);

// /**
//  * @brief
//  * @param file
//  */
// void
// file_write(file_t *file);

// /**
//  * @brief
//  * @param file
//  */
// void
// file_close(file_t *file);

// /**
//  * @brief
//  * @param arr
//  * @param len
//  * @param key
//  * @return int
//  */
// int
// arrfind(const char **arr, int len, const char *key);

// /**
//  * @brief
//  * @param itext
//  * @param otext
//  */
// int
// telemetry(char *itext, char *otext);

// /**
//  * @brief
//  * @param argc
//  * @param argv
//  * @return int
//  */
// int
// main(int argc, char **argv)
// {
//     file_t ifile = {-1, 0, 0}, ofile = {-1, 0, 0};

//     if (argc != 3) {
//         fprintf(stderr, "\x1b[1m\x1b[31mE:\x1b[0m Attesi due parametri.\n");
//         return -1;
//     }

//     file_open(&ifile, argv[1], "r");
//     file_open(&ofile, argv[2], "w");

//     if (ifile.stream != 0 && ofile.stream != 0) {
//         file_read(&ifile);
//         file_prep(&ofile, ifile.size);

//         if (ifile.body != 0 && ofile.body != 0) {
//             telemetry(ifile.body, ofile.body);
//             file_write(&ofile);
//         }
//     }

//     if (ifile.stream == 0 || ifile.body == 0)
//         fprintf(stderr, "\x1b[1m\x1b[31mE:\x1b[0m "
//             "Lettura del file "
//             "\x1b[32m'%s'\x1b[0m "
//             "non riuscita.\n", argv[1]);
//     if (ofile.stream == 0 || ofile.body == 0)
//         fprintf(stderr, "\x1b[1m\x1b[31mE:\x1b[0m "
//             "Scrittura sul file "
//             "\x1b[32m'%s'\x1b[0m "
//             "non riuscita.\n", argv[2]);

//     file_close(&ifile);
//     file_close(&ofile);
//     return 0;
// }

// void
// file_open(file_t *file, const char *name, const char *mode)
// {
//     if (file != 0 && name != 0 && mode != 0) {
//         file->stream = fopen(name, mode);
//     }
// }

// long
// file_size(file_t *file)
// {
//     long pos = -1;

//     if (file != 0 && file->stream != 0) {
//         fseek(file->stream, 0, SEEK_END);
//         pos = ftell(file->stream);
//         fseek(file->stream, 0, SEEK_SET);
//     }

//     return pos;
// }

// void
// file_read(file_t *file)
// {
//     if (file != 0 && file->stream != 0) {
//         file_prep(file, file_size(file));

//         if (file->body != 0)
//             fread(file->body, 1, file->size, file->stream);
//     }
// }

// void
// file_prep(file_t *file, long size)
// {
//     if (file != 0 && file->stream != 0) {
//         file->size = size;
//         file->body = calloc(file->size, 1);
//     }
// }

// void
// file_write(file_t *file)
// {
//     if (file != 0 && file->stream != 0 && file->body != 0) {
//         fprintf(file->stream, "%s", file->body);
//     }
// }

// void
// file_close(file_t *file)
// {
//     if (file != 0 && file->stream != 0) {
//         file->size = -1;
//         fclose(file->stream);
//         file->stream = 0;
//         free(file->body);
//         file->body = 0;
//     }
// }

// int
// arrfind(const char **arr, int len, const char *key)
// {
//     int num = strlen(key) + 1;

//     for (int i = 0; i < len; ++i) {
//         if (strncmp(key, arr[i], num) == 0)
//             return i;
//     }

//     return -1;
// }

// int
// telemetry(char *itext, char *otext)
// {
//     char *pilot = strsep(&itext, "\n");
//     int   pilid = arrfind(names, 20, pilot);
//     int   lines = 0, count = 0;
//     int maxrpm = 0, maxtpr = 0,
//         maxvel = 0, medvel = 0;

//     if (pilid < 0)
//         sprintf(otext, "Invalid.\n");
//     else {
//         while (itext != 0) {
//             char *iline = strsep(&itext, "\n");

//             char *timptr = strsep(&iline, ","),
//                 *pidptr = strsep(&iline, ","),
//                 *velptr = strsep(&iline, ","),
//                 *rpmptr = strsep(&iline, ","),
//                 *tprptr = strsep(&iline, ",");

//             int tim = 0, pid = 0, vel = 0, rpm = 0, tpr = 0;

//             if (pidptr != 0) {
//                 pid = atoi(pidptr);

//                 if (pid == pilid) {
//                     vel = atoi(velptr);
//                     rpm = atoi(rpmptr);
//                     tpr = atoi(tprptr);

//                     maxvel = max(maxvel, vel);
//                     maxrpm = max(maxrpm, rpm);
//                     maxtpr = max(maxtpr, tpr);
//                     medvel += vel;

//                     lines += 1;
//                 }
//             }
//         }

//         medvel /= lines;

//         sprintf(otext + count, "%i, %i, %i, %i\n",
//             maxrpm, maxtpr, maxvel, medvel);
//     }
// }

extern unsigned long
strtoi(const char *str);

int
main(int argc, const char **argv)
{
    const char *arr[] = {
        "12bla", "5bla0", "bla99", "9898bla9999", "429496bla7295"
    };

    for (int i = 0; i < 5; ++i)
        printf("%s => %lu\n", arr[i], strtoi(arr[i]));

    return 0;
}
