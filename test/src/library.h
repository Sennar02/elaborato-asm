#ifndef LIB_H
#define LIB_H

/**
 * @brief Calcola la lunghezza di una stringa
 *        escludendo il carattere terminatore.
 *
 * @param str Stringa su cui operare.
 *
 * @return La lunghezza.
 */
int
c_strlen(const char *str);

/**
 * @brief Confronta un certo numero di caratteri di due stringhe.
 *
 * @param str1 Stringa da confrontare.
 * @param str2 Stringa con cui confrontare.
 * @param num Numero massimo di caratteri da confrontare.
 *
 * @return 0 se sono uguali, -1 se str1 è minore di str2,
 *         1 se str1 è maggiore di str2.
 */
int
c_strncmp(const char *str1, const char *str2, int num);

/**
 * @brief Ribalta un certo numero di caratteri di una stringa.
 *
 * @param str Stringa su cui operare.
 * @param num Numero di caratteri da ribaltare.
 *
 * @return Un puntatore alla stringa stessa.
 */
char *
c_strnrev(char *str, int num);

/**
 * @brief Copia un certo numero di caratteri da una stringa
 *        in un altra.
 *
 * Solamente se il numero di caratteri da copiare supera la
 * lunghezza della stringa sorgente, allora viene copiato
 * anche il terminatore.
 *
 * @param dst Stringa di destinazione.
 * @param src Stringa sorgente.
 * @param num Numero massimo di caratteri da copiare.
 *
 * @return Numero di caratteri copiati effettivamente.
 */
int
c_strncpy(char *dst, const char *src, int num);

/**
 * @brief Copia un certo numero di caratteri da una stringa
 *        in un altra.
 *
 * Indipendentemente dallo stato della stringa sorgente, quella
 * di destinazione viene terminata sempre al prezzo di un carattere
 * copiato in meno.
 *
 * @param dst Stringa di destinazione.
 * @param src Stringa sorgente.
 * @param num Numero massimo di caratteri da copiare.
 *
 * @return Numero di caratteri copiati effettivamente.
 */
int
c_strlcpy(char *dst, const char *src, int num);

/**
 * @brief Converte una stringa in un intero di base 10.
 *
 * @param str Stringa da convertire.
 *
 * @return Numero intero nella base specificata.
 */
int
c_strtoi(const char *str);

/**
 * @brief Converte un intero di base 10 in una stringa.
 *
 * @param num Numero da convertire.
 * @param str Stringa di destinazione.
 *
 * @return Un puntatore alla stringa di destinazione.
 */
char *
c_itostr(unsigned int num, char *str);

/**
 * @brief Spezza una stringa sul posto in base ad un certo
 *        carattere separatore.
 *
 * @param ptr Indirizzo della stringa da spezzare.
 * @param sep Carattere separatore.
 *
 * @return Segmento iniziale della stringa.
 */
char *
c_strsep(char **ptr, char sep);

/**
 * @brief Spezza una stringa sul posto in base ad un certo
 *        carattere separatore più volte.
 *
 * @param arr Array in cui salvare i segmenti.
 * @param num Lunghezza dell'array.
 * @param ptr Indirizzo della stringa da spezzare.
 * @param sep Carattere separatore.
 *
 * @return Numero di separazioni non nulle.
 */
int
c_strnsep(char *arr[], int num, char **ptr, char sep);

/**
 * @brief Restituisce il massimo tra due interi.
 *
 * @param val Primo valore.
 * @param max Secondo valore.
 *
 * @return Il valore massimo.
 */
int
c_max(int val, int max);

/**
 * @brief Verifica in quale intervallo si trova un determinato valore.
 *
 * @param val Valore su cui operare.
 * @param arr Array di valori che determinano le soglie.
 * @param len Lunghezza dell'array.
 *
 * @return L'indice dell'intervallo in cui si trova il valore.
 */
int
c_select(int val, int arr[], int len);

/**
 * @brief Cerca una particolare chiave all'interno di un array.
 *
 * @param arr Array di stringhe.
 * @param len Lunghezza dell'array.
 * @param key Chiave da ricercare.
 *
 * @return -1 se non è presente, altrimenti la posizione
 *         della stringa nell'array.
 */
int
c_arrfind(const char *arr[], int len, const char *key);

#endif /* LIB_H */
