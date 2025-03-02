#!/usr/bin/perl

use strict;
use warnings;
use CGI;

my $q = CGI->new;

my $x = $q->param("x");
my $y = $q->param("y");

my $filename = "/www/demo_form/data.txt";
open(my $fh, '>>', $filename);
print $fh "$x,$y\n";
close($fh);

print $q->redirect("/demo_form/form.html");
