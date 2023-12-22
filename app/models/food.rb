class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  validates :name, :measurement_unit, :price, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
