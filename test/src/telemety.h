#ifndef TELEMETRY_H
#define TELEMETRY_H

int
c_max(int val, int max);

int
c_telemetry_line(int arr[], char *dst);

void
c_telemetry_last(int arr[], char *src, char *dst);

void
c_telemetry_loop(int idx, char *src, char *dst);

int
c_telemetry(char *src, char *dst);

#endif /* TELEMETRY_H */
