class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  rescue_from Errors::AccessDenied, :with => :access_denied

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def access_denied
    render 'errors/access_denied'
  end

  def require_admin!
    raise Errors::AccessDenied unless current_user.admin?
  end
end
