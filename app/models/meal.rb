class Meal < ApplicationRecord
    has_one_attached :image
    validates :name, presence: true
    validates :description, presence: true, length: { maximum: 50,
    too_long: "%O limite é de %{count} caracteres" }
    validates :price, numericality: true, presence: true
    has_many :order_meals
end
