module ApplicationHelper
  def logged_in?
    Current.user.blank?
  end
  def page_title
    return @page_title if @page_title.present?
    return t(:app_name) if current_page?(root_path)
    return controller_name.capitalize
  end
  def page_subtitle
    t(:slogan) if current_page?(root_path)
  end
end
