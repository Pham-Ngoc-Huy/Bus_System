#!/usr/bin/perl

use strict;
use warnings;
use CGI;

# create CGI
my $q = CGI->new;

# Lấy dữ liệu từ form
my $username    = $q->param("UserName");
my $commentText = $q->param("CommentText");

# format the data
my $entry = "Name: $username\nComment: $commentText\n------------------------\n";

# record in data.txt
my $filename = "data.txt";
open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";
print $fh $entry;
close $fh;

# response screen
print $q->header('text/html');
print <<HTML;
<!DOCTYPE html>
<html>
<head>
    <title>Comment Submitted</title>
</head>
<body bgcolor="#E0E0E0">
    <h1>Thank You!</h1>
    <p>Your comment has been recorded.</p>
    <a href="/index.html">Back to home</a>
</body>
</html>
HTML
