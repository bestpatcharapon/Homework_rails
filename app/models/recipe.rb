class Recipe < ApplicationRecord
  belongs_to :category, optional: true

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  attr_accessor :remove_image
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end