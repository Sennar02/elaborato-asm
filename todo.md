Scrivere la funzione `c_switch` sia in C che in Assembly, e scrivere anche i relativi test.

```c
int
c_switch(int val, int arr[], int len)
{
    for (int i = 0; i < len; ++i)
        if (val <= arr[i]) return i;

    return len - i;
}
```
