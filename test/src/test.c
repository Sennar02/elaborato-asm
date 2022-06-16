#include "test.h"

uint32_t
test(uint32_t fails[], test_t tests[], uint32_t len)
{
    uint32_t j = 0;

    for (uint32_t i = 0; i < len; ++i) {
        // Se l'i-esimo test non è stato superato
        // allora viene inserito il suo indice.
        if (tests[i]() == 0)
            fails[j++] = i;
    }

    return j;
}
