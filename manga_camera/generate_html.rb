if ARGV.length < 1
	puts "usage: ruby generate_html.rb <paths/to/images>"
	exit 1
end

require 'erb'

paths = ARGV


erb = ERB.new <<-TEMPLATE
<html>
<head><title>Generated Detective #1</title></head>
<style>
img {
	margin-bottom: 20px
}
.prev {
	float: left;
}
.next {
	float: right
}
</style>
<body>
<div style="width:500px; margin:0 auto">
	<p><b>Generated Detective #1</b> by Greg Borenstein</br></p>

<% paths.each do |path| %>
	<img src="<%= path %>" /><br />
<% end %>
<p><span class="prev"><a href="../1">prev</a></span> <!-- <span class="next"><a href="../3">next</a></span> --></p>
	<br style="clear:both" />

<p><em>Generated from a series of fragments of public domain detective books for <a href="https://github.com/dariusk/NaNoGenMo-2014">NaNoGenMo</a></em></p>
</body>
</html>
TEMPLATE


puts erb.result