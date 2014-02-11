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
    no_months = time_diff/(24*60*30)
    no_days = time_diff/(24*60)
    no_hours = time_diff/24
    if no_months > 0
      "#{pluralize(no_months, 'month')} ago"
    elsif no_days > 0
      "#{pluralize(no_days, 'day')} ago"
    elsif no_hours > 0
      "#{pluralize(no_hours, 'hour')} ago"
    else
      "#{pluralize(time_diff, 'minute')} ago"
    end
  end
end

