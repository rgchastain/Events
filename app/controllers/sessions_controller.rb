class SessionsController < ApplicationController
	before_action :require_login, only: [:destroy]
  def new
  end

  def create
  	flash[:errors] ||= []

  	@user = User.find_by_email(params[:email])

  	@user.try(:authenticate, params[:password])
  	
  	if @user
  		if @user.try(:authenticate, params[:password])
  			
  			session[:user_id] = @user.id

  			return redirect_to events_path
  		end
  		
  		flash[:errors] << 'Password is incorrect.'
  	else
  		flash[:errors] << 'Account not found, please register.'
  	end

  	return redirect_to '/login'
  end

  def destroy
  	session.clear

  	flash[:notice] = ["Successfully Logged Out"]

  	return redirect_to '/login'
  end
end
