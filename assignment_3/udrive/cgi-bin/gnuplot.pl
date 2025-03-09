#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q = CGI->new;
print $q->header(-type => "text/html", -charset => "UTF-8");

my $x = $q->param("x");
my $y = $q->param("y");

my $data_file = "/www/demo_form/data.txt";
my $graph_file = "/www/demo_form/plot.png";

my $a = 1;  
my $b = 0;  

# Gọi Gnuplot để vẽ đồ thị
open (my $gnuplot, "/www/GNU/gnuplot/bin/gnuplot.exe");
print $gnuplot <<EOF;
plot 12*x + 13 
EOF
