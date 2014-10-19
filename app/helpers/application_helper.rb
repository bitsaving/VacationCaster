module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Vacation Caster"      
    end
  end

  def bookmarklet_url
  	if ENV['RAILS_ENV']=="production"
  		"dry-cove-4518.herokuapp.com"
  	else
  		"localhost:3000"
  	end
  end
end
