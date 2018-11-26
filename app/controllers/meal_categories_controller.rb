class MealCategoriesController < ApplicationController
    def index
        @meal_categories = MealCategory.all
    end

    def new
        @meal_category = MealCategory.new
    end

    def create
        meal_category = MealCategory.create(meal_category_params)
        if meal_category.save
            redirect_to meal_categories_path
        else
            render :new
        end
    end

    def show
        @meal_category = MealCategory.find(params[:id])
    end

    def edit
        @meal_category = MealCategory.find(params[:id])
    end

    def update
        @meal_category = MealCategory.find(params[:id])
        @meal_category.update(meal_category_params)


        redirect_to meal_category_path(@meal_category)
    end

    def destroy
        @meal_category = MealCategory.find(params[:id])
        @meal_category.destroy

        redirect_to meal_categories_path
    end

    private

    def meal_category_params
        params.require(:meal_category).permit(:name)
    end
end
