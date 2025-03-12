#!/usr/bin/perl
use strict;
use warnings;

print "Content-type: text/html\n\n";

my $gnuplot_path = "C:\\Users\\Huy.PhamN1\\Desktop\\BusSystem\\assignment_2 - Copy\\udrive\\www\\GNU\\gnuplot\\bin\\gnuplot.exe";
my $gnuplot_script = "/www/demo_form/plot_script.plt";
my $output_png = "/www/demo_form/plot.png";

# Read parameters a and b
my $params_file = "/www/demo_form/params.txt";
open(my $pf, '<', $params_file) or die "Cannot read $params_file: $!";
my $a = <$pf>;
my $b = <$pf>;
chomp($a, $b);
close($pf);

# Create the Gnuplot script
open my $gp, '>', $gnuplot_script or die "Cannot open $gnuplot_script: $!";
print $gp "set terminal png\n";
print $gp "set output '$output_png'\n";
print $gp "set title 'Regression Line: y = $a + $b*x'\n";
print $gp "set xlabel 'X-axis'\n";
print $gp "set ylabel 'Y-axis'\n";
print $gp "plot $a + $b*x with lines title 'y = $a + $b*x'\n";
close $gp;

# Run Gnuplot
system("\"$gnuplot_path\" \"$gnuplot_script\"") == 0 or die "Failed to run Gnuplot: $!";

print "Content-type: image/png\n\n";
my $output_png = "/www/demo_form/plot.png";  # Change this to your actual file path

# Output HTML to show the image
print "<html><body>";
print "<h3>Regression Line: y = $a + $b*x</h3>";
print "<img src='/cgi-bin/plot_display.pl' alt='Regression Plot'>";
print "</body></html>";