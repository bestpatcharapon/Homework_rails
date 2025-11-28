class CategoriesController < ApplicationController
  load_and_authorize_resource
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    
    if @category.recipes.any?
      redirect_to categories_path, alert: "ไม่สามารถลบหมวดหมู่นี้ได้ เพราะยังมีสูตรอาหารที่ใช้อยู่"
    else
      @category.destroy
      redirect_to categories_path, notice: "ลบหมวดหมู่สำเร็จ"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :remark)
  end
end
