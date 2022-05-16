#ifndef STREAM_H
#define STREAM_H

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

#endif /* STREAM_H */
