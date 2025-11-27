class AddRemarkToCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :categories, :remark, :text
  end
end
