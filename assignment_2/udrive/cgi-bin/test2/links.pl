print <<END_long_text;
<h2>Links</h2>
<p><b>Query string</b></p>
<p>The query string is decoded, after validation is used to construct a file name. This file name selects the appropriate file to display in the page content area.</p>

<p><b>Perl Modules:</b></p>
<p>I was hoping to use modules to call in the page content however found the “require” command would not accept a variable. Instead had to use the “do” command.</p>
<p>“do” Calls in pages with the extension “.pl” and executes it as a Perl script.</p>
<p>I use Perl modules for header, navigation and footer these use just a name.</p>
<p><b><i>Examples:</i></b></p>
<p>require header; # Page top</p>
<p>\$selected = \$selected . ".pl";<br> 
do \$selected; # pulls in content page</p>

<p>require nav;    # Nav must be above footer<br>
require footer; # Page bottom</p>
<p>Note: Remember that content pages are Perl code hence if you want to display a dollar sign must be escaped. E.g. \$ requires \\\$</p>
<p></p>



END_long_text
