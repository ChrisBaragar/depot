class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def index
    @users = User.order(:email)
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to root_url, notice: "Signed up!"
  	else
  		render "new"
  	end
  end

  def destroy
    begin
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "User #{@user.email} has been deleted."
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html {redirect_to store_url}
      format.js   {}
      format.json {head :no_content}
    end
  end
  
end
