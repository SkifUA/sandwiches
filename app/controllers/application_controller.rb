class ApplicationController < ActionController::Base

  before_action :set_locale
  protect_from_forgery with: :exception
  include DeviseWhiteList
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end



  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
