print <<END_long_text;
<h2>About</h2>
<p><b>Separation:</b></p>
<p>All Perl scripts are contained in the cgi-bin folder; other elements such as images and CSS do not required passing by the Perl engine and these are located in the server document root folder MPG2.</p>
<p><b>Links:</b></p>
<p>To view this web site either, type the following into a web browser</p>
<p>&nbsp;&nbsp;http://localhost/cgi-bin/mpg2/index.pl</p>
<p>You probably started viewing the site by using a link on the index page this looks like:</p>

<p>&nbsp;&nbsp;&lt;a&nbsp;href=&quot;http://localhost/cgi-bin/mpg2/index.pl&quot;&gt;&nbsp;Some&nbsp;Link&lt;/a&gt;<br>
</p>
<p><b>Relative Links</b></p>
<p>Document root relative links (/ means start from folder www) are used for accessing the CSS file you will find this on index.pl page:</p>
<p>&nbsp;&nbsp;&lt;link&nbsp;href=&quot;/mpg2/main.css&quot;&nbsp;rel=&quot;stylesheet&quot;&nbsp;type=&quot;text/css&quot;&gt;<br>
</p>

<p>Navigation Links</p>

<p>Site navigation is performed by a group of links contained in file nav.pl these have the following format:</p>
<p>&nbsp;&nbsp;&lt;a&nbsp;href=&quot;index.pl?page=about&quot;&gt;About&nbsp;-&nbsp;Separation&lt;/a&gt;<br>
</p>

<p>These are relative links, not a problem because they are relative to the page displayed (index.pl). Each link uses a query string to select the page content.</p>

END_long_text


