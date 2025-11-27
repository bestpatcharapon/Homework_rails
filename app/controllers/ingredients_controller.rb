class IngredientsController < ApplicationController
  load_and_authorize_resource
  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to ingredients_path, notice: 'Ingredient was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      @ingredient.image.purge if ingredient_params[:remove_image] == '1'
      redirect_to ingredients_path, notice: 'Ingredient was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to ingredients_path, notice: 'Ingredient was successfully destroyed.'
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :image, :remove_image)
  end
end
