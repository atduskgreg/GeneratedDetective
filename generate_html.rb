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
</style>
<body>
<% paths.each do |path| %>
	<img src="<%= path %>" /><br />
<% end %>
</body>
</html>
TEMPLATE


puts erb.result