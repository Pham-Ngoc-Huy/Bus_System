#!/usr/bin/perl
use strict;
use warnings;

# Set PNG Content-Type
print "Content-type: image/png\n\n";

# Path to the generated PNG file
my $output_png = "C:\\Users\\Huy.PhamN1\\Desktop\\BusSystem\\assignment_2 - Copy\\udrive\\www\\demo_form\\plot.png";

# Open and send the PNG file as binary
open(my $img, '<:raw', $output_png) or die "Cannot open image: $!";
binmode STDOUT;
print while (<$img>);
close($img);
