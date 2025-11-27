class Api::V1::RecipesController < Api::ApplicationController
  before_action :set_recipe, only: %i[ show update destroy ]

  def index
    @recipes = Recipe.all
    render json: @recipes
  end

  def show
    if @recipe
      render json: @recipe, include: [ :ingredients, :category ], status: :ok
    else
      render json: { error: "Recipe not found" }, status: :not_found
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    head :no_content
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Recipe not found" }, status: :not_found
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :price, :category_id, :image, ingredient_ids: [])
  end
end
