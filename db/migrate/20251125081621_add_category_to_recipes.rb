class AddCategoryToRecipes < ActiveRecord::Migration[8.1]
  def change
    add_reference :recipes, :category, null: true, foreign_key: true
  end
end
