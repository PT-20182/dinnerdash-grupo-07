class MealCategoriesController < ApplicationController
    PRODUCTS_SIZE = 10


    def index
        @page = (params[:page] || 0).to_i
        @meal_categories = MealCategory.offset(PRODUCTS_SIZE * @page).limit(PRODUCTS_SIZE)
        @num_pages = (MealCategory.all.count.to_f / PRODUCTS_SIZE).ceil
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
