#ifndef TEST_H
#define TEST_H

void
testing(char *itext, char *otext, const char *names[], int lenght);

void
t_strlen(const char *names[], int lenght);

void
t_strtoi(void);

void
t_itostr(void);

void
t_strnrev(void);

void
t_strncmp(void);

void
t_strncpy(void);

void
t_strlcpy(void);

void
t_strsep(char *itext);

void
t_arrfind(const char *names[], int lenght);

// ----------------------------------------
// FUNZIONI EXTRA
// ----------------------------------------

void
printsep(void);

void
print_str_arr(const char *str[], int dim);

#endif /* TEST_H */
