module ApplicationHelper
  def logged_in?
    Current.user.blank?
  end
end
