#!/usr/bin/perl
use strict;
use warnings;

sub append {
    my ($file, $text) = @_;

    # Open file in append mode
    open(my $fh, ">>", $file) or die "Cannot open file: $!\n";
    print $fh "$text\n";
    close($fh);

    print "Text appended to $file\n";
}

my $file_path = "C:/Users/Huy.PhamN1/Desktop/BusSystem/assignment_3/udrive/www/demo_form/data.txt";
my $new_text = "This is the new text to append.";
append($file_path, $new_text);
