#ifndef FILE_H
#define FILE_H

#include <stdint.h>
#include <stdio.h>

/**
 * @brief Struttura che rappresenta un file.
 */
typedef struct file file_t;

struct file
{
    // Quantità di byte allocati.
    uint32_t size;
    // Puntatore al file.
    FILE *file;
    // Contenuto del file.
    char *body;
    // Nome del file.
    const char *name;
    // Modalità di apertura.
    const char *mode;
};

/**
 * @brief Crea un nuovo stream.
 *
 * Questa funzione alloca ed inizializza lo stream aprendo
 * il file al momento della creazione e aggiornando la dimensione.
 * Non alloca però lo spazio per il contenuto e non lo legge.
 *
 * @param name Nome del file.
 * @param mode Modalità di apertura.
 *
 * @return Un puntatore al nuovo stream.
 */
file_t*
file_create(const char *name, const char *mode);

/**
 * @brief Apre la comunicazione con un file.
 *
 * Questa funzione restituisce un puntatore al file
 * senza modificare lo stream stesso, dunque è compito
 * del chiamante aggiornare l'informazione con il valore
 * restituito.
 *
 * @param self Puntatore ad uno stream.
 *
 * @return Un puntatore al file aperto.
 */
FILE*
file_open(file_t *self);

/**
 * @brief Chiude la comunicazione con un file
 *        precedentemente aperto.
 *
 * Questa funzione libera le risorse utilizzate e
 * riporta lo stream allo stato prima dell'apertura.
 *
 * @param self Puntatore ad uno stream.
 */
void
file_close(file_t *self);

/**
 * @brief Calcola la dimensione del file.
 *
 * Questa funzione restituisce la quantità di byte presenti
 * nel file senza modificare lo stream stesso, dunque è compito
 * del chiamante aggiornare l'informazione con il valore
 * restituito.
 *
 * @param self Puntatore ad uno stream.
 *
 * @return Quantità di byte contenuti nel file.
 */
uint32_t
file_size(file_t *self);

/**
 * @brief Legge il contenuto di un file.
 *
 * Questa funzione alloca lo spazio per leggere il file solamente
 * se il contenuto non è allocato o se la dimensione precedente
 * non è sufficiente a memorizzare tutto il contenuto.
 *
 * @param self Puntatore ad uno stream.
 *
 * @return Contenuto del file.
 */
const char*
file_read(file_t *self);

/**
 * @brief Scrive il contenuto su un file.
 *
 * Questa funzione libera e sovrascrive il contenuto
 * con la nuova stringa se il puntatore è valido,
 * altrimenti scrive semplicemente il contenuto.
 *
 * @param self Puntatore ad uno stream.
 * @param str  Puntatore ad un nuovo contenuto.
 */
void
file_write(file_t *self, char *str);

#endif /* FILE_H */
