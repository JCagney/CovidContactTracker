#!/bin/bash

# Script to allow user to search for an existing contact based on any personal info 

echo "Please enter serach criteria: " 

read search 

# use grep to check for if there are any results returned. -i option to ignore case, -q quiet option used to not output data  
if ( grep -i -q "$search" ContactDetails.txt )
then

# pipe search results into awk which which uses field seperator | to print out result formatted. Multiple results are spaced seperated by a blank line 
   grep -i "$search" ContactDetails.txt | awk -F\| '{print "Matching result: \n"$1", "$2", "$3", "$4"\n"}'

else 

  echo "No results" 

fi 
