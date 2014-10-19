module EnqueCalendarGetters
	@queue = :import
	def self.perform(search_id=nil)
		listing_ids = if search_id.nil? or search_id.empty?
			Listing.pluck(:lid)
		else
			Search.find(search_id).listings.pluck(:lid)
		end
		listing_ids.each do |id|
			Resque.enqueue(GetCalendarForListing,id)
		end
	end
end
