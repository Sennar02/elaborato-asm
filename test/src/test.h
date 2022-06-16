#ifndef TEST_H
#define TEST_H

#include <stdint.h>

/**
 * @brief Puntatore a funzione che rappresenta un test.
 *
 * @return 1 se il test ha avuto successo, 0 altrimenti.
 */
typedef uint8_t (*test_t) ();

/**
 * @brief Funzione che esegue una serie di test e memorizza
 *        quali non hanno avuto successo in un appostito array.
 *
 * @param fails Array dove memorizzare l'indice dei test non
 *              superati.
 * @param tests Array di test da eseguire.
 * @param len   Quantità di test da eseguire.
 *
 * @return Quantità di test che non hanno avuto successo.
 */
uint32_t
test(uint32_t fails[], test_t tests[], uint32_t len);

#endif /* TEST_H */
