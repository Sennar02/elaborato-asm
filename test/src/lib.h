#ifndef LIB_H
#define LIB_H

int
c_strlen(const char *str);

int
c_strncmp(const char *str1, const char *str2, int num);

char *
c_strnrev(char *str, int num);

int
c_strncpy(char *dst, const char *src, int num);

int
c_strlcpy(char *dst, const char *src, int num);

int
c_strtoi(const char *str);

char*
c_itostr(unsigned int num, char *str);

char*
c_strsep(char **ptr, char sep);

int
c_strnsep(char *arr[], int num, char **ptr, char sep);

int
c_arrfind(const char *arr[], int len, const char *key);

int
c_select(int val, int arr[], int len);

#endif /* LIB_H */
