class ChefsController < ApplicationController
  
  # Before any of these actions we shall set the user
  before_action :set_chef, only: [:edit, :update, :show]
  
  # this method shall be executed before action at any level below
  # so require same user shall only be executed before EDIT and UPDATE actions
  before_action :require_same_user, only: [:edit, :update]
  
  #Actions we need for a Chef
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end
  
  # NEW ACTION - Register
  def new 
    @chef = Chef.new
  end

  def create 
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your account has been created successfully"
      session[:chef_id] = @chef.id
      redirect_to recipes_path
    else
      render 'new'
    end
  end
  
  # WE HAVE SET THE CHEF ALREADY IN A PRIVATE METHOD BELOW FOR UPDATE EDIT AND SHOW FUNCTIONS
  def edit
  end
  
  def update 
    if @chef.update(chef_params)
      flash[:success] = "Your profile has been updated successfully"
      redirect_to chef_path(@chef) 
    else
      render 'edit'
    end
  end
  
  def show
    #Add a recipes instance variable for the will_paginate to work
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
  end
  
  #private method
  private 
    
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
  
    # Require same user for checking if same user is performing any action
    def require_same_user
      if current_user != @chef
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
      end
    end
    
    # Set a Chef for actions mentioned above
    def set_chef
      @chef = Chef.find(params[:id])
    end
    
end