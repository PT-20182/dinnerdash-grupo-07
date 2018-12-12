class AddCategoryToMeals < ActiveRecord::Migration[5.2]
  def change
    add_reference :meals, :meal_category, foreign_key: true
  end
end
