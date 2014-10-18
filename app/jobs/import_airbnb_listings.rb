module ImportAirbnbListings
	@queue = :import
	def self.perform(search_id)
		search = Search.find(search_id)
		airbnb = Airbnb.new(search.options)
		listings = airbnb.listings.map do |listing_id|
			details = airbnb.listing_details(listing_id)
			Listing.create details
		end
		binding.pry
		search.listings = listings
	end
end

