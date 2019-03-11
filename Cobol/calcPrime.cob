identification division.
program-id. calcPrime.
environment division.
input-output section.

file-control.
    select standard-output assign to display.

data division.

file section.
fd standard-output.
    01 stdout-record picture x(80).

working-storage section.
    77 cnt pic 9(7) value 0.
    77 sqrtUpperLimit pic 9(7) value 0.
    77 pivot pic 9(7) value 0.

linkage section.
    77 upperLimit pic 9(7) value 0.
    01 primeArray.
        05 primeNum pic 9(7) occurs 9999999 times.

*> performs the calculation of the "Sieve of Eratosthenes" algorithm to calculate the prime numbers between 2 and the upper limit
procedure division using upperLimit, primeArray.
    move 2 to cnt.

    perform until cnt is greater than upperLimit
        move cnt to primeNum(cnt)
        add 1 to cnt
    end-perform.

    move 2 to pivot.
    move 0 to cnt.
    compute cnt rounded = pivot ** 2
    compute sqrtUpperLimit rounded = upperLimit ** 0.5

    perform pivot-loop
        until pivot is greater than sqrtUpperLimit.

    pivot-loop.
        perform inner-loop
            until cnt is greater than upperLimit.
        add 1 to pivot.
        compute cnt rounded = pivot ** 2.
        inner-loop.
            move 0 to primeNum(cnt)
            add pivot to cnt.




