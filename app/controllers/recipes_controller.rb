class RecipesController < ApplicationController
  
  #Build all Actions related to Recipes here
  
  # index action
  # sort by total likes implemented
  def index
    # @recipes = Recipe.all.sort_by{|likes| likes.thumbs_down_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 6)
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
  
  # Action for LIKE button
  def like
    @recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successful"
      #After action we want user to stay in the page he/she in
      redirect_to :back
    else
      flash[:danger] = "You can only Like/Dislike once"
      redirect_to :back
    end
  end
  
  #private method for accepting the params
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
end