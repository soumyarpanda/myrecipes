class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update]
  
  
  #Build all Actions related to Recipes here
  
  # index action
  # sort by total likes implemented
  def index
    # @recipes = Recipe.all.sort_by{|likes| likes.thumbs_down_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 6)
  end
  
  # new action
  def new
    @recipe = Recipe.new
  end
  
  # create action
  def create
    #binding.pry --- to check for params in console
    @recipe = Recipe.new(recipe_params)
    
    #to get to create we need to have a current user we have taken care of that above in before action 
    # so we know that the code wont break
    @recipe.chef = current_user
    if @recipe.save
      #do something
      flash[:success] = "Your recipe was created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  # WE HAVE SET THE RECIPE ALREADY IN A PRIVATE METHOD BELOW FOR UPDATE EDIT AND SHOW FUNCTIONS
  # show action
  def show
    
  end
  
  # EDIT action
  def edit
    
  end
  
  # UPDATE action
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  # Action for LIKE button
  def like
    @recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successful"
      #After action we want user to stay in the page he/she in
      redirect_to :back
    else
      flash[:danger] = "You can only Like/Dislike once"
      redirect_to :back
    end
  end
  
  # PRIVATE METHODS for internal works
  private
    # for accepting the params
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    def require_same_user
      if current_user != @recipe.chef
        flash[:danger] = "You can only edit your own recipe"
        redirect_to recipes_path
      end
    end
end