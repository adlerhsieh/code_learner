class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Exception, with: :error_message
  helper_method :current_user

  def error_message(e)
    render json: {
      result: "#{e.class}: #{e.message}"
    }
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end
end
