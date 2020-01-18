module Sessions
  extend ActiveSupport::Concern

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please Log in!'
      redirect_to login_url
    end
  end
end