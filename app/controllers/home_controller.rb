class HomeController < ApplicationController
  def index
    @meals = Meal.all
  end

  def checkout 
    @order = Order.where("user_id = ?",current_user.id).last
    if @order != nil
      @orderMeals = OrderMeal.where("order_id = ?", @order.id)
    else
      @orderMeals = OrderMeal.where("order_id = ?", 1)
    end
    
    #@meal = Meal.find(orderMeals.meal_id)
  end
end
