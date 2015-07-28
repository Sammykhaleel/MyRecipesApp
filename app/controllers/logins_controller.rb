class LoginsController < ApplicationController

  def new

  end

  def create
    chef = Chef.find_by(email: params[:email])
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id
      flash[:success] = "You are loged in"
      redirect_to recipes_path
    else
      flash[:danger] = "Your email or password is incorrect"
    end
  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "You logged out"
    redirect_to root_path
  end

end