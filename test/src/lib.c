#include "lib.h"

int
c_strlen(const char *str)
{
    // Copia l'indirizzo originale.
    const char *s = str;

    // Finché non incontra il terminatore
    // incrementa il puntatore.
    while (*s++ != 0);

    // Restituisce la distanza tra i due.
    return s - str - 1;
}

int
c_strncmp(const char *str1, const char *str2, int num)
{
    // Caratteri temporanei per il controllo.
    char c1 = 0, c2 = 0;

    // Prende un carattere da ciascuna di ognuna
    // delle stringhe finché i due caratteri estratti
    // corrispondono, non abbiamo raggiunto la fine
    // della prima stringa e se il numero di caratteri
    // da controllare è maggiore di 0.
    do {
        c1 = *str1++, c2 = *str2++;
    } while (num-- > 0 && c1 != 0 && c1 == c2);

    // Restituisce la differenza tra i due caratteri.
    return c1 - c2;
}

char *
c_strnrev(char *str, int num)
{
    // Copia l'indirizzo del primo carattere della
    // stringa e l'indirizzo dell'ultimo carattere
    // e inizializza un carattere che andrà utilizzato
    // come variabile temporanea.
    char *s = str, *d = str + num, c = 0;

    // Finché non si raggiunge la metà della stringa
    // Scambia i due caratteri che puntano alla del
    // puntatore iniziale e finale.
    for (; s < d; ++s, --d)
        c = *s, *s = *d, *d = c;

    // Restituisce la stringa.
    return str;
}

int
c_strncpy(char *dst, const char *src, int num)
{
    // Copia l'indirizzo di destinazione.
    char *d = dst;

    // Copia il carattere di src dentro d finché
    // non viene raggiunto il terminatore oppure
    // num diventa uguale a 0.
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
    // Copia il numero num.
    int n = num;

    // Copia l'indirizzo di destinazione.
    char *d = dst;

    // Copia il carattere di src dentro d finché
    // non viene raggiunto il terminatore oppure
    // num diventa uguale a 0.
    while (--num > 0) {
        if ((*d++ = *src++) == 0)
            break;
    }

    // Se num uguale a 0 e n è maggiore di 0
    // aggiunge il carattere terminatore alla stringa.
    if (num == 0 && n > 0)
        *d = 0;

    // Restituisce il numero di caratteri copiati.
    return d - dst;
}

int
c_strtoi(const char *str)
{
    // Inizializza il risultato.
    int res = 0;

    // Finché il carattere della stringa è maggiore-uguale
    // al carattere '0' e minore-uguale al carattere '9'
    // inserisce il carattere convertendolo in intero
    // dopo la cifra meno significativa del numero.
    while (*str >= 48 && *str <= 57)
        res = res * 10 + *str++ - 48;

    // Restituisce str convertito a intero.
    return res;
}

char*
c_itostr(unsigned int num, char *str)
{
    // Copia il numero num.
    int n = num;

    // Copia l'indirizzo originale.
    char *s = str;

    // Controlla se il numero è uguale a 0,
    // nel caso lo sia, fintantoché num / 10
    // è diverso da 0, estrae la cifra meno
    // significativa di num e la converte in
    // stringa sommando 48. Altimenti essendo
    // num a 0 somma solo il 48.
    if (num != 0) {
        do {
            *s++ = (num % 10) + 48;
        }  while (num /= 10);
    } else
        *s++ = 48;

    // Aggiunge il terminatore alla stringa.
    *s = 0;

    // Rovescia la strina.
    c_strnrev(str, s - str - 1);

    // Restituisce la stringa.
    return str;
}

char*
c_strsep(char **ptr, char sep)
{
    // Copia due volte il puntatore alla
    // prima stringa dell'array.
    char *s = *ptr, *d = *ptr;

    // Se il puntatore è diverso da 0, continua
    // a scorrere la stringa finché non raggiunge
    // la sua terminazione oppure il carattere di
    // separazione.
    if (s != 0) {
        while (*s != 0 && *s != sep)
            ++s;

        // Controlla se la il carattere della stringa
        // è diverso dal terminatore, nel caso lo sia
        // aggiunge quest'ultimo e assegna a ptr il
        // valore l'indirizzo del valore puntato da s.
        // Altrimenti assegna a ptr il valore 0.
        if (*s != 0) {
            *s++ = 0;
            *ptr = s;
        } else
            *ptr = 0;
    }

    // Restituisce la stringa separata.
    return d;
}

int
c_strnsep(char *arr[], int num, char **ptr, char sep)
{
    // Inizializza a 0 il contatore dei caratteri copiati
    // e il contatore dei caratteri massimi da copiare.
    int l = 0, c = 0;

    // Finché il contatore dei caratteri è minore di num
    // separa la stringa ptr ad ogni occorrenza di sep
    // salvando la stringa nell'array e incrementando c.
    while (l++ < num)
        if ((*arr++ = c_strsep(ptr, sep)) != 0)
            ++c;

    // Restituisce il numero di stringhe separate.
    return c;
}

int
c_arrfind(const char *arr[], int len, const char *key)
{
    // Calcola la lunghezza della chiave.
    int num = c_strlen(key);

    // Scorre tutto l'array confrontando la chiave con
    // con l'elemento i-esimo di arr, nel caso in cui
    // corrispondono restituisce l'indice di arr.
    for (int i = 0; i < len; ++i) {
        if (c_strncmp(key, arr[i], num) == 0)
            return i;
    }

    // Restituisce -1 essendo che non ha trovato la chiave.
    return -1;
}

int
c_select(int val, int arr[], int len)
{
    // Scorre tutto l'array arr, e controlla se
    // val è minore dell'i-esimo elemento, nel
    // caso lo sia restituisce l'indice.
    for (int i = 0; i < len; ++i)
        if (val <= arr[i]) return i;

    // Restituisce la lunghezza essendo che il
    // valore è maggiore di ogni elementi di arr.
    return len;
}
