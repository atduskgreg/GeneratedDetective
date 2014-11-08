if ARGV.length < 1
	puts "usage: ruby select_short_sentences.rb <paths/to/books>"
	exit 1
end



def find_sentences(opts={})
	regex = Regexp.new "\.([^\.]*#{opts[:word]}[^\.]*\.)"
	lines = opts[:corpus].scan(regex)
	lines.collect{|l| l.first}.reject{|l| l.length > opts[:length]}.collect{|l| l.gsub(/\r|\n/, " ")}
end

# issue 1 keys = [:question, :murderer, :witness, :saw, :scene, :killer, :weapon, :clue, :accuse, :reveal]
# issue 2 keys = [:detective, :woman, :lips, :shot, :chase, :fight, :body, :victim, :blood, :detective]
keys = [:moon, :murder, :discover, :she, :kill, :body]

scifi_sentences = {}
detective_sentences = {}

ARGV.each do |path|

	txt = open(path).read

	keys.each do |k|
		sentence = find_sentences({:corpus => txt, :word => k.to_s, :length => 160})

		if path =~ /scifi/
			puts "scifi"
			scifi_sentences[k] = sentence 		
		elsif path =~ /detective/
			puts "detective"
			detective_sentences[k] = sentence
		end
	end
	
	#lines = txt.split(/\n/)
	#lines.select{|l| l =~ /^"/}.each{|l| puts l}
end

# sentences.each do |k,v|
# 	puts "#{k}[#{v.length}]"
# 	v.each{|l| puts "\t#{l}"}
# end

keys.each do |k|
	if rand > 0.5
		sentences = scifi_sentences
		print "scifi: "
	else
		sentences = detective_sentences
		print "detective: "
	end

	if sentences[k].length > 0
		puts sentences[k].sample
	end
end