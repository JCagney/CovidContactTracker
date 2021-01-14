#!/bin/bash


# A script to remove a user from the file 

echo "Enter the email of the contact to be deleted: " 

read email

# This checks if there are any matches in the file. The quiet option is used to prevent output: 
if ( grep -q -i "$email" ContactDetails.txt)

then
  
   # The variable matches is the number of matching results. If there is only one match then the program will proceed
   # If there are more than one then the user will be asked to refine their search  
    matches=$(grep -c -i "$email" ContactDetails.txt)
   if [ $matches -eq 1 ]
   then 
      grep -i "$email" ContactDetails.txt | awk -F\| '{print "Do you want to delete "$1"?(y/n)"}'

      read confirm 

      if [ $confirm == y ]
      then
         # If the user confirms the deletion than sed is used to delete the line in the file. Any blank lines are also deleted 
         sed -i "/$email/d" ContactDetails.txt
         sed -i '/^$/d' ContactDetails.txt
         echo "Contact Deleted" 

      else 

         echo "Contact not deleted" 

      fi  
   else 
      echo "There is more than one match. Please refine your search."
   fi 		

else
echo "Contact not found"
fi


