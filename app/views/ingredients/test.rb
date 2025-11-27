ing= []

category.recipes.each do |recipe|
  recipe.ingredients.each do |ingredient|
    ing << ingredient
  end
end

puts ing
category.recipes.flat_map(&:ingredients).pluck(:name).uniq