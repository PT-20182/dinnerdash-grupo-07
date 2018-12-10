class CartController < ApplicationController
    @@preco_pedido = 0
    def add_item
        @preco_total
        @meal_id = params[:id]
        qtd = []
        set_cart.each do |index|
            if(index.has_key?(@meal_id))
                qtd[@meal_id.to_i] = index[@meal_id][0] + 1
                print '&&&&&&&&&&&& '
                puts 'Refeição já presente'
            end
            if index[@meal_id].nil?
                qtd[@meal_id.to_i] = 1
                print '@@@@@@@@@@@@@ '
                puts 'NOVO ID'
            end
        end

        if (set_cart.empty?)
            print '$$$$$$$$$$$$$$$ '
            puts 'Carrinho vazio'
            qtd[@meal_id.to_i] = 1
        end

        @preco_total = calcula_preco_total(qtd[@meal_id.to_i])

        if(set_cart[0].nil?)
            print '++++++++++++++ '
            puts 'Carrinho nulo'
            set_cart.push({@meal_id => [qtd[@meal_id.to_i], @preco_total]})
        end

        if(set_cart[0].has_key?(@meal_id) == false)
            set_cart[0][@meal_id] = [qtd[@meal_id.to_i], @preco_total]
            # set_cart[0].fetch(@meal_id, [qtd[@meal_id.to_i], @preco_total])
            print '############### '
            puts 'NOVO ID ADC'
            print 'cart '
            puts set_cart.to_s
        else
            set_cart[0][@meal_id] = [qtd[@meal_id.to_i], @preco_total]
        end

        set_cart.each do |index|
            print '!!!!!!!!!!!!!!!!!!! '
            puts index[@meal_id][1]
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
