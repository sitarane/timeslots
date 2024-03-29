class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_current_user
  before_action :set_time_zone

  around_action :switch_locale

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def set_time_zone
    Time.zone = Current.user.timezone if Current.user
  end

  # required by Pundit
  def current_user
    Current.user
  end

  def require_user_logged_in!
    redirect_to new_sessions_path, alert: t(:require_user_logged_in) if Current.user.nil?
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
