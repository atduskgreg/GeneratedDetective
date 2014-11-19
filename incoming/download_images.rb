if ARGV.length < 1
	puts "usage: ruby download_images.rb <list> <of> <search> <terms>"
	exit
end

require 'flickraw'
require 'yaml'
require 'open-uri'

flickr_credentials = YAML.load(open("flickr_credentials.yml").read)

FlickRaw.api_key = flickr_credentials[:api_key]
FlickRaw.shared_secret = flickr_credentials[:shared_secret]

args = {}
args[:license] = "4,5,1,2"# ,7,8 "Attribution-ShareAlike"# License,Attribution License,No known copyright restrictions,United States Government Work,Attribution-NonCommercial-ShareAlike License,Attribution-NonCommercial License"
args[:text] = ARGV.collect{|a| "\"#{a}\""}.join(" ")
args[:sort] = "interestingness-desc"

puts args[:text]

results = flickr.photos.search args

puts "found #{results.length} results"
# urls =  results.collect{|p| url = FlickRaw.url p}
results = results.collect{|p| p}
puts
puts "selecting:"
result = results.sample
puts FlickRaw.url(result)

`open #{FlickRaw.url_photopage(result)}`

File.open("#{args[:text].gsub(/"/, "").gsub(/\s/, "_")}.jpg", "w"){|f| f << open(FlickRaw.url(result)).read}