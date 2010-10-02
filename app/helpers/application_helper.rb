module ApplicationHelper
  
  def without_dblclick_support(&block)
    if request.user_agent.downcase.include?("iphone")  
       capture(&block)
    end
  end
  
end
