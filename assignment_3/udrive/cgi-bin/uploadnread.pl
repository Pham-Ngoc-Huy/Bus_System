#!/usr/bin/perl
use strict;
use warnings;

print "Content-Type: text/html\n\n";

my $content_length = $ENV{'CONTENT_LENGTH'};
my $query_string = '';
my $output_file = "/www/demo_form/data.txt";


read(STDIN, $query_string, $content_length);

my ($boundary) = $query_string =~ /boundary=(.+)/;
$boundary = "--$boundary";

my @parts = split(/$boundary/, $query_string);

my $filename = '';
my $content = '';

foreach my $part (@parts) {
    if ($part =~ /filename="([^"]+)"/) {
        $filename = $1;
    }

    if ($part =~ /Content-Type:\s*text\/plain\s*\r?\n\r?\n(.*)/s) {
        $content = $1;
    }
}

if ($filename && $filename =~ /\.txt$/) {
    open(my $fh, '>>', $output_file);
    print $fh "$content", ($content =~ /\n$/ ? "" : "\n");
    close($fh);

    open(my $rfh, '<', $output_file);
    my @lines = <$rfh>;
    close($rfh);

    print "<h2>Uploaded & Appended to data.txt</h2>";
    print "<pre>", join('', @lines), "</pre>";
} else {
    print "<p style='color:red;'>Error: Please upload a valid .txt file.</p>";
}

exit;
