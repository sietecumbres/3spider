module Helpers
  
  def current_user
    @current_user ||= User.find_by_email(session[:email])
    @current_user.password = session[:password] if @current_user
    @current_user
  end
  
  def login!(user)
    @current_user = user
    session[:email] = user.email
    session[:password] = user.password
  end
  
  def logged_in?
    @current_user ? true : false
  end
  
  def login_required
    redirect '/login' and return unless current_user
  end

end