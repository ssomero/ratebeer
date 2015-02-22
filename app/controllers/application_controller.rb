class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #current_user näkyviin näkymissä
  helper_method :current_user
  helper_method :is_admin

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  #if user is not signed in, redirects to signin path
  def ensure_that_signed_in
    redirect_to signin_path, notice:'You should be signed in' if current_user.nil?
  end

  def ensure_that_has_admin_rights
    redirect_to root_path, notice:'You should be administrator to execute that' if current_user.admin
  end

  def is_admin
    if current_user
      return true if current_user.admin
    end
    return false
  end
end
