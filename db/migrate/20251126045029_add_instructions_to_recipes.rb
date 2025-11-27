class AddInstructionsToRecipes < ActiveRecord::Migration[8.1]
  def change
    add_column :recipes, :instructions, :text
  end
end
