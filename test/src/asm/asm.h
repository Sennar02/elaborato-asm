#ifndef ASM_H
#define ASM_H

extern int
asm_strlen(const char *str);

extern int
asm_strtoi(const char *str);

extern char *
asm_itostr(unsigned num, char *str);

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

extern void
telemetry_line(int arr[], char *dst, int pnts[], char *strs[]);

extern void
telemetry_last(int arr[], char *src, char *dst);

extern void
telemetry_loop(int idx, char *src, char *dst);

extern int
telemetry(char *src, char *dst);

#endif /* ASM_H */
