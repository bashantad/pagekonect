module ApplicationHelper

  def class_name(object)
    object.try(:is_content?) ? "Content" : object.class.name 
  end
end