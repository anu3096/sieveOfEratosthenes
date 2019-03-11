! **********************************************************************************************
! Author: Anugesh Balasubramaniam
! Date: 03/07/2018
! **********************************************************************************************


program main

! main program
! - call the sieve subroutine to start off with the question to the user

    implicit none

    call sieve

end program main

subroutine sieve

! sieve subroutine
! - asks the user for the upper limit of prime numbers to calculate
! - outputs the runtime in seconds of how long the program took to complete its calculation

    implicit none

    real :: start, finish
    integer :: upperLimit, getInput

    write (*,*) "Enter the upper limit of prime numbers to calculate:"

    upperLimit = getInput(upperLimit)

! capture the time to when the calculation starts
    call cpu_time(start)
    call calcPrime(upperLimit)
! capture the time to when the calculation completes
    call cpu_time(finish)
! calculate the total time spent performing the calculation and write it to the screen
    write(*,*) "Runtime:",finish-start,"seconds"

end subroutine sieve

integer function getInput(upperLimit)

! getInput function
! - gets the upper limit input from the user and verifies that it is a valid number to work with

    implicit none

    integer :: upperLimit
    integer :: error
    logical :: invalidInput

    invalidInput = .TRUE.


    do while(invalidInput)
        read (*,*,iostat=error) upperLimit
        if ((error == 0) .AND. (1 < upperLimit)) then
            invalidInput = .FALSE.
        else
            write (*,*) "Invalid input! Enter a number 2 or greater"
            write (*,*) "Enter the upper limit of prime numbers to calculate:"
        endif
    enddo

    getInput = upperLimit
    return
end function getInput



subroutine calcPrime(upperLimit)

! calcPrime function
! - performs the calculation of the "Sieve of Eratosthenes" algorithm to calculate the prime numbers between 2 and the upper limit
! - saves the prime numbers into a text file named "outputFile.txt"

    implicit none

    integer:: upperLimit, tempSquareLimit
    real :: tempUpperLimit, squareUpperLimit
    integer :: i, j, k, pivot
    integer :: primeArray(upperLimit)

    tempUpperLimit = upperLimit
    squareUpperLimit = sqrt(tempUpperLimit)
    tempSquareLimit = squareUpperLimit

    do i = 2,upperLimit
        primeArray(i) = i
    enddo

    do pivot = 2,tempSquareLimit
        do j = (pivot*pivot), upperLimit, pivot
            primeArray(j) = 0
        enddo
    enddo

    open(unit = 2, file = "outputFile.txt")

    do k = 2, upperLimit
        if (primeArray(k) /= 0) write(2,*)primeArray(k)
    enddo

    close(2)
end subroutine calcPrime
