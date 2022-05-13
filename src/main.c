#include <malloc.h>
#include <string.h>
#include <stdio.h>

typedef struct stream
{
    long  size;
    FILE *file;
    char *body;
}
stream_t;

void
stream_open(stream_t *stream, const char *name, const char *mode);

void
stream_close(stream_t *stream);

long
stream_size(stream_t *stream);

void
stream_prep(stream_t *stream, long size);

void
stream_read(stream_t *stream);

void
stream_write(stream_t *stream);

extern int
telemetry(char *ibody, char *obody);

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
            telemetry(istr.body, ostr.body);
            stream_write(&ostr);
            stream_close(&istr);
            stream_close(&ostr);
        }
    }

    return 0;
}

void
stream_open(stream_t *stream, const char *name, const char *mode)
{
    stream->file = fopen(name, mode);
}

void
stream_close(stream_t *stream)
{
    stream->size = -1;

    fclose(stream->file), stream->file = 0;
    free(stream->body),   stream->body = 0;
}

long
stream_size(stream_t *stream)
{
    fseek(stream->file, 0, SEEK_END);
    long pos = ftell(stream->file);
    fseek(stream->file, 0, SEEK_SET);

    return pos;
}

void
stream_prep(stream_t *stream, long size)
{
    stream->body = calloc(size, sizeof(char));
    stream->size = size;
}

void
stream_read(stream_t *stream)
{
    stream_prep(stream, stream_size(stream));

    fread(stream->body, sizeof(char),
        stream->size, stream->file);
}

void
stream_write(stream_t *stream)
{
    fwrite(stream->body, sizeof(char),
        strlen(stream->body), stream->file);
}
