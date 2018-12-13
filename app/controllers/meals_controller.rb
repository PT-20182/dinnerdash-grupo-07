class MealsController < ApplicationController
    def index
        @meals = Meal.all
        #@meal.image.attach(params[:image])
    end

    def new
        @meal = Meal.new
        @meal_categories = MealCategory.all
    end

    def create
        meal = Meal.create(meal_params)
        if meal.save
            redirect_to meals_path
        else
            render :new
        end
    end

    def edit
        @meal = Meal.find(params[:id])
        @meal_categories = MealCategory.all
    end

    def update
        @meal = Meal.find(params[:id])
        @meal.update(meal_params)

        redirect_to meals_path
    end

    def destroy
        @meal = Meal.find(params[:id])
        @meal.destroy

        redirect_to meals_path
    end

    private

    def meal_params
        params.require(:meal).permit(:name, :description, :price, :available, :meal_category_id, :image)
    end
end
