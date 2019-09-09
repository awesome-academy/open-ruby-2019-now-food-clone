class ApplicationController < ActionController::Base
  include CommentsHelper

  before_action :set_locale
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i(name address email phone)
    devise_parameter_sanitizer.permit :account_update, keys: %i(name address email phone)
  end
end
