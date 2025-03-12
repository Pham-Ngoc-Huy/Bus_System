#!/usr/bin/perl

use strict;
use warnings;
use CGI;

my $cgi = CGI->new;
print $cgi->header('text/plain');
my $filename = "/www/demo_form/data.txt";
my $plotfile = "/www/demo_form/plot_script.plt";
my $paramfile = "/www/demo_form/params.txt";

if (open(my $fh, '>', $filename)) {
    close($fh);
    print "File data.txt has been cleared!\n";
} else {
    print "Error: Could not clear the file!\n";
}

if (open(my $gh, '>', $paramfile)) {
    close($gh);
    print "File params.txt has been cleared!\n";
} else {
    print "Error: Could not clear the file: $!\n";
}

if (open(my $sh, '>', $plotfile)) {
    close($sh);
    print "File plot_script.plt has been cleared!\n";
} else {
    print "Error: Could not clear the file: $!\n";
}
