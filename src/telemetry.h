#ifndef TELEMETRY_H
#define TELEMETRY_H

extern int
telemetry_line(int arr[], char *dst, int pnts[], const char *strs[]);

extern void
telemetry_last(int arr[], char *src, char *dst);

extern void
telemetry_loop(int idx, char *src, char *dst);

extern int
telemetry(char *src, char *dst);

#endif /* TELEMETRY_H */
