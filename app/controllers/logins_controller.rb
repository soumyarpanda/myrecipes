class LoginsController < ApplicationController
  
  # We dont have a model-backed form here, we are dealing with a session
  # We are not gonna create anything here, so we are not backing anything
  
  def new 
    
  end
  
  def create
    chef = Chef.find_by(email: params[:email])
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id
      flash[:success] = "You are logged in"
      redirect_to recipes_path
    else
      flash.now[:danger] = "Your email address or password doesnt match"
      render 'new'
    end
  end
  
  def destroy
    session[:chef_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end