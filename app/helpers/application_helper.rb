module ApplicationHelper

  def class_name(object)
    object.try(:is_content?) ? "Content" : object.class.name 
  end
  
  def get_create_link_with_msg(controller)
    case controller
    when "news"
       [new_news_path, "Create new newsfeed"]
    when "deals"
       [new_deal_path, "Create new deal"]
    when "videos"
       [new_video_path, "Create new video"]
    else
       [new_event_path, "Create new event or suggest one"]
    end
  end
end

