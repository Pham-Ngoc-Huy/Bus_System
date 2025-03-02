#!/usr/bin/perl	 

#----------------------------------------------------
# File: process_form.pl
# Created By: The Uniform Server Development Team
# Edited Last By: Mike Gleaves (ric) 
# Called from a page using a form.
# Small CGI demo for processing form data 
# Note server root relative link to CSS file
# Requires file random.txt 
# 21-2-2008
#----------------------------------------------------

use strict;
use CGI;
 my $cgi = new CGI;
 print
 $cgi->header() .
 $cgi->start_html( -title => 'Data from form',
  -author => 'UniCenter',
  -style => '/demo_form/perl_form.css') .
  $cgi->h1('Form Results') . "\n";
  my @params = $cgi->param();
  print '<TABLE border="1" cellspacing="0" cellpadding="0">' . "\n";
   foreach my $parameter (sort @params) {
     print "<tr><th>$parameter</th><td>" . $cgi->param($parameter) . "</td></tr>\n";
   }
  print "</TABLE>\n";
  print '<p><a href="/index.html">Home</a></p>';
  print $cgi->end_html . "\n";
exit (0);
	  

