module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Vacation Caster"      
    end
  end
end
