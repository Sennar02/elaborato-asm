# Titolo relazione

...blablabla

## Traccia

blabla

## Variabili

blabla

## Funzioni

### strlen  

```c
unsigned int
strlen(const char *str);
```

La funzione accetta in ingresso una stringa e ne calcola la lunghezza.  

Prima di tutto copia l'indirizzo, poi incrementa il puntatore finché il carattere non equivale al terminatore (`'\0'`). Infine restituisce la differenza tra l'indirizzo del terminatore e quello originale, cioè la distanza tra i due e quindi la lunghezza della stringa.

Durante la sottrazione decrementa ulteriormente il valore perché altrimenti considererebbe anche il terminatore stesso.

```c
unsigned int
strlen(const char *str)
{
    const char *s = str;

    while (*s++ != 0);

    return s - str - 1;
}
```

### strncmp  

```c
int
strncmp(const char *str1, const char *str2, int num);
```

La funzione accetta in ingresso due stringhe e un intero, calcola se le due stringhe sono uguali.

Dichiara due caratteri inizializzati a 0 (`'\0'`) che vengono usati in un ciclo per scorrere i caratteri puntati nelle due stringhe. Se si trovano dei caratteri diversi, se si raggiunge il terminatore della prima stringa o se sono stati confrontati il numero di caratteri dato dal valore intero passato come parametro, il ciclo viene concluso. Alla fine compie una sottrazione tra i caratteri puntati alla conclusione del ciclo. Se la differenza è uguale a 0, le stringhe sono uguali.

```c
int
strncmp(const char *str1, const char *str2, int num)
{
    char c1 = 0, c2 = 0;

    do {
        c1 = *str1++, c2 = *str2++;
    } while (num-- > 0 && c1 != 0 && c1 == c2);

    return c1 - c2;
}
```

### strnrev

```c
char *
strnrev(char *str, int num);
```

La funzione accetta in ingresso una stringa e un valore intero che indica il numero di caratteri della stringa da invertire.

Copia la stringa da invertire in due ulteriori stringhe e dichiara un carattere inizializzato a 0 (`'\0'`). Nella seconda stringa somma al puntatore il valore intero passato come parametro. Scorre i caratteri, scambiando quelli correnti puntati, incrementa il puntatore alla prima stringa e decrementa il puntatore alla seconda. Se il puntatore alla prima stringa è maggiore del puntatore alla seconda, conclude il ciclo. Infine restituisce i caratteri invertiti della stringa.

```c
char *
strnrev(char *str, int num)
{
    char *s = str, *d = str + num, c = 0;

    for (; s < d; ++s, --d)
        c = *s, *s = *d, *d = c;

    return str;
}
```

### strncpy

```c
int
strncpy(char *dst, const char *src, int num);
```

La funzione accetta come parametro due stringhe, destinazione e sorgente, e un valore intero. Copia un certo numero di caratteri della sorgente nella destinazione.

Copia gl'indirizzi delle due stringhe, poi scorre i puntatori decrementando il valore intero finché non è minore di 0. Copia il carattere puntato nella sorgente in quello puntato nella destinazione e conclude il ciclo se uno dei caratteri puntati è un terminatore, altrimenti incrementa i puntatori. Alla fine restituisce il numero di caratteri copiati, dato dalla differenza tra i due puntatori.

Se il valore intero passato è maggiore della lunghezza della sorgente, e la sorgente ha il carattere terminatore, la destinazione viene terminata.

```c
int
strncpy(char *dst, const char *src, int num)
{
    const char *s = src;
    char *d = dst;

    while (num-- > 0) {
        if ((*d++ = *s++) == 0)
            break;
    }

    return d - dst;
}
```

### strlcpy

```c
int
strlcpy(char *dst, const char *src, int num);
```

La funzione accetta come parametro due stringhe, destinazione e sorgente, e un valore intero. Copia un certo numero di caratteri della sorgente nella destinazione e aggiunge il terminatore.

Copia gl'indirizzi delle due stringhe e scorre i puntatori finche il valore intero è maggiore di 0. Copia il puntatore alla sorgente nel puntatore alla destinazione e conclude il ciclo se uno i caratteri puntati è un terminatore, altrimenti incrementa i puntatori. Poi aggiunge il carattere terminatore alla destinazione. Restituisce quinti il numero di caratteri copiati, dato dalla differenza tra i due puntatori.

```c
int
strlcpy(char *dst, const char *src, int num)
{
    int n = num;
    const char *s = src;
    char *d = dst;

    while (--num > 0) {
        if ((*d++ = *s++) == 0)
            break;
    }

    if (num == 0 && n > 0)
        *d = 0;

    return d - dst;
}
```

### strtoi

```c
unsigned int
strtoi(const char *str, int base);
```

La funzione accetta in ingresso una stringa e una base di conversione, converte la stringa in un valore nella base.

Dichiara un valore intero a zero e scorre i caratteri puntati della stringa finché il loro codice ascii è compreso tra quello dei valori numerici. Quindi salva nel valore intero dichiarato all'inizio il valore stesso moltiplicato per la base, somma il valore del carattere puntato e poi sottrae 48 (il valore ascii corrispondente a 0, da cui partono le altre cifre decimali). Infine restituisce la stringa convertita.

```c
unsigned int
strtoi(const char *str, int base)
{
    int res = 0;

    while (*str >= 48 && *str <= 57)
        res = res * base + *str++ - 48;

    return res;
}
```

### itostr

```c
char *
itostr(unsigned int num, char *str, int base);
```

La funzione accetta in ingresso un numero intero, una stringa e un valore intero come base di conversione, converte il numero intero in una stringa.

Copia il numero intero e il puntatore alla stringa. Se il numero è uguale a 0 aggiunge semplicemente 48 al puntatore, che poi viene incrementato. Altrimenti scorre il numero intero convertendo ogni cifra (ottenuta come resto della divisione per la base) in un carattere che viene salvato nella stringa copiata e poi divide il numero per la base. Il ciclo continua finche il numero diviso è maggiore di 0.  
Dopodichè aggiunge alla stringa il carattere terminatore, inverte la stringa con la funzione `strnrev` e la restituisce.

```c
char *
itostr(unsigned int num, char *str, int base)
{
    int n = num;
    char *s = str;

    if (num != 0) {
        do {
            *s++ = (num % base) + 48;
        }  while (num /= base);
    } else
        *s++ = 48;

    *s = 0;

    c_strnrev(str, s - str - 1);
    return str;
}
```

### strsep

```c
char*
strsep(char **ptr, char sep)
```

La funzione accetta in ingresso una stringa e un carattere separatore, restituisce il pezzo di stringa precendente al separatore.

Copia in due ulteriori stringhe quella passata come parametro e controlla se la prima stringa contiene dei caratteri. Incrementa il puntatore alla prima stringa finche non si raggiunge la sua fine o un carattere che è uguale al separatore.
Concluso il ciclo, se il carattere puntato è uguale al terminatore, lo aggiunge alla stringa passata come parametro. Se invece il carattere puntato è diverso dal terminatore lo sostituisce con il terminatore e sostituisce la stringa passata come parametro con il pezzo restante di stringa successivo al separatore. Quindi restituisce la seconda stringa dichiarata all'inizio, che ha subito le modifiche avvenute durante l'esecuzione.  
Se la stringa passata come parametro non contiene nessun carattere, la restituisce senza compiere ulteriori operazioni.

```c
char*
strsep(char **ptr, char sep)
{
    char *s = *ptr, *d = *ptr;

    if (s != 0) {
        while (*s != 0 && *s != sep)
            ++s;

        if (*s != 0) {
            *s++ = 0;
            *ptr = s;
        } else
            *ptr = 0;
    }

    return d;
}
```

### strnsep

```c
int
strnsep(char *arr[], int num, char **ptr, char sep)
```

La funzione accetta in ingresso un array di stringhe, la sua lunghezza, una stringa e un carattere separatore. Restituisce il numero di volte in cui è avvenuta una separazione della stringa.  

Inizializza 2 variabili intere a 0 e prosegue con un ciclo che finisce quando la seconda variabile è uguale alla lunghezza dell'array. Dentro il ciclo salva nella posizione puntata nell'array il risultato della funzione `strsep`, se è diverso da 0 incrementa il conteggio delle separazioni (prima variabile intera), altrimenti prosegue col ciclo. Concluso il ciclo restituisce il conteggio delle separazioni.

```c
int
strnsep(char *arr[], int num, char **ptr, char sep)
{
    int l = 0, c = 0;

    while (l++ < num)
        if ((*arr++ = c_strsep(ptr, sep)) != 0)
            ++c;

    return c;
}
```

### arrfind

```c
int
arrfind(const char *arr[], int len, const char *key);
```

La funzione accetta in ingresso un array di stringhe, la sua lunghezza e una stringa, indica se nell'array è presente la stringa passata.  

Salva in una variabile la lunghezza della stringa passata come parametro. Confronta la stringa passata con ogni stringa dell'array utilizzando la funzione `strncmp`. Se trova la stringa corrispondente, restituisce la sua posizione nell'array. Se alla fine dell'array non ha trovato la stringa, restituisce -1.

```c
int
arrfind(const char *arr[], int len, const char *key)
{
    int num = c_strlen(key);

    for (int i = 0; i < len; ++i) {
        if (c_strncmp(key, arr[i], num) == 0)
            return i;
    }

    return -1;
}
```

### select

```c
int
select(int val, int arr[], int len);
```

La funzione accetta in ingresso un valore intero, un array d'interi e la sua lunghezza, indica se il valore appartiene ad un certo intervallo.

Parte con un ciclo che si conclude quando l'indice è uguale alla lunghezza dell'array passato come parametro. Se il valore passato è minore uguale dell'elemento dell'array alla posizione data dall'indice, il ciclo si conclude e restituisce l'indice corrente. Altrimenti, una volta finito il ciclo, restituisce la lunghezza dell'array.

```c
int
select(int val, int arr[], int len)
{
    for (int i = 0; i < len; ++i)
        if (val <= arr[i]) return i;

    return len;
}
```
