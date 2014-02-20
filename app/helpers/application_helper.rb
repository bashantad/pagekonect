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
  
  def comment_delete_url(row, comment)
    if row.instance_of? Upload
      url = upload_comment_path(row, comment)
    elsif row.is_news?
      url = news_comment_path(row, comment)
    elsif row.is_deal?
      url = deal_comment_path(row, comment)
    elsif row.is_video?
      url = video_comment_path(row, comment)
    elsif row.is_event?
      url = event_comment_path(row, comment)
    end
    url
  end
end

