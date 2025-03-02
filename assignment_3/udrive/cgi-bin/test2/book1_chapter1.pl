print <<END_long_text;
<h2>Book 1 Chapter 1 Introduction</h2>
<p><b>Shebang:</b></p>
<p>I found this to be a real pain you need to change the “shebang” depending on how you run the mini server either portable or as a service.  If you're running CGI's on Windows use the portable server this will allow you to move the scripts to a Unix system without change.</p>

<p>The following lists the “shebang” required to get your scripts working:</p>

<p><b>Unix:</b></p>

<p>#!/usr/bin/perl</p>

<p><b>Mini Portable Server :</b></p>

<p>#!/usr/bin/perl</p>

<p><b>Mini Server run as service:</b></p>

<p>#!c:/mini_server_3b/usr/bin/perl</p>
<p>Note: If you use the Unix "shebang" you will receive this error message in Apache log:</p>
<p>(OS 3)The system cannot find the path specified.</p>
END_long_text
