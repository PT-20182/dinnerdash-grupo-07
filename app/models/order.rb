class Order < ApplicationRecord
    has_many :meals, through: :ordermeals
    belongs_to :user
    belongs_to :situation
end
