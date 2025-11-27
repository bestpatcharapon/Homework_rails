# Create a category
category = Category.create!(name: "อาหารจานเดียว")

# Assign to a recipe
recipe = Recipe.first
recipe.category = category
recipe.save!

# Verify
puts "Recipe Category: #{recipe.category.name}"
puts "Category Recipes: #{category.recipes.map(&:name)}"

# Clean up (optional, or keep for user to see)
# category.destroy
