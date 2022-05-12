#include <stdlib.h>
#include <string.h>
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
    "Valtteri Bottas"
};

/**
 * @brief
 */
typedef struct file
{
    long  size;
    FILE *stream;
    char *body;
}
file_t;

/**
 * @brief
 * @param file
 * @param name
 * @param mode
 */
void
file_open(file_t *file, const char *name, const char *mode);

/**
 * @brief
 * @param file
 * @return long
 */
long
file_size(file_t *file);

/**
 * @brief
 * @param file
 */
void
file_read(file_t *file);

/**
 * @brief
 * @param file
 * @param size
 */
void
file_prep(file_t *file, long size);

/**
 * @brief
 * @param file
 */
void
file_write(file_t *file);

/**
 * @brief
 * @param file
 */
void
file_close(file_t *file);

/**
 * @brief
 * @param arr
 * @param len
 * @param key
 * @return int
 */
extern int
arrnfind(const char **arr, int len, const char *key);

/**
 * @brief
 * @param itext
 * @param otext
 */
extern int
telemetry(char *itext, char *otext);

/**
 * @brief
 * @param argc
 * @param argv
 * @return int
 */
int
main(int argc, char **argv)
{
    file_t ifile = {-1, 0, 0}, ofile = {-1, 0, 0};
    int idx = -2;

    if (argc != 3) {
        fprintf(stderr, "\x1b[1m\x1b[31mE:\x1b[0m Attesi due parametri.\n");
        return -1;
    }

    file_open(&ifile, argv[1], "r");
    file_open(&ofile, argv[2], "w");

    if (ifile.stream != 0 && ofile.stream != 0) {
        file_read(&ifile);
        file_prep(&ofile, ifile.size);

        if (ifile.body != 0 && ofile.body != 0) {
            printf("Telemetry...\n");
            
            idx = telemetry(ifile.body, ofile.body);
            printf("%i\n", idx);
            file_write(&ofile);
        }
    }

    if (ifile.stream == 0 || ifile.body == 0)
        fprintf(stderr, "\x1b[1m\x1b[31mE:\x1b[0m "
            "Lettura del file "
            "\x1b[32m'%s'\x1b[0m "
            "non riuscita.\n", argv[1]);
    if (ofile.stream == 0 || ofile.body == 0)
        fprintf(stderr, "\x1b[1m\x1b[31mE:\x1b[0m "
            "Scrittura sul file "
            "\x1b[32m'%s'\x1b[0m "
            "non riuscita.\n", argv[2]);

    file_close(&ifile);
    file_close(&ofile);
    return 0;
}

void
file_open(file_t *file, const char *name, const char *mode)
{
    if (file != 0 && name != 0 && mode != 0) {
        file->stream = fopen(name, mode);
    }
}

long
file_size(file_t *file)
{
    long pos = -1;

    if (file != 0 && file->stream != 0) {
        fseek(file->stream, 0, SEEK_END);
        pos = ftell(file->stream);
        fseek(file->stream, 0, SEEK_SET);
    }

    return pos;
}

void
file_read(file_t *file)
{
    if (file != 0 && file->stream != 0) {
        file_prep(file, file_size(file));

        if (file->body != 0)
            fread(file->body, 1, file->size, file->stream);
    }
}

void
file_prep(file_t *file, long size)
{
    if (file != 0 && file->stream != 0) {
        file->size = size;
        file->body = calloc(file->size, 1);
    }
}

void
file_write(file_t *file)
{
    if (file != 0 && file->stream != 0 && file->body != 0) {
        fprintf(file->stream, "%s", file->body);
    }
}

void
file_close(file_t *file)
{
    if (file != 0 && file->stream != 0) {
        file->size = -1;
        fclose(file->stream);
        file->stream = 0;
        free(file->body);
        file->body = 0;
    }
}

// void
// telemetry(char *itext, char *otext)
// {
//     char *pilot, *iline;
//     int index = 0, count = 0, idx = 0;

//     pilot = strsep(&itext, "\n");
//     index = arrfind(names, 20, pilot);

//     while (itext != 0) {
//         iline = strsep(&itext, "\n");

//         char *tim = strsep(&iline, ",");
//         char *pil = strsep(&iline, ",");
//         char *vel = strsep(&iline, ",");
//         char *rpm = strsep(&iline, ",");
//         char *tpr = strsep(&iline, ",");

//         if (pil != 0)
//             idx = atoi(pil);
//         else
//             idx = -1;

//         if (idx == index) {
//             count += sprintf(otext + count, "%s,\t%s,\t%s,\t%s\n", tim, vel, rpm, tpr);
//         }
//     }
// }
