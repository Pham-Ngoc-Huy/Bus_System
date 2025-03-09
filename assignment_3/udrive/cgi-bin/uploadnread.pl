#!/usr/bin/perl
use strict;
use warnings;
use CGI;

# Define upload directory
my $upload_dir = "/www/demo_form";
my $data_file = "$upload_dir/data.txt";

# Create CGI object
my $cgi = CGI->new;

# Print HTTP header
print $cgi->header(-type => "text/html", -charset => "UTF-8");
print "<html><head><title>File Upload</title></head><body>";
print "<h1>Upload Status</h1>";

# Get uploaded file handle
my $filehandle = $cgi->upload('file');
my $orig_filename = $cgi->param('file');  # Get original filename

if ($filehandle && $orig_filename) {
    # Open data.txt in append mode
    open(my $fh, '>>', $data_file) or die "Cannot open '$data_file': $!";
    
    # Append uploaded file content to data.txt
    while (<$filehandle>) {
        print $fh $_;
    }
    close($fh);

    print "<p>File uploaded successfully and content appended to <b>data.txt</b></p>";
} else {
    print "<p style='color: red;'>No file uploaded. Please try again.</p>";
}

# Display the current content of data.txt
print "<h2>Updated File Content:</h2><pre>";
open(my $fh, '<', $data_file) or die "Cannot open file for reading: $!";
while (<$fh>) {
    print $_;
}
close($fh);
print "</pre>";

print "</body></html>";
