#ifndef LIBRARY_ASM_H
#define LIBRARY_ASM_H

extern int
s_strlen(const char *str);

extern int
s_strtoi(const char *str, int base);

extern char *
s_itostr(unsigned num, char *str, int base);

extern char *
s_strnrev(char *str, int num);

extern int
s_strncmp(const char *str1, const char *str2, int num);

extern int
s_strncpy(char *dst, const char *src, int num);

extern int
s_strlcpy(char *dst, const char *src, int num);

extern char *
s_strsep(char **ptr, char sep);

extern int
s_arrfind(const char *arr[], int len, const char *key);

#endif /* LIBRARY_ASM_H */
