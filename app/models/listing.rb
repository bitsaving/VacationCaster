class Listing < ActiveRecord::Base
	has_and_belongs_to_many :searches, through: "listings_searches"

	def calendar
		@calendar_data ||= JSON.load(self.calendar_data)
	end
	
end
