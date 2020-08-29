#include <stdio.h>

void printArray(int na[]);

int main() {
        int test[] = {1, 2, 3};
        printArray(test);
        test[3] = 4;
        printArray(test);

        return 0;
}

void printArray(int na[]) {
        int i;
        for (i = 0; i < na.length; i++) {
                printf("%d\n", i);
        }

}
