Scrivere la funzione `select` sia in C che in Assembly, e scrivere anche i relativi test.

```c
typedef enum values
{
    LOW, // = 0
    MED, // = 1
    HIG, // = 2
    SIZE // = 3
}
values_t;

const char *strings[SIZE] = {
    "LOW", "MEDIUM", "HIGH"
}

int
select(int val, int arr[], int len)
{
    for (int i = 0; i < len; ++i)
        if (val <= arr[i]) return i;

    return len;
}
```
