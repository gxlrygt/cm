class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   before_filter :find_turn_time_stats
  after_filter :set_csrf_cookie_for_ng

  helper_method :current_admin_user

protected
  def find_turn_time_stats
    @current_turn_time_stats = TurnTimeStat.first || TurnTimeStat.new
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def access_denied(exception)
    if !current_user
      session[:return_path] = request.path
      flash[:alert] = "Please login or signup to view this page"
      redirect_to new_user_session_path
    else
      flash[:alert] = "You do not have permission to access this page."
      redirect_to root_path
    end
  end

  def current_admin_user
    if current_user && current_user.is_a?(AdminUser)
      current_user
    else
      nil
    end
  end

  # Just sets an @user instance variable for convenience in controllers & views.
  def find_user
    @user = current_user
  end
end
