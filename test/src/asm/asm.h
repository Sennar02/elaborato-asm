#ifndef ASM_H
#define ASM_H

extern int
asm_strlen(const char *str);

extern int
asm_strtoi(const char *str, int base);

extern char *
asm_itostr(unsigned num, char *str, int base);

extern char *
asm_strnrev(char *str, int num);

extern int
asm_strncmp(const char *str1, const char *str2, int num);

extern int
asm_strncpy(char *dst, const char *src, int num);

extern int
asm_strlcpy(char *dst, const char *src, int num);

extern char *
asm_strsep(char **ptr, char sep);

extern int
asm_strnsep(char *arr[], int len, char **ptr, char sep);

extern int
asm_arrfind(const char *arr[], int len, const char *key);

extern int
asm_select(int val, int arr[], int len);

#endif /* ASM_H */
