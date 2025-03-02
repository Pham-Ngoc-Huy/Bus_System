#!/usr/bin/perl	 
#----------------------------------------------------
# File: index.pl
# Created By: The Uniform Server Development Team
# Edited Last By: Mike Gleaves (ric) 
# Single page web site.
# 8-8-2008
#----------------------------------------------------

print "Content-type: text/html\r\n\r\n";
print "<HTML>\n";
print "<HEAD><TITLE>Uniform Server Test</TITLE></HEAD>\n";
print '<link href="/test2/main.css" rel="stylesheet" type="text/css">';
print "<BODY>\n";
require header; # Page top
# Page content follows
#-----------------------------------------------------------------------
if ($ENV{'REQUEST_METHOD'} eq "GET"){   # Read query string
 $request = $ENV{'QUERY_STRING'};
}
@parameter_list = split(/&/,$request);  # split string on '&' characters
                                        # gives name and value pairs in array

foreach (@parameter_list) {             # create an associative array
    ($name, $value) = split(/=/);       # splits each entry on the "=" sign
    $passed{$name} = $value;            # use values to build passed array
}
#--- Input Validation -----------------------------------------------------
# The $selected string must point to a valid page. Size of my site
# this is fine! For 50 chapters or more with differing pages well!!!
#--Check page is valid
if ($passed{"page"} eq "home"    ||
    $passed{"page"} eq "about"   ||
    $passed{"page"} eq "links"   ||
    $passed{"page"} eq "contact" ||
    $passed{"page"} eq "book1"){
    $selected = $passed{"page"};  # Page valid use it, now check for valid
                                  # chapter
     #-- Check chapter is valid
     if($passed{"page"} eq "book1"){
       if($passed{"chapter"} eq "chapter1" ||
          $passed{"chapter"} eq "chapter2"){
          $selected = $selected . "_" . $passed{"chapter"}; # OK add to selection
        #-- now check for valid chapter page
        if($passed{"pg"} eq "page1" ||
          $passed{"pg"} eq "page2" ||
          $passed{"pg"} eq "page3"){
          $selected = $selected . "_" . $passed{"pg"}; # OK add to selection
        }#End pg

       }#End chapter
     }# End book

}# End page if
#--Page not valid set default
else{
 $selected ="home"
}
#--- End Validation-------------------------------------------------------

# At this stage we have a string we can use to select content pages
# These content pages are contain perlscripts hence use the variable as follows:

$selected = $selected . ".pl"; 
do $selected; # Pull in content page information

print "<br>";
print '<div style="width:300px;padding:4px;border: 1px solid #0000ff">';
print "<b><i>Displays decoded Query String</i></b><br>";
print "Page = " . $passed{"page"} . "<br>";
print "Chapter = " . $passed{"chapter"} . "<br>";
print "Pg = " . $passed{"pg"} . "<br>";
print "Selected page = " . $selected . "<br>";
print "</div>";
print "<br>";

require nav;    # Nav must be above footer
require footer; # Page bottom

print "</BODY>\n";
print "</HTML>\n";
exit (0);