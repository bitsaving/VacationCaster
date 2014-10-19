module GetCalendarForListing
	@queue = :import
	def self.perform(listing_id)
		airbnb = Airbnb.new
		listing = Listing.find_by_lid(listing_id)
		puts "GetCalendarForListing: lid:#{listing_id} name:#{listing.title}"
		fresh = airbnb.get_calendar_for_listing(listing_id)
		stale = listing.calendar
		listing.update_attribute(:calendar_data, fresh.to_json)
		if stale.nil?
			puts "GetCalendarForListing: lid:#{listing_id} listing just loaded"
			return
		end
		hole = fresh-stale

		if hole.empty?
			puts "GetCalendarForListing: lid:#{listing_id} no holes found"
			return
		else
			hole = hole.sort_by("date")
			searches = listing.searches.in_range(hole)
			if searches.empty?
				puts "GetCalendarForListing: lid:#{listing_id} no searches found for hole"
				return
			end
			searches.each do |search|
				#create alerts and stuff
				puts "#{search.user.email.split("@")[0]} is going on a trip to #{listing.title}"
			end
		end
	end
end
