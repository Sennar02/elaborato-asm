#include "library.h"

int
c_strlen(const char *str)
{
    // Copia l'indirizzo originale.
    const char *s = str;

    // Finché non incontra il terminatore
    // incrementa il puntatore.
    while (*s != 0)
        ++s;

    // Restituisce la distanza tra i due.
    return s - str - 1;
}

int
c_strncmp(const char *str1, const char *str2, int num)
{
    char c1 = 0, c2 = 0;

    // Copia un carattere da ciascuna di ognuna
    // delle stringhe finché i due caratteri estratti
    // corrispondono, non è terminata almeno una delle
    // due stringhe oppure finché il contatore dei
    // confronti non è a zero.
    do {
        c1 = *str1++, c2 = *str2++;
    }
    while (num-- > 0 && c1 != 0 && c1 == c2);

    // Restituisce la differenza tra i due caratteri.
    return c1 - c2;
}

char *
c_strnrev(char *str, int num)
{
    // Copia l'indirizzo del primo carattere
    // e l'indirizzo dopo num caratteri.
    char *b = str, *e = str + num, c = 0;

    // Finché non raggiunge la metà della stringa
    // scambia i due caratteri e sposta i puntatori
    // verso il centro.
    for (; b < e; ++b, --e) {
        c  = *b;
        *b = *e;
        *e = c;
    }

    return str;
}

int
c_strncpy(char *dst, const char *src, int num)
{
    // Copia l'indirizzo di destinazione.
    char *d = dst;

    // Copia il carattere di src in d finché
    // non raggiunge il terminatore oppure
    // il contatore è nullo.
    while (num-- > 0) {
        if ((*d++ = *src++) == 0)
            break;
    }

    // Restituisce il numero di caratteri copiati.
    return d - dst;
}

int
c_strlcpy(char *dst, const char *src, int num)
{
    // Copia il numero di caratteri da copiare.
    int n = num;
    // Copia l'indirizzo di destinazione.
    char *d = dst;

    // Copia il carattere di src in d finché
    // non raggiunge il terminatore oppure
    // il contatore è nullo ma copiando un carattere
    // in meno.
    while (--num > 0) {
        if ((*d++ = *src++) == 0)
            break;
    }

    // Se ha copiato effettivamente almeno
    // un carattere, termina la stringa.
    if (num == 0 && n > 0)
        *d = 0;

    // Restituisce il numero di caratteri copiati.
    return d - dst;
}

int
c_strtoi(const char *str)
{
    int res = 0;

    // Finché il carattere della stringa è numerico
    // lo converte ad intero e lo posiziona come
    // cifra meno significativa dopo aver shiftato
    // il numero a sinistra.
    while (*str >= '0' && *str <= '9')
        res = res * 10 + *str++ - '0';

    // Restituisce il valore convertito.
    return res;
}

char *
c_itostr(unsigned int num, char *str)
{
    // Copia l'indirizzo originale.
    char *s = str;

    // Se il numero da convertire è maggiore
    // di zero allora converte la cifra meno
    // significativa del numero e la inserisce
    // in fondo alla stringa finché il numero
    // shiftato a destra non viene annullato.
    if (num > 0) {
        do {
            *s++ = (num % 10) + 48;
        }
        while (num /= 10);
    }
    // Altrimenti copia semplicemente zero.
    else
        *s++ = 48;

    // Termina la stringa in ogni caso.
    *s = 0;

    // Rovescia la stringa.
    c_strnrev(str, s - str - 1);
    return str;
}

char *
c_strsep(char **ptr, char sep)
{
    // Copia l'indirizzo originale.
    char *s = *ptr, *d = *ptr;

    // Se il puntatore non è nullo.
    if (s != 0) {
        // Scorre la stringa finché non termina o
        // non raggiunge il carattere separatore.
        while (*s != 0 && *s != sep)
            ++s;

        // Se ha raggiunto la fine della stringa, la
        // termina e sostituisce la stringa nel punto
        // appena successivo alla separazione.
        if (*s != 0) {
            *s++ = 0;
            *ptr = s;
        }
        // Altrimenti annulla la stringa perché
        // non contiene altri caratteri separatori.
        else
            *ptr = 0;
    }

    // Restituisce la stringa precedente alla separazione.
    return d;
}

int
c_strnsep(char *arr[], int num, char **ptr, char sep)
{
    unsigned int c = 0;

    // Finché non ha riempito tutte le celle dell'array.
    for (unsigned int l = 0; l < num; ++l)
        // Separa la stringa e se non riceve un puntatore
        // nullo, incrementa il contatore delle separazioni
        // che hanno avuto successo.
        if ((*arr++ = c_strsep(ptr, sep)) != 0)
            ++c;

    // Restituisce il numero di stringhe separate.
    return c;
}

int
c_max(int val, int max)
{
    if (val > max)
        return val;

    return max;
}

int
c_select(int val, int arr[], int len)
{
    for (int i = 0; i < len; ++i)
        // Se il valore è minore della i-esima
        // soglia, allora restituisce l'indice.
        if (val <= arr[i])
            return i;

    // Restituisce un indice che indica una
    // posizione oltre tutte le soglie.
    return len;
}

int
c_arrfind(const char *arr[], int len, const char *key)
{
    // Calcola la lunghezza della chiave.
    int num = c_strlen(key);

    // Scorre tutto l'array confrontando ogni elemento
    // con la chiave, se almeno un elemento corrisponde
    // ne restituisce la posizione.
    for (int i = 0; i < len; ++i) {
        if (c_strncmp(key, arr[i], num) == 0)
            return i;
    }

    // Se non ha trovato alcun elemento restituisce
    // un indice inesistente.
    return -1;
}
