# Programma

## PASSAGGIO E RESTITUZIONE DEI VALORI DELLE FUNZIONI

Abbiamo suddiviso il programma in varie routine alle quali forniamo i parametri tramite lo *stack* del programma. Questo metodo richiede particolare attenzione perché lo *stack* viene usata anche dal sistema stesso.

## CHIAMATA DI UNA FUNZIONE E PASSAGGIO PARAMETRI

Nel blocco chiamante di una funzione:

- carichiamo nello *stack*, dopo averli inseriti negli opportuni registri, i parametri da passare alla funzione, in ordine inverso in modo da estrarli più comodamente;

- utilizziamo l’istruzione `call`, che invoca la funzione specificata. Dopo che la funzione è terminata, il valore restituito, se presente, si trova in `%eax`;

- conclusa la funzione, liberiamo lo spazio di memoria che era stato riservato ai parametri della funzione, incrementando `%esp` di *4* byte per parametro, dato che siamo in un’architettura a 32 bit.

## INIZIO/CONCLUSIONE DI UNA FUNZIONE E RESTITUZIONE DI UN VALORE

Nel blocco della funzione chiamata, durante la fase iniziale:

- carichiamo il valore di `%ebp` nello *stack*, per salvare così il suo valore iniziale e ripristinarlo una volta conclusa la funzione;

- salviamo lo *stack* pointer in `%ebp`. Per accedere ai parametri e alle variabili locali si utilizza `%ebp` e un offset;

- carichiamo nello *stack* i registri che vengono utilizzati dalla funzione e i cui valori vogliamo siano ripristinati conclusa la funzione;

- utilizzando `%ebp` con un certo offset, salviamo i parametri della funzione negli opportuni registri.

Prima di concludere la funzione:

- salviamo nel registro `%eax` l’eventuale valore da restituire;

- estraiamo i registri caricati all’inizio della funzione;

- estraiamo `%ebp` ripristinando così la sua posizione;

- utilizziamo l’istruzione `ret`, terminando la funzione e posizionando il programma all’istruzione successiva alla `call`.

### FUNZIONI USATE NEL PROGRAMMA 

**asm_strsep**

- viene chiamata da telemetry; *(scopo funzione)*

- *(Sistemare valori passati)* vengono passati 2 parametri:  
stringa -> `push %esi`;  
valore intero 10 -> `push $10`; 

- copia parametri nella funzione:  
valore intero -> `movl 8(%ebp), %esi`  
stringa -> `movb 12(%ebp), %bl`; 

- x 

**asm_strnsep** 

- x

- x

- x

- x

**asm_arrfind**  

- viene chiamata da telemetry *(scopo funzione)*; 

- *(Sistemare valori passati)* vengono passati 3 parametri:  
stringa -> `push %esi` ;  
valore intero 20 -> `push $20` ;  

- copia parametri nella funzione:

- x

**asm_strlen** 

- viene chiamata da arrfind; indica la lunghezza di una stringa; 

- viene passato 1 parametro:  
stringa -> `push 16(%ebp)` ; 

- copia parametri nella funzione:  
stringa -> `movl 8(%ebp), %esi` ; 

- viene restituito un valore intero che indica la lunghezza della stringa passata come parametro -> `movl %esi, %eax` . 

**asm_strncmp**

- viene chiamata da arrfind; serve per trovare la differenza di lunghezza tra due stringhe; 

- vengono passati 3 parametri:  
valore intero -> `push %eax`;  
seconda stringa -> `push (%esi)` ;  
prima stringa -> `push 16(%ebp)`; 

- copia parametri nella funzione:  
prima stringa -> `movl 8(%ebp), %esi` ;  
seconda stringa -> `movl 12(%ebp), %edi` ;  
valore intero -> `movl 16(%ebp), %ecx` ; 

- viene restituita la differenza numerica di caratteri tra le due stringhe, salvata in `%al`, quindi in `%eax` -> `subl %ecx, %eax` . 

**asm_itostr** 

- x

- vengono passati 3 parametri:  
secondo valore intero ;  
stringa ;  
primo valore intero; *(da finire)* 

- copia parametri nella funzione:  
primo valore intero -> `movl 8(%ebp), %eax` ;  
stringa -> `movl 12(%ebp), %esi` ;  
secondo valore intero -> `movl 16(%ebp), %ecx` ; 

- x

**asm_strlcpy** 

- x

- vengono passati 3 parametri:  
valore intero ;  
seconda stringa ;  
prima stringa ; 

- copia parametri nella funzione:   

- x

**asm_strncpy** 

- x

- x

- x

- x

**asm_strnrev** 

- viene chiamata da itostr; serve per invertire un certo numero di caratteri di una stringa; 

- vengono passati 2 parametri:  
valore intero (indica il numero di caratteri di una stringa da invertire) -> `push %eax`;  
stringa -> `push %edi`; 

- copia parametri nella funzione:  
stringa (viene copiata in due registri) -> `movl 8(%ebp), %esi` -- `movl 8(%ebp), %edi` ;  
valore intero (viene sommato ad un registro) -> `addl 12(%ebp), %edi`; 

- Viene restituita la stringa invertita -> `movl 8(%ebp), %eax` . 

**asm_strtoi** 

- *(Aggiungere chiamata)*; serve a convertire dei caratteri numerici in un valore numerico; 

- vengono passati 2 parametri:  
valore intero ;  
stringa; *(da finire)* 

- copia parametri nella funzione:  
stringa -> `movl 8(%ebp), %esi`;  
valore intero -> `movl 12(%ebp), %ecx` ; 

- viene resituito il valore numerico; è dato dalla somma tra `%eax` e `%ebx`, il secondo viene manipolato dalla funzione -> `addl %ebx, %eax` . 
