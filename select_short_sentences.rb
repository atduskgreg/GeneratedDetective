if ARGV.length < 1
	puts "usage: ruby select_short_sentences.rb <paths/to/books>"
	exit 1
end



def find_sentences(opts={})
	regex = Regexp.new "\.([^\.]*#{opts[:word]}[^\.]*\.)"
	lines = opts[:corpus].scan(regex)
	lines.collect{|l| l.first}.reject{|l| l.length > opts[:length]}.collect{|l| l.gsub(/\r|\n/, " ")}
end

keys = [:question, :murderer, :witness, :saw, :scene, :killer, :weapon, :clue, :accuse, :reveal]
sentences = {}

ARGV.each do |path|



	txt = open(path).read
	keys.each do |k|
		sentences[k] = find_sentences({:corpus => txt, :word => k.to_s, :length => 160})
	end
	
	#lines = txt.split(/\n/)
	#lines.select{|l| l =~ /^"/}.each{|l| puts l}
end

# sentences.each do |k,v|
# 	puts "#{k}[#{v.length}]"
# 	v.each{|l| puts "\t#{l}"}
# end

keys.each do |k|
	if sentences[k].length > 0
		puts sentences[k].sample
	end
end