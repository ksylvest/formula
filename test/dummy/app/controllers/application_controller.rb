class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :user
  helper_method :authenticated?

private

  def user
    cookie = cookies.signed[:user]
    @_user ||= User.find(cookie) rescue deauthenticate if cookie
  end

  def authenticate(user)
    cookies.permanent.signed[:user] = user.id
  end

  def deauthenticate
    cookies.delete :user
  end

  def authenticated?
    user.present?
  end

  def authenticate!
    unless authenticated?
      store
      flash[:warning] = 'You must be logged in.'
      respond_to do |format|
        format.html { redirect_to new_user_path }
      end
      return false
    end
  end

  def deauthenticate!
    if authenticated?
      store
      flash[:warning] = 'You must be logged out.'
      respond_to do |format|
        format.html { redirect_to edit_user_path }
      end
      return false
    end
  end

  def store
    session[:location] = request.fullpath
  end

  def restore(options)
    location = session[:location] || options[:default]
    session[:location] = nil
    return location
  end

end
