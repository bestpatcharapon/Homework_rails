# Create test data
category = Category.create!(name: "Test Category")
ingredient = Ingredient.create!(name: "Test Ingredient")
recipe = Recipe.create!(name: "Test Recipe", description: "Test Description", price: 99.99)

# Associate
recipe.categories << category
recipe.ingredients << ingredient

# Verify
puts "Recipe Categories: #{recipe.categories.map(&:name)}"
puts "Recipe Ingredients: #{recipe.ingredients.map(&:name)}"

# Check reverse associations
puts "Category Recipes: #{category.recipes.map(&:name)}"
puts "Ingredient Recipes: #{ingredient.recipes.map(&:name)}"

# Clean up
recipe.destroy
category.destroy
ingredient.destroy
puts "Verification complete."
