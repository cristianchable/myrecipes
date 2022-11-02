class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first #refactor to this.
    respond_to do |format|
      if @recipe.save
         format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was created successfully!' }
         format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  private

    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
end
