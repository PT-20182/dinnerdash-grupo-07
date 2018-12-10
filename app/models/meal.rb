class Meal < ApplicationRecord
    has_many :orders, through: :ordermeals
end
