class AddRemarkToIngredients < ActiveRecord::Migration[8.1]
  def change
    add_column :ingredients, :remark, :text
  end
end
