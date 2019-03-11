#!/usr/bin/python
import math
import time

""" Compile & run program
   -   python sieve.py """

primeArray = []

"""Asks the user for the upper limit of prime numbers to calculate"""
"""verifies if the user's upperLimit input is truly a numeric number"""
try:
    upperLimit = int(raw_input('Enter the upper limit of prime numbers to calculate (2 or greater): '))
except ValueError:
    print "Invalid input"
    exit()

"""capture the time of when the calculation starts"""
start_time = time.time()

"""
- performs the calculation of the "Sieve of Eratosthenes" algorithm to calculate the prime numbers between 2 and the upper limit
- saves the prime numbers into a text file named "outputFile.txt"
"""

for i in range (2,upperLimit+1):
    primeArray.append(i)
    
for pivot in range (2,int(math.sqrt(upperLimit))+1):
    for j in range ((pivot*pivot), upperLimit+1, pivot):
        if j in primeArray:
            primeArray.remove(j)


outputFile = open('outputFile.txt','w')
for k in primeArray:
    outputFile.write(str(k) + "\n")

outputFile.close()

"""outputs the runtime in seconds of how long the program took to complete its calculation"""
print("Runtime: %s seconds" % (time.time() - start_time));
