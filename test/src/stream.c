#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include "stream.h"

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
