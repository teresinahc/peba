class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :allow_all_access_origin

  def allow_all_access_origin
    headers['Access-Control-Allow-Origin'] = '*'
  end
end
