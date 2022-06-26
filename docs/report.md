# Sistema di telemetria F1

Abbiamo sviluppato un programma in linguaggio *Assembly x86* con sintassi **AT&T**, che simula il sistema di telemetria del videogame F1.

## Traccia

Il sistema legge un file la cui prima riga è il nome di un pilota, mentre le successive sono precedute dall'istante di tempo e dall'identificatore del pilota a cui sono associate e contengono:

- giri al minuto del motore
- temperatura del motore
- velocità istantanea del veicolo.

Tutte queste informazioni sono nel formato:

> ```
> istante, identif., velocità, giri, temperatura
> ```

Se il pilota viene riconosciuto, dopo aver letto, interpretato ed elaborato le informazioni, il sistema produce un file in cui tutte le informazioni riguardano esclusivamente lui, altrimenti scrive `"Invalid"` all'interno dello stesso e termina.

Il riconoscimento avviene cercando il nome all'interno di un contenitore, se viene trovato ne viene utilizzato l'identificatore per interpretare le righe sottostanti.

Tutte le righe prodotte seguono il formato:

> ```csv
> istante, liv. giri, liv. temperatura, liv. velocità
> ```

Tranne l'ultima che contiene i valori massimi di queste statistiche e in più la media (intera) della velocità istantanea, più precisamente:

> ```
> max. giri, max. temperatura, max. velocità, med. velocità
> ```

I livelli che possono assumere le varie informazioni sono riportati nella tabella:

| **Parametro**     | `LOW`       | `MEDIUM`             | `HIGH`    |
| :---------------: | :---------: | :------------------: | :-------: |
| **Giri motore**   | $x \le 500$ | $5000 < x \le 10000$ | $x > 110$ |
| **Temperatura**   | $x \le 90$  | $90 < x \le 110$     | $x > 110$ |
| **Velocità**      | $x \le 110$ | $100 < x \le 250$    | $x > 250$ |

## Variabili

Per riuscire a realizzare il sistema abbiamo usufruito di quattro variabili:

1. un array contenente i nomi dei piloti
2. un array contenente le stringhe `"LOW"`, `"MEDIUM"`, `"HIGH"`
3. un array contenente le soglie tra i livelli
4. una stringa per scrivere `"Invalid"`.

L'array contenente i nomi dei piloti viene utilizzato nella funzione `telemetry` per capire se la prima riga del file è un pilota valido, mentre quelli contenenti le stringhe e le soglie vengono utilizzate nella funzione `telemetry_line` per stampare la giusta stringa in base al valore della statistica.

Questi array non sono altro che targhette salvate staticamente nel codice che poi vengono caricate una dopo l'altra contiguamente nello stack. Ad esempio per caricare le stringhe dei livelli abbiamo scritto:

> ```s
> /* Carica la stringa "HIGH". */
> leal level_02_str, %esi         # Carica l'indirizzo in %esi.
> movl %esi, -4(%ebp)             # e lo copia nello stack.
>
> /* Ripete la stessa operazione con "MEDIUM" e "LOW". */
> leal level_01_str, %esi
> movl %esi, -8(%ebp)
> leal level_00_str, %esi
> movl %esi, -12(%ebp)
> ```

Mentre per l'array delle soglie, essendo costituito da interi, non abbiamo utilizzato l'istruzione `leal` ma `movl`. Infine, la stringa `"Invalid"` viene usata anch'essa in `telemetry` nel caso in cui il pilota non sia stato riconosciuto.

## Funzioni

### Passaggio dei parametri

Prima di tutto, durante la chiamata di una funzione esistono due protagonisti, il **chiamante** ed il **chiamato**, che hanno responsabilità diverse.

Più precisamente, nello standard di chiamata C, il *chiamante* deve:

1. Eventualmente salvare i registri `%eax`, `%edx` ed `%ecx`
2. Caricare nello stack dall'ultimo al primo i vari parametri
3. Chiamare la funzione stessa
4. Recuperare il risultato dal registro `%eax` se necessario.

Viceversa, il *chiamato* ha il compito di:

1. Salvare il registro `%ebp` nello stack
2. Allocare eventuale spazio nello stack per le variabili
3. Salvare i registri `%ebx`, `%esi`, `%edi` se vengono utilizzati
4. Eseguire tutte le operazioni utili a produrre il risultato
5. Recuperare i registri se precedentemente salvati
6. Liberare lo spazio se precedentemente allocato
7. Recuperare il valore iniziale di `%ebp` dallo stack
8. Ritornare al chiamante.

### Funzioni di supporto

Per riuscire a implementare il sistema nel modo più comprensibile e ordinato possibile, abbiamo implementato delle funzioni di supporto come ad esempio le `strncmp` e `strncpy` della libreria standard C.

<!-- Nel blocco chiamante di una funzione:

- abbiamo caricato nello *stack*, dopo averli inseriti negli opportuni registri, i parametri da passare alla funzione, in ordine inverso così che possiamo estrarli più comodamente;

- abbiamo utilizzato l’istruzione `call`, che invoca la funzione specificata. Dopo che la funzione è terminata il valore restituito, se presente, si trova in `%eax`;

- conclusa la funzione, abbiamo liberato lo spazio di memoria che era stato riservato ai parametri della funzione, incrementando `%esp` di 4 byte per parametro, dato che siamo in un’architettura a 32 bit.


Nel blocco della funzione chiamata, durante la fase iniziale:

- abbiamo caricato il valore di `%ebp` nello *stack*, per salvare così il suo valore iniziale e ripristinarlo una volta conclusa la funzione;

- abbiamo salvato lo *stack* pointer in `%ebp`. Per accedere ai parametri e alle variabili locali si utilizza `%ebp` e un offset;

- abbiamo caricato nello *stack* i registri che utilizzeremo nella funzione e i cui valori vogliamo ripristinare conclusa la funzione;

- abbiamo utilizzato `%ebp` con un certo offset per salvare i parametri della funzione negli opportuni registri.

Prima di concludere la funzione:

- abbiamo salvato nel registro `%eax` l’eventuale valore da restituire;

- abbiamo estratto i registri caricati all’inizio della funzione;

- abbiamo estratto `%ebp` ripristinando così la sua posizione;

- abbiamo utilizzato l’istruzione `ret`, terminando la funzione e posizionando il programma all’istruzione successiva alla `call`. -->

#### Lunghezza di una stringa

> ```c
> unsigned int
> strlen(const char *str)
> {
>     const char *s = str;      // Copia l'indirizzo originale.
>
>     while (*s != 0)           // Finché non incontra il terminatore.
>         ++s;                  // incrementa il puntatore.
>
>     return s - str - 1;       // Restituisce la distanza tra i due.
> }
> ```

Calcola la lunghezza di una stringa escludendo il carattere terminatore.

#### Confronto tra stringhe

> ```c
> int
> strncmp(const char *str1, const char *str2, unsigned int num)
> {
>     char c1 = 0, c2 = 0;
>
>     do {
>         c1 = *str1++, c2 = *str2++;
>     } while (num-- > 0 && c1 != 0 && c1 == c2);
>
>     return c1 - c2;
> }
> ```

Confronta un certo numero di caratteri di due stringhe.

#### Ribaltamento di una stringa

> ```c
> char *
> strnrev(char *str, unsigned int num)
> {
>     char *s = str, *d = str + num, c = 0;
>
>     for (; s < d; ++s, --d)
>         c = *s, *s = *d, *d = c;
>
>     return str;
> }
> ```

Scambia un certo numero di caratteri di una stringa.

#### Copia di una stringa

> ```c
> unsigned int
> strncpy(char *dst, const char *src, unsigned int num)
> {
>     const char *s = src;
>     char *d = dst;
>
>     while (num-- > 0) {
>         if ((*d++ = *s++) == 0)
>             break;
>     }
>
>     return d - dst;
> }
> ```

Copia un certo numero di caratteri da una stringa in un'altra.

Solamente se il numero di caratteri da copiare supera la lunghezza della stringa sorgente, allora viene copiato anche il terminatore.

#### Copia di una stringa

> ```c
> unsigned int
> strlcpy(char *dst, const char *src, unsigned int num);
> {
>     int n = num;
>     const char *s = src;
>     char *d = dst;
>
>     while (--num > 0) {
>         if ((*d++ = *s++) == 0)
>             break;
>     }
>
>     if (num == 0 && n > 0)
>         *d = 0;
>
>     return d - dst;
> }
> ```

Copia un certo numero di caratteri da una stringa in un'altra.

Indipendentemente dallo stato della stringa sorgente, quella di destinazione viene terminata sempre, al prezzo di un carattere copiato in meno.

#### Conversione da stringa ad intero

> ```c
> unsigned int
> strtoi(const char *str)
> {
>     int res = 0;
>
>     while (*str >= 48 && *str <= 57)
>         res = res * 10 + *str++ - 48;
>
>     return res;
> }
> ```

Converte una stringa in un intero di base 10.

#### Conversione da intero a stringa

> ```c
> char *
> itostr(unsigned int num, char *str)
> {
>     int n = num;
>     char *s = str;
>
>     if (num != 0) {
>         do {
>             *s++ = (num % 10) + 48;
>         }  while (num /= 10);
>     } else
>         *s++ = 48;
>
>     *s = 0;
>
>     c_strnrev(str, s - str - 1);
>     return str;
> }
> ```

Converte un intero di base 10 in una stringa.

#### Separazione di una stringa

> ```c
> char*
> strsep(char **ptr, char sep)
> {
>     char *s = *ptr, *d = *ptr;
>
>     if (s != 0) {
>         while (*s != 0 && *s != sep)
>             ++s;
>
>         if (*s != 0) {
>             *s++ = 0;
>             *ptr = s;
>         } else
>             *ptr = 0;
>     }
>
>     return d;
> }
> ```

Spezza una stringa sul posto in base ad un certo carattere separatore.

<!--
#### Separazione di una stringa

> ```c
> unsigned int
> strnsep(char *arr[], unsigned num, char **ptr, char sep)
> {
>     int l = 0, c = 0;
>
>     while (l++ < num)
>         if ((*arr++ = strsep(ptr, sep)) != 0)
>             ++c;
>
>     return c;
> }
> ```

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
``` -->
