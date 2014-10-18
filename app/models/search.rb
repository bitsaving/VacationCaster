class Search < ActiveRecord::Base
	belongs_to :user

	def listings
		Airbnb.new(self.options).listings
	end
end
