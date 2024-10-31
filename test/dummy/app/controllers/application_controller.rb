# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :user
  helper_method :authenticated?

  private

  def user
    cookie = cookies.signed[:user]
    return unless cookie

    @user ||= begin
      User.find(cookie)
    rescue StandardError
      deauthenticate
    end
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
    return if authenticated?

    store
    flash[:warning] = 'You must be logged in.'
    respond_to do |format|
      format.html { redirect_to new_user_path }
    end
    false
  end

  def deauthenticate!
    return unless authenticated?

    store
    flash[:warning] = 'You must be logged out.'
    respond_to do |format|
      format.html { redirect_to edit_user_path }
    end
    false
  end

  def store
    session[:location] = request.fullpath
  end

  def restore(options)
    location = session[:location] || options[:default]
    session[:location] = nil
    location
  end
end
