# Sistema di telemetria F1

Abbiamo sviluppato un programma in linguaggio *Assembly* sintassi **AT&T** che simula il sistema di telemetria del videogame F1.

## Traccia

Il sistema prende in input per tutti i piloti ad ogni istante di tempo i dati grezzi di:

- **giri motore** (*rpm*);
- **temperatura motore** ;
- **velocità** .

### Parametri

I parametri vengono passati nel seguente ordine separati da una virgola `','`

```csv
tempo, id_pilota, velocità, rpm, temperatura
```

dove il campo `id_pilota` rappresenta un valore numerico, indice univoco del pilota.

I parametri restituiti vengono ordinati nella seguente maniera

```csv
tempo, livello rpm, livello temperatura, livello velocità
```

dove i tre livelli assumono in base a delle soglie uno dei seguenti valori: `"LOW"`, `"MEDIUM"`, `"HIGH"`.

### Obiettivo

Il programma in *Assembly* prende la prima riga contenente il nome dell'utente, in caso esso corrisponda ad un **id** presente in tabella vengono restituiti tutti i dati relativi a quel pilota in base alle soglie, nello specifico:

| **Parametro**         | `"LOW"`       | `"MEDIUM"`           | `"HIGH"`      |
| :-------------------: | :-----------: | :------------------: | :-----------: |
| **Giri motore (rpm)** | *rpm ≤ 500*   | *5000 < rpm ≤ 10000* | *rpm > 110*   |
| **Temperatura**       | *temp ≤ 90*   | *90 < temp ≤ 110*    | *temp > 110*  |
| **Velocità**          | *speed ≤ 110* | *100 < speed ≤ 250*  | *speed > 250* |

Inoltre deve essere aggiunta un'ulteriore riga che contiene nel seguente ordine: il numero massimo di **giri motore** (rpm), la **temperatura massima**, la **velocità massima** e la **velocità media**. La sua struttura è:

```csv
rpm max, temp max, velocità max, velocità media
```

### Vincoli

- La velocità media è calcolata prendendo solamente la parte intera del quoziente.
- Se il nome dell'utente non corrisponde ad nessun **id** viene stampata la stringa `"Invalid"`.

<!-- | **ID** | **Pilota**         |
| :----- | -----------------: |
| 0      | Pierre Gasly       |
| 1      | Charles Leclerc    |
| 2      | Max Verstappen     |
| 3      | Lando Norris       |
| 4      | Sebastian Vettel   |
| 5      | Daniel Ricciardo   |
| 6      | Lance Stroll       |
| 7      | Carlos Sainz       |
| 8      | Antonio Giovinazzi |
| 9      | Kevin Magnussen    |
| 10     | Alexander Albon    |
| 11     | Nicholas Latifi    |
| 12     | Lewis Hamilton     |
| 13     | Romain Grosjean    |
| 14     | George Russell     |
| 15     | Sergio Perez       |
| 16     | Daniil Kvyat       |
| 17     | Kimi Raikkonen     |
| 18     | Esteban Ocon       |
| 19     | Valtteri Bottas    | -->

## Variabili

blabla

## Funzioni

Abbiamo suddiviso il programma in varie routine alle quali forniamo i parametri tramite lo *stack* del programma. Questo metodo richiede particolare attenzione perché lo *stack* viene usata anche dal sistema stesso.

### Chiamata di una funzione e passaggio parametri

Nel blocco chiamante di una funzione:

- abbiamo caricato nello *stack*, dopo averli inseriti negli opportuni registri, i parametri da passare alla funzione, in ordine inverso così che possiamo estrarli più comodamente;

- abbiamo utilizzato l’istruzione `call`, che invoca la funzione specificata. Dopo che la funzione è terminata il valore restituito, se presente, si trova in `%eax`;

- conclusa la funzione, abbiamo liberato lo spazio di memoria che era stato riservato ai parametri della funzione, incrementando `%esp` di 4 byte per parametro, dato che siamo in un’architettura a 32 bit.

### Inizio/Conclusione di una funzione e restituzione di un valore

Nel blocco della funzione chiamata, durante la fase iniziale:

- abbiamo caricato il valore di `%ebp` nello *stack*, per salvare così il suo valore iniziale e ripristinarlo una volta conclusa la funzione;

- abbiamo salvato lo *stack* pointer in `%ebp`. Per accedere ai parametri e alle variabili locali si utilizza `%ebp` e un offset;

- abbiamo caricato nello *stack* i registri che utilizzeremo nella funzione e i cui valori vogliamo ripristinare conclusa la funzione;

- abbiamo utilizzato `%ebp` con un certo offset per salvare i parametri della funzione negli opportuni registri.

Prima di concludere la funzione:

- abbiamo salvato nel registro `%eax` l’eventuale valore da restituire;

- abbiamo estratto i registri caricati all’inizio della funzione;

- abbiamo estratto `%ebp` ripristinando così la sua posizione;

- abbiamo utilizzato l’istruzione `ret`, terminando la funzione e posizionando il programma all’istruzione successiva alla `call`.

### strlen

```c
unsigned int
strlen(const char *str);
```

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |
| `str`     | Stringa della quale calcolare la lunghezza. |

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

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

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

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

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

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

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

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

La funzione accetta come parametro due stringhe, destinazione e sorgente, e un valore intero. Copia un certo numero di caratteri della sorgente nella destinazione e aggiunge il terminatore.

Copia gl'indirizzi delle due stringhe e scorre i puntatori finché il valore intero è maggiore di 0. Copia il puntatore alla sorgente nel puntatore alla destinazione e conclude il ciclo se uno i caratteri puntati è un terminatore, altrimenti incrementa i puntatori. Poi aggiunge il carattere terminatore alla destinazione. Restituisce quinti il numero di caratteri copiati, dato dalla differenza tra i due puntatori.

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
strtoi(const char *str);
```

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

La funzione accetta in ingresso una stringa, converte la stringa in un valore in base 10.

Dichiara un valore intero a zero e scorre i caratteri puntati della stringa finché il loro codice ASCI è compreso tra quello dei valori numerici. Quindi salva nel valore intero dichiarato all'inizio il valore stesso moltiplicato per 10, somma il valore del carattere puntato e poi sottrae 48 (il valore ASCI corrispondente a 0, da cui partono le altre cifre decimali). Infine restituisce la stringa convertita.

```c
unsigned int
strtoi(const char *str)
{
    int res = 0;

    while (*str >= 48 && *str <= 57)
        res = res * 10 + *str++ - 48;

    return res;
}
```

### itostr

```c
char *
itostr(unsigned int num, char *str);
```

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

La funzione accetta in ingresso un numero intero in base 10 e una stringa, converte il numero intero in una stringa.

Copia il numero intero e il puntatore alla stringa. Se il numero è uguale a 0 aggiunge semplicemente 48 al puntatore, che poi viene incrementato. Altrimenti scorre il numero intero convertendo ogni cifra (ottenuta come resto della divisione per 10) in un carattere che viene salvato nella stringa copiata e poi divide il numero per la 10. Il ciclo continua finche il numero diviso è maggiore di 0. Aggiunge alla stringa il carattere terminatore, inverte la stringa con la funzione `strnrev` e la restituisce.

```c
char *
itostr(unsigned int num, char *str)
{
    int n = num;
    char *s = str;

    if (num != 0) {
        do {
            *s++ = (num % 10) + 48;
        }  while (num /= 10);
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

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

La funzione accetta in ingresso una stringa e un carattere separatore, restituisce il pezzo di stringa precedente al separatore.

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

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

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

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

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

| Parametro | Descrizione                                 |
| :-------: | :-----------------------------------------: |

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
### telemetry_line

```c
int
telemetry_line(int arr[], char *dst);
```

La funzione accetta in ingresso i dati del pilota e una stringa destinazione. Assegna ai dati una tra le stringhe `"LOW"`, `"MEDIUM"` e `"HIGH"` e le salva nella destinazione.

Copia la stringa destinazione in un'altra variabile. In un ciclo di 3 iterazioni (la quantità di valori dell'array), salva la targhetta apposita, individuata attraverso la funzione `select()`. Ottiene quindi la lunghezza della stringa e per mezzo di `strncpy()` aggiunge il risultato alla destinazione. Poi, se non si è nell'ultima iterazione aggiunge alla destinazione una virgola, altrimenti aggiunge l'interruzione di riga. Restituisce quindi la differenza tra i puntatori alla destinazione e alla stringa copia.

```c
int
telemetry_line(int arr[], char *dst)
{
    char *d = dst;
    const char *out = 0;
    int idx = 0, siz = 0;

    for (int i = 0; i < 3; ++i) {
        idx = c_select(arr[i], treshs + i * 2, 2);
        out = levels[idx];
        siz = c_strlen(out);
        dst += c_strncpy(dst, out, siz);

        if (i != 2)
            *dst++ = ',';
        else
            *dst++ = '\n';
    }

    return dst - d;
}
```

### telemetry_last

```c
void
telemetry_last(int arr[], char *src, char *dst);
```

La funzione accetta in ingresso un'array d'interi, una stringa sorgente e una destinazione. Crea l'ultima riga dei dati del pilota.

In un ciclo da 4 iterazioni (numero di elementi nell'array) converte ogni elemento in stringa con la funzione `itostr()`, salva la lunghezza della stringa ottenuta e poi la copia nella destinazione. Inoltre, se non è avvenuta l'ultima iterazione aggiunge una virgola, altrimenti aggiunge l'interruzione di riga.

```c
void
telemetry_last(int arr[], char *src, char *dst)
{
    int siz = 0;

    for (int i = 0; i < 4; ++i) {
        c_itostr(arr[i], src);

        siz = c_strlen(src);
        dst += c_strncpy(dst, src, siz);

        if (i != 3)
            *dst++ = ',';
        else
            *dst++ = '\n';
    }
}
```

### telemetry_loop

```c
void
telemetry_loop(int idx, char *src, char *dst);
```

La funzione accetta in ingresso l'indice del pilota, una stringa sorgente e una destinazione. Manipola i dati appartenenti al pilota e li salva nella destinazione.

Finché non ha raggiunto la fine della sorgente, svolge le seguenti operazioni: copia le stringhe una riga alla volta, se la stringa non è vuota salva in un array di stringhe (`str[5]`) le sue parti separate da una virgola; se la seconda stringa di `str[]` non è vuota, la converte in intero; se il numero ottenuto è uguale all'indice del pilota da analizzare, salva in un array d'interi (`val[4]`) i valori `str[2] - str[4]`; ricopia il primo elemento di `val[]` nella destinazione, aggiunge una virgola e poi con la funzione `telemetry_line()` sostituisce gli altri elementi di `val[]` con apposite stringhe, in base alla posizione e al valore. Salva in un altro array d'interi (`tst[4]`) i valori massimi dei dati del pilota, poi incrementa un contatore.  
Concluso il ciclo, divide l'ultimo valore di `tst[]` per il contatore, ottenendo così una media, e infine utilizza l'array per la funzione `telemetry_last()`.

```c
void
telemetry_loop(int idx, char *src, char *dst)
{
    char *s = src, *lin = 0, *str[5] = {0};
    int cnt = 0, pid = 0, val[4] = {0}, tst[4] = {0};

    for (cnt = 0; src != 0;) {
        lin = c_strsep(&src, '\n');

        if (lin != 0)
            c_strnsep(str, 5, &lin, ',');

        if (str[1] != 0) {
            pid = c_strtoi(str[1]);

            if (pid == idx) {
                val[0] = c_strtoi(str[3]);
                val[1] = c_strtoi(str[4]);
                val[2] = c_strtoi(str[2]);

                dst += c_strncpy(dst, str[0], 7);
                *dst++ = ',';

                dst += telemetry_line(val, dst, treshs, levels);

                tst[0] = c_max(tst[0], val[0]);
                tst[1] = c_max(tst[1], val[1]);
                tst[2] = c_max(tst[2], val[2]);
                tst[3] = c_sum(tst[3], val[2]);

                cnt += 1;
            }
        }
    }

    tst[3] = tst[3] / cnt;
    telemetry_last(tst, s, dst);
}
```

### telemetry

```c
int
telemetry(char *src, char *dst);
```

La funzione accetta in ingresso una stringa sorgente e una destinazione.

Separa e salva la prima riga della sorgente e la cerca nell'array `names`, che contiene il nome dei possibili piloti. Se trova una corrispondenza, salva la sua posizione e procede con `telemetry_loop`, altrimenti salva la stringa `"Invalid"` nella destinazione.

```c
int
telemetry(char *src, char *dst)
{
    char *lin = c_strsep(&src, '\n');
    int idx = c_arrfind(names, 20, lin);

    if (idx >= 0)
        c_telemetry_loop(idx, src, dst);
    else
        c_strlcpy(dst, "Invalid", 8);

    return 0;
}
```
