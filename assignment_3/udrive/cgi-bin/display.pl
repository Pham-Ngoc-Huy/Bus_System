#!/usr/bin/perl
use strict;
use warnings;

print "Content-type: image/png\n\n";

my $output_png = "C:\\Users\\Huy.PhamN1\\Desktop\\BusSystem\\assignment_3\\udrive\\www\\demo_form\\plot.png";

open(my $img, '<:raw', $output_png) or die "Cannot open image: $!";
binmode STDOUT;
print while (<$img>);
close($img);
