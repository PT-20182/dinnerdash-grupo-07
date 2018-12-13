class HomeController < ApplicationController
  PRODUCTS_SIZE = 10
  def index
    @meals = Meal.all
    @meal_categories = MealCategory.all
  end

  def checkout 
    tmp = Order.where("user_id = ?",current_user.id)
    @order = tmp.last
    if @order != nil
      @orderMeals = OrderMeal.where("order_id = ?", @order.id)
    else
      @orderMeals = OrderMeal.where("order_id = ?", 1)
    end
    @page = (params[:page] || 0).to_i
    @num_pages = (tmp.count.to_f / PRODUCTS_SIZE).ceil
    @todos = tmp.offset(PRODUCTS_SIZE * @page).limit(PRODUCTS_SIZE)
    
    #@meal = Meal.find(orderMeals.meal_id)
  end
end
