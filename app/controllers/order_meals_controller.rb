class OrderMealsController < ApplicationController
    def index
    end

    def create
        # meal_category = MealCategory.create(meal_category_params)
        # if meal_category.save
        #     redirect_to meal_categories_path
        # else
        #     render :new
        # end

        set_cart.each do |index|
            if(index.has_key?(@meal_id))
                qtd_preco[@meal_id.to_i] = index[@meal_id][0] + @qtd_meal
            end
            if index[@meal_id].nil?
                qtd_preco[@meal_id.to_i] = @qtd_meal
            end
        end
    end

    private
    def set_cart
        session[:cart] ||= [Hash.new]
    end
end
