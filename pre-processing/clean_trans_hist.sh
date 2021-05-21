#!/bin/bash
# Author: Fonyuy Boris Lami
# Created: 20th of May 2021
# Description: This script aims in cleaning the data by remove unnecessary delimiters

# Checking for valid number of command line arguments
if [ "$#" -ne 1 ] 
then
	echo "Error! Exactly 1 command line argument is required"
else
echo "Pre-data cleaning ..."
echo "Replacing \\r with \\n"
sed -i 's/\r/\n/g' $1 # replacing \r with \n (escape character cleaning)
echo "Removing all double qoutes"
sed -i 's/"//g' $1 # remove all double quotes 
echo "Removing all double semi columns and inserting ;NULL; for missing values"
sed -i 's/;;/;NULL;/g' $1 # remove all double semi columns 
echo "Removing all tail commas"
sed  -i $'s/,,,,,,,,,,,,,,,//g' $1 # remove all tail commas 
echo "Removing blank lines and joining"
sed  -i -e '/^2/bpp' -e 'H;$bpp' -e 'd'  -e ':pp' -e 'x;/^$/d;s/\n/ /g' $1 # remove blank lines and join taking advantage of 2 in 2xxx
echo "Pre-data cleaning complete"
fi
