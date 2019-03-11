*> ****************************************sieve.cob*****************************************
*> Author: Anugesh Balasubramaniam
*> Date: 04/07/2018
*> **********************************************************************************************

identification division.
program-id. sieve.
environment division.
input-output section.

*> Setup standard input and output variables
file-control.
    select standard-input assign to keyboard.
    select standard-output assign to display.
    select outputFile assign to "outputFile.txt"
        organization is line sequential.

data division.

*> Setup standard input and output interface
file section.
    fd standard-input.
        01 stdin-record pic x(80).
    fd standard-output.
        01 stdout-record pic x(80).
    fd outputFile.
        01 str.
            02 str-record pic 9(7).

*> Declaration of variables and messages to work within this file
working-storage section.
    77 inputStr pic x(6) value spaces.
    77 upperLimit pic 9(7) value 0.
    77 cnt pic 9(7) value 0.
    77 startTime pic 9(8) value 0.
    77 finishTime pic 9(8) value 0.
    77 runTime pic 9(8) value 0.
    01 arrayPrime.
        05 numPrime pic 9(7) occurs 9999999 times.
    01 askUser_line.
        02 pic x(68) value 'Enter the upper limit of prime numbers to calculate (2 or greater): '.

procedure division.
open input standard-input, output standard-output.

    *> Display the question and ask for the user input
    display " "
    display askUser_line.

    *> Read the keyboard input from the user
    read standard-input into upperLimit.

    *> capture the time of when the calculation starts
    accept startTime from TIME.

    *> Call the callPrime fuction and pass variables needed
    call "calcPrime" using upperLimit, arrayPrime.

    move 2 to cnt.
    open output outputFile.

    *> saves the prime numbers into a text file named "outputFile.txt"
    perform until cnt is greater than upperLimit
        if numPrime(cnt) is not equal to 0 then
            move numPrime(cnt) to str
            write str
            *> display numPrime(cnt)
        end-if
        add 1 to cnt
    end-perform.

    close outputFile.

    *> capture the time of when the calculation completes
    accept finishTime from TIME.

    *> calculate the total time spent performing the calculation
    compute runTime = finishTime - startTime.
    move runTime to inputStr.

    *> outputs the runtime in seconds of how long the program took to complete its calculation
    display "Runtime: " inputStr " seconds.".

