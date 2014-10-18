class Search < ActiveRecord::Base
	belongs_to :user
	after_create :import_listings
	has_and_belongs_to_many :listings, through: "listings_searches"

	def self.in_range(range)
	  where(
	  	'(start_date BETWEEN ? AND ? OR end_date BETWEEN ? AND ?) OR (start_date <= ? AND end_date >= ?)',
	    range.first, range.last, range.first, range.last, range.first, range.last
    )
  end

	def import_listings
		Resque.enqueue(ImportAirbnbListings,self.id)
	end


end
