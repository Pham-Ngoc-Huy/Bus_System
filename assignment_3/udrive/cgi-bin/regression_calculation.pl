#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q = CGI->new;

# Define the data file path
my $filename = "/www/demo_form/data.txt";

open(my $fh, '<', $filename);

my (@x_values, @y_values);

while (my $line = <$fh>) {
    chomp $line;

    my ($x, $y) = split(/,/, $line);

    $x = $x + 0;
    $y = $y + 0;

    push @x_values, $x;
    push @y_values, $y;
}
close($fh);

my $n = scalar @x_values;
if ($n == 0) {
    print "Content-type: text/plain\n\n";
    print "Error: No data found in file\n";
    exit;
}

my ($sum_x, $sum_y, $sum_xy, $sum_x2) = (0, 0, 0, 0);

for my $i (0 .. $#x_values) {
    $sum_x  += $x_values[$i];
    $sum_y  += $y_values[$i];
    $sum_xy += $x_values[$i] * $y_values[$i];
    $sum_x2 += $x_values[$i] ** 2;
}

my $denominator = ($n * $sum_x2 - $sum_x ** 2);
my $b = ($denominator == 0) ? 0 : (($n * $sum_xy - $sum_x * $sum_y) / $denominator);
my $a = ($n == 0) ? 0 : (($sum_y - $b * $sum_x) / $n);

my $params_file = "/www/demo_form/params.txt";
open(my $pf, '>', $params_file) or die "Cannot write $params_file: $!";
print $pf "$a\n$b\n";
close($pf);

# Print the results
print "Content-type: text/plain\n\n";
print "a (Intercept): $a\n";
print "b (Slope): $b\n";
