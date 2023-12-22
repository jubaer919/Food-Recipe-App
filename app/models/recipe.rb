class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  validates :name, :cooking_time, :description, :preparation_time, presence: true
end
