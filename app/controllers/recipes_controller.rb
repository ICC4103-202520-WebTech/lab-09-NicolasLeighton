class RecipesController < ApplicationController
  # Require login except for viewing recipe

  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  before_action :set_recipe, only: %i[ show edit update destroy ]
  

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @recipe.user == current_user
      if @recipe.update(recipe_params)
        redirect_to @recipe, notice: "Recipe updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to recipes_path, alert: "You can only edit your own recipes."
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "Recipe was successfully destroyed.", status: :see_other
  end


  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :cook_time, :difficulty, :instructions)
  end
end
