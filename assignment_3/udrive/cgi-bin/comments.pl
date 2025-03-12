#!/usr/bin/perl

use strict;
use warnings;
use CGI;

my $q = CGI->new;
print $q->header(-type => "text/html", -charset => "UTF-8");

my $x = $q->param("x");
my $y = $q->param("y");

my $filename = "/www/demo_form/data.txt";

if (defined $x && defined $y) {
    open(my $fh, '>>', $filename) or die "Không thể mở file '$filename': $!";
    print $fh "$x,$y\n";
    close($fh);
}

print "<table border='1' style='width: 50%; margin: auto; text-align: center;'>";
print "<tr><th>Value X</th><th>Value Y</th></tr>";

open(my $fh, '<', $filename) or die "Không thể mở file '$filename': $!";
while (my $line = <$fh>) {
    chomp $line;
    my ($x_val, $y_val) = split(/,/, $line);
    print "<tr><td>$x_val</td><td>$y_val</td></tr>";
}
close($fh);

print "</table>";
close;
print $q->redirect("/demo_form/form.html");
