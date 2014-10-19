module EnqueCalendarGetters
	@queue = :import
	def self.perform(search_id=nil)
		search = search_id.nil? ? Search.all : Search.find(search_id)
		listing_ids = search.listings.pluck(:lid)
		listing_ids.each do |id|
			Resque.enqueue(GetCalendarForListing,id)
		end
	end
end
