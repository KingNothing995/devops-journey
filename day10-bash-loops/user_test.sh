#!/bin/bash
# ask user until they type "yes"

while true; do 
    read -p "Do you want to continue? (yes/no): " answer
    if [ "$answer" = "yes" ]; then
    echo "Good choice!"
    break # exit the loop
    elif [ "$answer" = "no" ]; then
        echo "Okay, exiting."
         exit 0
    else
         echo "Pleas say yes or no."
    fi
    done