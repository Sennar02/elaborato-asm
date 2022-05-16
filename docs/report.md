# Programma

## PASSAGGIO E RESTITUZIONE DEI VALORI DELLE FUNZIONI

Abbiamo suddiviso il programma in varie routine alle quali forniamo i parametri tramite lo *stack* del programma. Questo metodo richiede particolare attenzione perché lo *stack* viene usata anche dal sistema stesso.

## CHIAMATA DI UNA FUNZIONE E PASSAGGIO PARAMETRI

Nel blocco chiamante di una funzione:

- carichiamo nello *stack*, dopo averli inseriti negli opportuni registri, i parametri da passare alla funzione, in ordine inverso in modo da estrarli più comodamente;

- utilizziamo l’istruzione `call`, che invoca la funzione specificata. Dopo che la funzione è terminata, il valore restituito, se presente, si trova in `eax`;

- conclusa la funzione, liberiamo lo spazio di memoria che era stato riservato ai parametri della funzione, incrementando `esp` di *4* byte per parametro, dato che siamo in un’architettura a 32 bit.

## INIZIO/CONCLUSIONE DI UNA FUNZIONE E RESTITUZIONE DI UN VALORE

Nel blocco della funzione chiamata, durante la fase iniziale:

- carichiamo il valore di `ebp` nello *stack*, per salvare così il suo valore iniziale e ripristinarlo una volta conclusa la funzione;

- salviamo lo *stack* pointer in `ebp`. Per accedere ai parametri e alle variabili locali si utilizza `ebp` e un offset;

- carichiamo nello *stack* i registri che vengono utilizzati dalla funzione e i cui valori vogliamo siano ripristinati conclusa la funzione;

- utilizzando `ebp` con un certo offset, salviamo i parametri della funzione negli opportuni registri.

Prima di concludere la funzione:

- salviamo nel registro `eax` l’eventuale valore da restituire;

- estraiamo i registri caricati all’inizio della funzione;

- estraiamo `ebp` ripristinando così la sua posizione;

- utilizziamo l’istruzione `ret`, terminando la funzione e posizionando il programma all’istruzione successiva alla `call`.
