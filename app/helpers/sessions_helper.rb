module SessionsHelper
  def log_in(user)
    puts "setting session :- "
    session[:user_id] = user.id
    puts "session[:users_id] is :- #{session[:user_id]}"
  end

  def current_user
    @current_user ||= User.find_by(:id => session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

end
