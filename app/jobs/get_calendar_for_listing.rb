module GetCalendarForListing
	@queue = :import
	def self.perform(listing_id)
		listing = Listing.find(listing_id)
		fresh = Airbnb.get_calendar_for_listing(listing_id)
		stale = listing.calendar
		hole = fresh-stale
		listing.update_attribute(:calendar_data, fresh)
		if stale.empty?
			puts "GetCalendarForListing: listing just loaded"
			return
		end
		if hole.empty?
			puts "GetCalendarForListing: no holes found"
			return
		else
			hole = hole.sort_by("date")
			searches = listing.searches.in_range(hole)
			if searches.empty?
				puts "GetCalendarForListing: no searches found for hole"
				return
			end
			searches.each do |search|
				#create alerts and stuff
				puts "#{search.user.email.split("@")[0]} is going on a trip to #{listing.title}"
			end
		end
	end
end