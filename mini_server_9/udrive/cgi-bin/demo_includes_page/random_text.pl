#!/usr/bin/perl

#----------------------------------------------------
# File: random_text.pl
# Created By: The Uniform Server Development Team
# Edited Last By: Mike Gleaves (ric) 
# Called from a page using a SSI command.
# Displays a random section of text can use HTML 
# CSS in the text for formating
# Requires file random.txt 
# 8-8-2008
#----------------------------------------------------

$|=1;                                      # tells server to send the information out ASAP

$random_file = "random.txt";               # Random file text.
$delimiter = "\n\%\%\n";                   # Delimiter to seperate content

open(FILE,"$random_file");                 # Open the file containing text.
@FILE = <FILE>;
close(FILE);

$sections = join('',@FILE);                # Create one large string.
@sections = split(/$delimiter/,$sections); # Split this string according to the $delimiter.

srand(time ^ $$);                          # Start srand with a seed time and pid.
$section = rand(@sections);                # Get a random element of the array returns a number.

print "Content-type: text/html\n\n";       # Print out the Content-type header
                                           # This instructs Apache what type of data we are returning

print $sections[$section];                 # Use number to select array element output text with print.

exit;                                      # Finished hence exit.

