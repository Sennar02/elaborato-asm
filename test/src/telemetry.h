#ifndef TELEMETRY_H
#define TELEMETRY_H

/**
 * @brief Assegna ai tre valori di arr una targhetta tra
 *        LOW, MEDIUM, HIGH in base alla soglia in cui
 *        rientrano salvando le tre stringhe in dst
 *        separate da un virgola.
 *
 * @param arr Array cui vengono salvati i valori rpm,
 *            temperatura e velocità per ogni istante.
 * @param dst Stringa di destinazione.
 *
 * @return Il numero di caratteri scritti nella stringa dst.
 */
int
c_telemetry_line(int arr[], char *dst);

/**
 * @brief Inserisce i valori presenti in arr nella stringa dst.
 *
 * @param arr Array in cui vengono salvati i valori massimi
 *            di rpm, temperatura e velocità aggiungendo
 *            la velocità media.
 * @param src Stringa sorgente.
 * @param dst Stringa di destinazione.
 */
void
c_telemetry_last(int arr[], char *src, char *dst);

/**
 * @brief Estae da ogni riga i valori, nel caso in cui l'id
 *        corrisponde a quello del pilota, ordina i valori
 *        e li converte nei corrispettivi livelli.
 *        Una volta raggiunta la fine, stampa l'ultima riga
 *        con i valori massimi di rpm, temperatura e velocità
 *        aggiungendo anche la velocità media.
 *
 * @param idx Indice del pilota.
 * @param src Stringa sorgente.
 * @param dst Stringa di destinazione.
 */
void
c_telemetry_loop(int idx, char *src, char *dst);

/**
 * @brief Controlla se l'id del pilota è valido,
 * nel caso in cui lo sia chiama telemetry_loop,
 * altrimenti copia la stringa "Invalid\n".
 *
 * @param src Stringa sorgente.
 * @param dst Stringa di destinazione.
 *
 * @return 0 nel caso in cui tutto va a buon fine.
 */
int
c_telemetry(char *src, char *dst);

#endif /* TELEMETRY_H */
