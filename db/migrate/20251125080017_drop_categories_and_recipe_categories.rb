class DropCategoriesAndRecipeCategories < ActiveRecord::Migration[8.1]
  def change
    drop_table :recipe_categories
    drop_table :categories
  end
end
