print <<END_long_text;
<h2>Contact</h2>
<p><b>Content</b></p>
<p>Each content page uses the “here doc construct”. It starts with two less-than signs and a word that signifies the end of a block.</p>
<p> It’s a convenient way to quote a multi-line string. The string begins on the next line and continues up to a line containing the end block word.</p>
<p> This "word" must be placed on a separate line, with no spaces either side of the word, in addition it must be terminated with a carriage return.</p>

<table border="0" cellpadding="2" cellspacing="1">
  <tr>
    <td>&nbsp;</td>
    <td><strong>print &lt;&lt;END_long_text;</strong><br>
&nbsp;&nbsp;&nbsp;&lt;h2&gt;Header&lt;/h2&gt;<br>
&nbsp;&nbsp;&lt;p&gt;&lt;b&gt;Another line&lt;/b&gt;&lt;/p&gt;<br>
&nbsp;&nbsp;&lt;p&gt;Any Perl special characters&lt;/p&gt;<br>
&nbsp;&nbsp;&lt;p&gt;must be escaped.&lt;/p&gt;<br>
&nbsp;&nbsp;&lt;p&gt;Another line&lt;/p&gt;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>No&nbsp;space&nbsp;--</td>
    <td><strong>END_long_text</strong></td>
    <td>--&nbsp;No&nbsp;Space&nbsp;add&nbsp;Carrage&nbsp;return</td>
  </tr>
</table>

END_long_text
