#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include "file.h"

file_t*
file_create(const char *name, const char *mode)
{
    file_t *self = malloc(sizeof *self);

    if (self != 0) {
        self->name = name;
        self->mode = mode;
        self->body = 0;

        self->file = file_open(self);
        self->size = file_size(self);
    }

    return self;
}

FILE*
file_open(file_t *self)
{
    if (self != 0)
        return fopen(self->name, self->mode);

    return 0;
}

void
file_close(file_t *self)
{
    if (self != 0) {
        fclose(self->file);
        free(self->body);

        self->size = -1;
        self->file = 0;
        self->body = 0;
        self->name = 0;
        self->mode = 0;
    }
}

uint32_t
file_size(file_t *self)
{
    uint32_t size = -1;

    if (self != 0 && self->file != 0) {
        fseek(self->file, 0, SEEK_END);
        size = ftell(self->file);
        fseek(self->file, 0, SEEK_SET);
    }

    return size;
}

const char*
file_read(file_t *self)
{
    uint32_t size = file_size(self);

    if (self != 0 && self->file != 0) {
        if (self->body == 0) {
            free(self->body);

            self->size = size;
            self->body = malloc(size);
        }

        fread(self->body, sizeof (char),
            self->size, self->file);

        return self->body;
    }

    return 0;
}

void
file_write(file_t *self, char *str)
{
    if (self != 0 && self->file != 0) {
        if (str != 0) {
            free(self->body);

            self->size = strlen(str);
            self->body = str;
        }

        fwrite(self->body, sizeof (char),
            strlen(self->body), self->file);
    }
}
