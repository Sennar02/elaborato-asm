#ifndef STRING_H
#define STRING_H

int
string_len(const char *str);

int
string_ncmp(const char *str1, const char *str2, int num);

char*
string_sep(char **strp, char sep);

#endif /* STRING_H */
