class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
  	user = User.authenticate(params[:email], params[:password])
  	if user
  		session[:user_id] = user.id
  		redirect_to admin_url, :notice => "Logged in! Welcome, " + user.email + "!"
  	else
  		flash.now.alert = "Invalid email or password"
  		redirect_to store_url
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to store_url, :notice => "Logged out successfully."
  end
end
