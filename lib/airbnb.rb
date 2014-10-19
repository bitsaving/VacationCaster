require 'cgi'
require 'mechanize'
require 'json'
require 'nokogiri'

class Airbnb
	SEARCH_URL  = "https://www.airbnb.com/search/search_results"
	LISTING_URL = "https://m.airbnb.com/api/-/v1/listings/"
	DETAILS_URL = "https://www.airbnb.com/rooms/"
	def initialize(options=nil)
		@options = options
		@mechanize = Mechanize.new
		@mechanize.user_agent_alias = 'Mac Safari'
	end

	def listings
		listing_ids = []
		visible_results_count = 18
		page_number = 1
		while listing_ids.length < visible_results_count do
			url = SEARCH_URL + "?page=#{page_number}&" +@options.gsub("[]","%5B%5D")[1..-1]
			resp = @mechanize.get(url)
			json = JSON.parse(resp.body)
			visible_results_count = json["visible_results_count"].to_i
			listing_ids.concat json["property_ids"]
			listing_ids.uniq!
			page_number += 1
		end
		listing_ids
	end

	def listing_details(id)
		url = LISTING_URL+id.to_s
		resp = @mechanize.get(url)
		json = JSON.load(resp.body)
		{
			title: json["listing"]["name"],
			price: json["listing"]["price"],
			lat: json["listing"]["lat"],
			lng: json["listing"]["lng"],
			calendar_data: "",
			lid: json["listing"]["id"]
		}
	end

	def get_calendar_for_listing(id)
		today = Time.now.strftime("%F")
		end_date = (Time.now+(3600*24*7*2)).strftime("%F")
		url  = "https://www.airbnb.com/api/v1/listings/#{id}/calendar"
		url += "?start_date=#{today}&end_date=#{end_date}&key="
		url += "#{api_key(id)}&currency=USD&locale=en"
		resp = @mechanize.get(url)
		json = JSON.load resp.body
		json["calendar"]["dates"]#.map{ |d| d.except "reservation" }
	end

	def api_key(id)
		if @api_key.nil?
			resp = @mechanize.get(DETAILS_URL+id.to_s)
			doc = Nokogiri.parse(resp.body)
			meta = doc.css("#_bootstrap-layout-init").attr("content").value
			json = JSON.load meta
			@api_key = json["api_config"]["key"]
		end
		@api_key
	end

end
