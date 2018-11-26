class HomeController < ApplicationController
  def index
    @meals = TestMeal.all
  end
end
