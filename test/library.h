#ifndef LIBRARY_H
#define LIBRARY_H

int
c_strlen(const char *str);

int
c_strtoi(const char *str, int base);

char *
c_itostr(unsigned int num, char *str, int base);

char *
c_strnrev(char *str, int num);

int
c_strncmp(const char *str1, const char *str2, int num);

int
c_strncpy(char *dst, const char *src, int num);

int
c_strlcpy(char *dst, const char *src, int num);

char*
c_strsep(char **ptr, char sep);

int
c_arrfind(const char *arr[], int len, const char *key);

#endif /* LIBRARY_H */
