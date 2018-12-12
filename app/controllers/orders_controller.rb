class OrdersController < ApplicationController

    before_action :check_admin

    ORDERS_PER_PAGE = 8


    def index
        # @orders = Order.all
        @page = (params[:page] || 0).to_i
        @orders = Order.offset(ORDERS_PER_PAGE * @page).limit(ORDERS_PER_PAGE).order(:id)

        @page_continue = Order.all.count > ORDERS_PER_PAGE * (@page + 1) ? true : false

    end

    def show
        @page = (params[:page] || 0).to_i
        @order = Order.find(params[:id])
        @ordermeals = OrderMeal.where("order_id = ?", @order.id)

        @total = calcula_preco_total(@ordermeals)

        @offset = ORDERS_PER_PAGE * @page

        @page_continue = @ordermeals[@offset + ORDERS_PER_PAGE + 1] == nil ? false : true

        @ordermeals = @ordermeals.slice(@offset, ORDERS_PER_PAGE)

    end

    def new
        @order = Order.new
    end

    def edit
        @order = Order.find(params[:id])
    end

    def update
        @order = Order.find(params[:id])
        @order.update(order_params)

        redirect_to orders_path
    end

    def create
        if(session_cart.empty? || session_cart.empty?)
            flash[:alert] = 'Carrinho vazio.'
            redirect_to root_path
        else

            @order = Order.new(user_id: current_user.id,
                               situation_id: 1,
                               )

            @order.save

            session_cart.each do |index|
                index.each do |key, value|
                    order_meal = OrderMeal.new(order_id: @order.id,
                                               meal_id: key.to_i,
                                               quantity: value[0])
                    order_meal.save
                end
            end

            ordermeals = OrderMeal.where("order_id = ?", @order.id)

            total = calcula_preco_total(ordermeals)


            # session_cart = [{"1" => [5, 60.0], "2" => [1, 8.0]}]

            redirect_to root_path
        end
    end

    def destroy
        @order = Order.find(params[:id])
        @order.destroy

        redirect_to orders_path
    end

    private

    def order_params
        params.require(:order).permit(:id, :situation_id)
    end

    def check_admin
        unless user_signed_in? && current_user.is_admin
            redirect_to :root
        end
    end

    def calcula_preco_total ordermeals
        total = 0
        ordermeals.each do |o|
            total = total + Meal.find(o.meal_id).price * o.quantity
        end
        return total
    end

    def session_cart
        sessio[:cart] ||= [Hash.new]
    end

end
