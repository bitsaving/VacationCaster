class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    @search = Search.new
  end
  
  def inside
  end 

	def bookmarklet
		url = request.env["HTTP_REFERER"]
		# binding.pry
	end

end
