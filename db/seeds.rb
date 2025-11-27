# frozen_string_literal: true

if Category.count.zero?
  categories = [
    { name: 'Desserts', remark: 'Indulge in sweet treats with our dessert collection.' },
    { name: 'Main Courses', remark: 'Discover delicious and hearty meals for any occasion.' },
    { name: 'Vegetarian', remark: 'Wholesome vegetarian recipes full of flavor.' },
    { name: 'Salads', remark: 'Healthy and refreshing salads for a healthy lifestyle.' }
  ]

  categories.each do |ccategory|
    Category.create(ccategory)
  end
end

if Ingredient.count.zero?
  ingredients = [
    { name: 'sugar', remark: 'Use granulated sugar for sweetness.' },
    { name: 'milk', remark: 'Any milk type can be used (whole, skim, or plant-based).' },
    { name: 'eggs', remark: 'Large eggs are preferred for baking.' },
    { name: 'cocoa powder', remark: 'Use unsweetened cocoa powder for best results.' },
    { name: 'vegetable oil', remark: 'Can substitute with olive oil or melted butter.' },
    { name: 'baking soda', remark: 'Ensure it is fresh for best leavening results.' },
    { name: 'baking powder', remark: 'Used in combination with baking soda for fluffiness.' },
    { name: 'ground beef', remark: 'Use lean ground beef for a less fatty dish.' },
    { name: 'onion', remark: 'Yellow onion works best for this recipe.' },
    { name: 'garlic', remark: 'Fresh garlic adds more flavor than garlic powder.' },
    { name: 'tomatoes', remark: 'Use canned crushed tomatoes for better texture.' },
    { name: 'olive oil', remark: 'Use for cooking the beef and vegetables.' },
    { name: 'oregano', remark: 'Adds a savory, herbaceous flavor.' },
    { name: 'spaghetti', remark: 'Use any long pasta of your choice.' },
    { name: 'cauliflower', remark: 'Cut into florets for even roasting.' },
    { name: 'olive oil', remark: 'Helps the cauliflower crisp up when roasting.' },
    { name: 'chili powder', remark: 'Adds a nice smokiness and heat.' },
    { name: 'corn tortillas', remark: 'For authentic taco taste.' },
    { name: 'lime', remark: 'Squeeze over the tacos for freshness.' },
    { name: 'fresh cilantro', remark: 'Garnish for a fresh burst of flavor.' },
    { name: 'sour cream', remark: 'Optional, for creaminess.' }
  ]


  ingredients.each do |ingredient|
    Ingredient.create(ingredient)
  end
end

if Recipe.count.zero?
  # Chocolate Cake
  chocolate_cake = Recipe.create!(
    name: 'Chocolate Cake',
    description: 'A rich and moist chocolate cake that melts in your mouth.',
    instructions: "Master the chocolate cake with an airy, light sponge and rich buttercream filling. It's simple enough for an afternoon tea but special enough for a party too.",
    price: 250,
    category: Category.find_by(name: 'Desserts')
  )
  chocolate_cake.ingredients << Ingredient.where(name: [ 'sugar', 'milk', 'eggs', 'cocoa powder', 'baking soda', 'baking powder' ])

  # Cauliflower Tacos
  cauliflower_tacos = Recipe.create!(
    name: 'Cauliflower Tacos',
    description: 'A healthy vegetarian taco with roasted cauliflower.',
    instructions: "These vegetarian cauliflower tacos are packed with Mexican flavor and topped with a creamy avocado crema. They're delicious, easy to make and perfect for taco night.",
    price: 180,
    category: Category.find_by(name: 'Vegetarian')
  )
  cauliflower_tacos.ingredients << Ingredient.where(name: [ 'cauliflower', 'olive oil', 'chili powder', 'corn tortillas', 'lime', 'fresh cilantro', 'sour cream' ])

  # Spaghetti Bolognese
  spaghetti = Recipe.create!(
    name: 'Spaghetti Bolognese',
    description: 'A classic Italian pasta dish with a rich meat sauce.',
    instructions: "Our best ever spaghetti bolognese is super easy and a true Italian classic with a meaty, chilli sauce. This pasta bolognese recipe is sure to become a family favourite.",
    price: 220,
    category: Category.find_by(name: 'Main Courses')
  )
  spaghetti.ingredients << Ingredient.where(name: [ 'ground beef', 'onion', 'garlic', 'tomatoes', 'olive oil', 'oregano', 'spaghetti' ])

  puts "✅ Created #{Recipe.count} recipes"
end

puts "\n🌱 Seeding Complete!"
puts "Categories: #{Category.count}"
puts "Ingredients: #{Ingredient.count}"
puts "Recipes: #{Recipe.count}"

# Create Users
if User.count.zero?
  admin = User.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
  admin.add_role(:admin)
  puts "✅ Created Admin User: admin@example.com"

  staff = User.create!(
    email: 'staff@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
  staff.add_role(:staff)
  puts "✅ Created Staff User: staff@example.com"
end
