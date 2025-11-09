#!/bin/bash
# This script will be used to check if a nuber is positive, negative or equal to zero.

read -p "Enter a number: " num

if [ $num -gt 0 ]; then
    echo "The number is positive"
    elif [ $num -lt 0 ]; then
    echo "The number is netgative"
    else 
    echo "The number is zero"
    fi