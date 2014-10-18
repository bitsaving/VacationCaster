module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Vacaycaster"      
    end
  end
end
