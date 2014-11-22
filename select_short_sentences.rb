if ARGV.length < 1
	puts "usage: ruby select_short_sentences.rb <paths/to/books>"
	exit 1
end



def find_sentences(opts={})
	regex = Regexp.new "\.([^\.]*#{opts[:word]}[^\.]*\.)"
	lines = opts[:corpus].scan(regex)
	lines.collect{|l| l.first}.reject{|l| l.length > opts[:length]}.collect{|l| l.gsub(/\r|\n/, " ")}
end

def all_sentences(opts={})
	regex = Regexp.new "\.([^\.]*\.)"
	lines = opts[:corpus].scan(regex)
	lines.collect{|l| l.first}.reject{|l| l.length > opts[:length]}.collect{|l| l.gsub(/\r|\n/, " ")}
end

# issue 1 keys = [:question, :murderer, :witness, :saw, :scene, :killer, :weapon, :clue, :accuse, :reveal]
# issue 2 keys = [:detective, :woman, :lips, :shot, :chase, :fight, :body, :victim, :blood, :detective]
# issue 3 keys = [:moon, :murder, :discover, :she, :kill, :body]
# issue 4 keys = [:chill, :shadow, :body, :blood, :woman, :kill, :detective]
# issue 5 keys = [:hunt, :monster, :night, :woman, :murder, :body, :flee]
# issue 6 keys = [:knife, :knife, :knife, :knife, :knife]
# issue 7 keys = [:woman, :woman, :woman, :woman, :woman]
# issue 8 keys = [1,2,3,4,5]
# issue 9 keys = [:death, :death, :death, :death, :death ]
# issue 10 keys = [:love, :love, :love, :love, :love]
# issue 11 keys = [:horror, :scifi, :romance, :romance, :detective, :horror]

keys = [:romance, :detective, :horror]

scifi_sentences = {}
detective_sentences = {}
romance_sentences = {}
horror_sentences = {}

ARGV.each do |path|

	txt = open(path).read

	# keys.each do |k|
	k = "all"
		sentence = all_sentences({:corpus => txt, :word => k.to_s, :length => 160})

		if path =~ /scifi/
			puts "scifi"
			scifi_sentences[k] = sentence 		
		elsif path =~ /detective/
			puts "detective"
			detective_sentences[k] = sentence
		elsif path =~ /horror/
			puts "horror"
			horror_sentences[k] = sentence
		elsif path =~ /romance/
			puts "romance"
			romance_sentences[k] = sentence
		end
	# end
	
	#lines = txt.split(/\n/)
	#lines.select{|l| l =~ /^"/}.each{|l| puts l}
end

# sentences.each do |k,v|
# 	puts "#{k}[#{v.length}]"
# 	v.each{|l| puts "\t#{l}"}
# end

keys.each do |k|
	if k == :scifi
		sentences = scifi_sentences
	elsif k == :romance
		sentences = romance_sentences
	elsif k == :detective
		sentences = detective_sentences
	elsif k == :horror
		sentences = horror_sentences
	end

	# r = rand

	# if r < 0.25
	# 	sentences = scifi_sentences
	# 	print "scifi: "
	# elsif r > 0.25 && r < 0.5
	# 	sentences = detective_sentences
	# 	print "detective: "
	# elsif r > 0.5 && r < 0.75
	# 	sentences = horror_sentences
	# 	print "horror: "
	# else 
	# 	sentences = detective_sentences
	# 	print "romance: "
	# end

	if sentences["all"].length > 0
		puts k.to_s + ": " + sentences["all"].sample
	end
end