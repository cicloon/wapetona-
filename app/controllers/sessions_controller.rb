class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def new
    redirect_to "/auth/#{params["auth"]}" if session_manager.provider_for(params["auth"])
  end

  def create
    user = session_manager.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    reset_session
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Signed in!'
    else
      redirect_to root_url, :notice => 'mooock!'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

  private

  def session_manager
    BaseStrategy.new(User)
  end
end
