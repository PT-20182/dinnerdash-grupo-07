class Order < ApplicationRecord
    has_many :order_meals, dependent: :destroy
    belongs_to :user
    belongs_to :situation
end
