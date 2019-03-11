/********************************************************************************************
 Author: Anugesh Balasubramaniam
 Date: 03/07/2018
**********************************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <ctype.h>
#include <string.h>

//function prototypes
void calcPrime(int upperLimit);
int isNumeric(char *userInput);


/*
/main function
/ - asks the user for the upper limit of prime numbers to calculate
/ - outputs the runtime in seconds of how long the program took to complete its calculation
 */
int main(int argc, char **argv)
{
    int upperLimit = 0;
    char userInput[8];
    double time_spent;
    
    printf("Enter the upper limit of prime numbers to calculate (2 or greater): ");
    scanf("%s", userInput);
    
    if (isNumeric(userInput) == 0){
        upperLimit = atoi(userInput);
        if (upperLimit == 0 || upperLimit == 1){
            printf("invalid input!\n");
            exit(0);
        }
    }
    
    clock_t begin = clock();//capture the time of when the calculation starts
    calcPrime(upperLimit);
    clock_t end = clock();//capture the time of when the calculation completes
    
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;//calculate the total time spent performing the calculation
    printf("Runtime: %0.4f seconds\n", time_spent);
    
    return 0;
}

/*
 /isNumeric function
 / INPUT: the user's upper limit input in the form of a string
 / - verifies if the user's upperLimit input is truly a numeric number
 / - returns 0 if it is numeric
 */
int isNumeric(char userInput[8]){
    for (int i = 0; i < strlen(userInput); i++){
        if (isdigit(userInput[i]) == 0){
            printf("invalid input!\n");
            exit(0);
        }
    }
    
    return 0;
}

/*
 /calcPrime function
 / - INPUT: the user's upper limit input in a form of an integer
 / - performs the calculation of the "Sieve of Eratosthenes" algorithm to calculate the prime numbers between 2 and the upper limit
 / - saves the prime numbers into a text file named "outputFile.txt"
 */
void calcPrime(int upperLimit)
{
    int primeArray[upperLimit];
    
    for (int i = 2; i <= upperLimit; i++){
        primeArray[i] = i;
    }
    
    for (int pivot = 2; pivot <= sqrt(upperLimit); pivot++){
        for (int j = pivot*pivot; j <= upperLimit; j+=pivot){
            primeArray[j] = 0;
        }
    }
    
    FILE *outputFile;
    
    outputFile = fopen("outputFile.txt", "w");
    
    for (int i = 0; i <= upperLimit; i++){
        if (primeArray[i] != 0){
            fprintf(outputFile,"%d\n",primeArray[i]);
        }
    }
    
    fclose(outputFile);
}
