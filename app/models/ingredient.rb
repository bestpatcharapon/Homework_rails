class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  attr_accessor :remove_image

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_one_attached :image
end
