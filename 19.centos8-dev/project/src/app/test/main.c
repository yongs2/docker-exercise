#include <stdio.h>
#include "testlib.h"

int main() {
    int nWaitMs = 1000;

    printf(">> Call Sleep_m(%d)\n", nWaitMs);
    Sleep_m(nWaitMs);
    printf(">> End\n");

    return 0;
}
