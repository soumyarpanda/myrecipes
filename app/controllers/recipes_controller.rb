class RecipesController < ApplicationController
  
  #Build all Actions related to Recipes here
  
  # index action
  def index
    @recipes = Recipe.all
  end
  
  # show action
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  # new action
  def new
    @recipe = Recipe.new
  end
  
  # create action
  def create
    #binding.pry --- to check for params in console
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(2)
    
    if @recipe.save
      #do something
      flash[:success] = "Your recipe was created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  # EDIT action
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  # EDIT action
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      #do something
      flash[:success] = "Your recipe was updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  #private method for accepting the params
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description)
    end
end