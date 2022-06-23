int
c_strlen(const char *str)
{
    const char *s = str;

    while (*s++ != 0);

    return s - str - 1;
}

int
c_strncmp(const char *str1, const char *str2, int num)
{
    char c1 = 0, c2 = 0;

    do {
        c1 = *str1++, c2 = *str2++;
    } while (num-- > 0 && c1 != 0 && c1 == c2);

    return c1 - c2;
}

char *
c_strnrev(char *str, int num)
{
    char *s = str, *d = str + num, c = 0;

    for (; s < d; ++s, --d)
        c = *s, *s = *d, *d = c;

    return str;
}

int
c_strncpy(char *dst, const char *src, int num)
{
    const char *s = src;
    char *d = dst;

    while (num-- > 0) {
        if ((*d++ = *s++) == 0)
            break;
    }

    return d - dst;
}

int
c_strlcpy(char *dst, const char *src, int num)
{
    int n = num;
    const char *s = src;
    char *d = dst;

    while (--num > 0) {
        if ((*d++ = *s++) == 0)
            break;
    }

    if (num == 0 && n > 0)
        *d = 0;

    return d - dst;
}

int
c_strtoi(const char *str)
{
    int res = 0;

    while (*str >= 48 && *str <= 57)
        res = res * 10 + *str++ - 48;

    return res;
}

char*
c_itostr(unsigned int num, char *str)
{
    int n = num;
    char *s = str;

    if (num != 0) {
        do {
            *s++ = (num % 10) + 48;
        }  while (num /= 10);
    } else
        *s++ = 48;

    *s = 0;

    c_strnrev(str, s - str - 1);
    return str;
}

char*
c_strsep(char **ptr, char sep)
{
    char *s = *ptr, *d = *ptr;

    if (s != 0) {
        while (*s != 0 && *s != sep)
            ++s;

        if (*s != 0) {
            *s++ = 0;
            *ptr = s;
        } else
            *ptr = 0;
    }

    return d;
}

int
c_strnsep(char *arr[], int num, char **ptr, char sep)
{
    int l = 0, c = 0;

    while (l++ < num)
        if ((*arr++ = c_strsep(ptr, sep)) != 0)
            ++c;

    return c;
}

int
c_arrfind(const char *arr[], int len, const char *key)
{
    int num = c_strlen(key);

    for (int i = 0; i < len; ++i) {
        if (c_strncmp(key, arr[i], num) == 0)
            return i;
    }

    return -1;
}

int
c_select(int val, int arr[], int len)
{
    for (int i = 0; i < len; ++i)
        if (val <= arr[i]) return i;

    return len;
}


static const char *names[] = {
    "Pierre Gasly",
    "Charles Leclerc",
    "Max Verstappen",
    "Lando Norris",
    "Sebastian Vettel",
    "Daniel Ricciardo",
    "Lance Stroll",
    "Carlos Sainz",
    "Antonio Giovinazzi",
    "Kevin Magnussen",
    "Alexander Albon",
    "Nicholas Latifi",
    "Lewis Hamilton",
    "Romain Grosjean",
    "George Russell",
    "Sergio Perez",
    "Daniil Kvyat",
    "Kimi Raikkonen",
    "Esteban Ocon",
    "Valtteri Bottas"
};

static int treshs[] = {
    5000, 10000, // giri
    90,   110,   // temperatura
    100,  250,   // velocità
};

static const char *levels[] = {
    "LOW", "MEDIUM", "HIGH"
};

int
c_max(int val, int max)
{
    if (val > max)
        return val;
    else
        return max;
}

int
c_sum(int val, int sum)
{
    return val + sum;
}

int
c_telemetry_line(int arr[], char *dst)
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

void
c_telemetry_last(int arr[], char *src, char *dst)
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

void
c_telemetry_loop(int idx, char *src, char *dst)
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

                dst += c_telemetry_line(val, dst);

                tst[0] = c_max(tst[0], val[0]);
                tst[1] = c_max(tst[1], val[1]);
                tst[2] = c_max(tst[2], val[2]);
                tst[3] = c_sum(tst[3], val[2]);

                cnt += 1;
            }
        }
    }

    tst[3] = tst[3] / cnt;
    c_telemetry_last(tst, s, dst);
}

int
c_telemetry(char *src, char *dst)
{
    char *lin = c_strsep(&src, '\n');
    int idx = c_arrfind(names, 20, lin);

    if (idx >= 0)
        c_telemetry_loop(idx, src, dst);
    else
        c_strlcpy(dst, "Invalid", 8);

    return 0;
}
