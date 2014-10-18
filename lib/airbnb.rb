require 'cgi'
require 'mechanize'
require 'json'
require 'nokogiri'
require 'pry'

class Airbnb
	URL = "https://www.airbnb.com/search/search_results"
	def initialize(options)
		@options = options
		@mechanize = Mechanize.new
		@mechanize.user_agent_alias = 'Mac Safari'
	end

	def listings
		listing_ids = []
		visible_results_count = 18
		page_number = 1
		while listing_ids.length < visible_results_count do
			url = URL + "?page=#{page_number}&" +@options.gsub("[]","%5B%5D")[1..-1]
			puts url
			resp = @mechanize.get(url)
			json = JSON.parse(resp.body)
			visible_results_count = json["visible_results_count"].to_i
			listing_ids.concat json["property_ids"]
			# puts "#"+visible_results_count.to_s
			# puts json["property_ids"]
			listing_ids.uniq!
			page_number += 1
		end
		listing_ids
	end
end