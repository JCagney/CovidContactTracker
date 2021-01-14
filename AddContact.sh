#!/bin/bash

# A script to add a new customer to the list 

echo  "Enter full name: "
read name

# This loop is used for all variables read in and just checks that the user has in fact entered data
while [ "$name" == "" ]
do
  echo "You entered null. Please enter full name: "
  read name
done

echo "Enter postal address:" 
read address
while [ "$address" == "" ]
do
  echo "You entered null. Please enter postal address: "
  read address
done 

echo "Enter mobile phone number:"
read number
while [ "$number" == "" ]
do
  echo "You entered null. Please enter mobile phone number: "
  read number
done
# this loop checks that the variable is atually a number. If it is not the -eq will return an error which is then redirected to /dev/null
# and the user will have to re-enter the number  
while ! [ "$number" -eq "$number"  ] 2> /dev/null
do
   echo "Phone number must be numeric only. Please re-enter: " 
   read number 
done

echo "Enter email address:"
read email
while [ "$email" == "" ]
do
  echo "You entered null. Please enter email: "
  read email
done

#The email for each user must be unique. This loop runs a grep search to check if the email address entered is already present 
# If it is it tells the user which customer that address is listed under and they must reenter a unique email 
while  ( grep -q -i "$email" ContactDetails.txt )
do
   echo "That email is already listed under customer "$(grep -i "$email" ContactDetails.txt | awk -F\| '{print $1}')". Please enter a unique email address: "
   read email
done


echo "$name|$address|$number|$email" >> ContactDetails.txt
echo "User $name added to contacts."
