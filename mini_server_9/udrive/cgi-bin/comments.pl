#!/usr/bin/perl -w
use CGI;
#use strict;
#use CGI::Carp qw(fatalsToBrowser);
 
my $Data;
my $q = new CGI;
#my %Form;
print $q->header;
print $q->start_html(-title => "An example web page");
my $name = $q->param('UserName');
my $text = $q->param('CommentText');
print $q->h1("CGI-Feedback from <i>comments.pl</i>");
print $q->ul(
$q->li(["<b>Name:</b> $name</p>",
           "<b>Comment:</b> $text"])
);
print $q->end_html;