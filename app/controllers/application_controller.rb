class ApplicationController < ActionController::Base
  before_action :set_current_user
  around_action :switch_locale
  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def require_user_logged_in!
    redirect_to new_sessions_path, alert: 'You must be signed in' if Current.user.nil?
  end
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
  def default_url_options
    { locale: I18n.locale }
  end
end
