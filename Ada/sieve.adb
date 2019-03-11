-- *********************************************************************************************
-- Author: Anugesh Balasubramaniam
-- Date: 04/07/2018
-- *********************************************************************************************


with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Elementary_Functions;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.unbounded; use Ada.Strings.unbounded;
with Ada.Strings.unbounded.text_io; use Ada.Strings.unbounded.text_io;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Calendar; use Ada.Calendar;

procedure sieve is
-- asks the user for the upper limit of prime numbers to calculate
-- outputs the runtime in seconds of how long the program took to complete its calculation

inputUpperLimit: unbounded_string;
upperLimit: Natural;
startTime, finishTime : Time;
milliSeconds : Duration;

    procedure calcPrime (upperLimit: Natural) is
    -- performs the calculation of the "Sieve of Eratosthenes" algorithm to calculate the prime numbers between 2 and the upper limit
    -- saves the prime numbers into a text file named "outputFile.txt"

        primeArray: array (1..upperLimit) of Natural;
        j : Integer;
        squaredUpperLimit : Natural;
        outputFile : file_Type;

    begin
        for i in 2..upperLimit loop
            primeArray(i) := i;
        end loop;

        squaredUpperLimit := Natural(Ada.Numerics.Elementary_Functions.Sqrt(Float(upperLimit)));

        for pivot in 2..squaredUpperLimit loop
            j := pivot*pivot;
            while j <= upperLimit loop
                primeArray(j) := 0;
                j := j + pivot;
            end loop;
        end loop;

        create(outputFile,out_file,"outputFile.txt");

        for i in 2..upperLimit loop
            if primeArray(i) /= 0 then
                Put_Line(outputFile,Natural'Image(primeArray(i)));
            end if;
        end loop;

        close(outputFile);

    end calcPrime;

begin

Put_Line("Enter the upper limit of prime numbers to calculate (2 or greater): ");
Get_Line(inputUpperLimit);

upperLimit := Natural'Value(To_String (inputUpperLimit));

startTime := Clock; -- capture the time of when the calculation starts
calcPrime(upperLimit);
finishTime := Clock; -- capture the time of when the calculation completes

milliSeconds := (finishTime - startTime); -- calculate the total time spent performing the calculation

Put_Line("Runtime: " & Duration'Image(milliSeconds) & " seconds");

end primeCalc;
