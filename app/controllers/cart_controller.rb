class CartController < ApplicationController
    @@preco_pedido = 0
    def add_item
        @preco_total
        @qtd_meal = params[:qtd].to_i
        @meal_id = params[:id]
        qtd_preco = []

        set_cart.each do |index|
            if(index.has_key?(@meal_id))
                qtd_preco[@meal_id.to_i] = index[@meal_id][0] + @qtd_meal
            end
            if index[@meal_id].nil?
                qtd_preco[@meal_id.to_i] = @qtd_meal
            end
        end

        if (set_cart.empty?)
            qtd_preco[@meal_id.to_i] = @qtd_meal
        end

        @preco_total = calcula_preco_total(qtd_preco[@meal_id.to_i])

        if(set_cart[0].nil?)
            set_cart.push({@meal_id => [qtd_preco[@meal_id.to_i], @preco_total]})
        end

        if(set_cart[0].has_key?(@meal_id) == false)
            set_cart[0][@meal_id] = [qtd_preco[@meal_id.to_i], @preco_total]
        else
            set_cart[0][@meal_id] = [qtd_preco[@meal_id.to_i], @preco_total]
        end

        redirect_to root_path
    end
    
    def remove_item
        @meal_id = params[:id]
        set_cart.each do |index|
            index.delete_if{ |item| item == @meal_id }
        end

        redirect_to root_path
    end

    private
        def set_cart
            session[:cart] ||= [Hash.new]
        end

        def calcula_preco_total qtd
            meal = Meal.find(@meal_id.to_i)
            meal.price*qtd
        end
end
