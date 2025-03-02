#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q = CGI->new;

my $filename = "/www/demo_form/data.txt";
open(my $fh, '<', $filename);
while()