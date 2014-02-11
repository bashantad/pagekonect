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
    when "events"
       [new_event_path, "Create new event or suggest one"]
    else
       [uploads_path, "Upload photos"]  
    end
  end
  def get_created_at(time_diff)
    time_diff = (time_diff/60).round
    if time_diff/(24*60*30) > 0
      "#{time_diff/(24*60*30)} months ago"
    elsif time_diff/(24*60) > 0
         "#{time_diff/(24*60)} days ago"
    elsif time_diff/24 >0
        "#{time_diff/60} hours ago"
    else
        "#{time_diff} minutes ago"
    end
  end
end

