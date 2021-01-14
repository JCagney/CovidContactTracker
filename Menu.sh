#!/bin/bash

#a script to present a menu with options 

# -e option used here to allow use of \n for new lines 
echo -e "\n Welcome to the Covid-19 Contact Log Tracing App.\n\n Here are your options: \n"

# an array of the options is declared in order to be able to use multiple words in each option  
options=("Add a New Customer" "Remove an Existing Customer" "Search for a Customer" "Email a Customer" "Quit") 
PS3='Please choose a menu option number: '

# the select command iterates throguh the options array 
select option in "${options[@]}"
do 

	if [ "$option" == "Quit" ]
		then
		echo 'You chose to quit, so long'
		break

	elif [ "$option" == "Add a New Customer" ]
		then
		./AddContact.sh

	elif [ "$option" == "Remove an Existing Customer" ]
		then
		./Remove.sh

	elif [ "$option" == "Search for a Customer" ]
                then
                ./Search.sh
        
	elif [ "$option" == "Email a Customer" ]
		then
		   echo "Do you want to email all customers? (y/n)" 
                   read response

                   if [ "$response" == "y" ]
                   then

                    #the following command sends a mail to all users via the awk command printing out the column of email addresses 
                     mail $(awk -F\| '{print $4}' ContactDetails.txt)
                     echo "Mail sent to all customers"   
                     else

                        echo "Enter customer email address: "
			read name
                        if ( grep -q -i "$name" ContactDetails.txt)
			then

                           # the matches variable indicates the number of matches found. There is at least 1 as we know there was a positive result
                           # from the search. If there is more than one the user will be told to refine their search  
			   matches=$(grep -c -i "$name" ContactDetails.txt)

			   if [ $matches -eq 1 ]
		           then 
			      grep -i -s "$name" ContactDetails.txt | awk -F\| '{print "Do you want to email "$1"? (y/n)"}'
			      read choice

			      if [ "$choice" == "y" ]
			      then
                                 # This uses awk to select the email ($4) from the line 
                                 # It is assigned to variable email and then the mail command ia used   
                                 email=$(grep -i -s "$name" ContactDetails.txt | awk -F\| '{print $4}')
			      	 mail $email
				 echo "Mail sent" 
			      fi
			  else
                             echo "There is more than one match. Please refine your search." 
                          fi
			else
 			   echo "Contact not found"
			fi
                   fi
	else 
	   echo "Invalid option"
	fi
done
