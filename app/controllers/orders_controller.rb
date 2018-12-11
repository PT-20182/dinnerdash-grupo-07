class OrdersController < ApplicationController

    def index
        #@orders = Order.all
        @orders = Order.all
    end

    def show
        @order = Order.find(params[:id])
        @ordermeals = OrderMeal.where("order_id = ?", @order.id)
    end

    def new
        @order = Order.new
    end

    def edit
        @order = Order.find(params[:id])
        @ordermeals = OrderMeal.where("order_id = ?", @order.id)
    end

    def create
        @order = Order.new(order_params)
        if @order.save
            redirect_to orders_path
        else
            render :new
        end
    end

    def destroy
        @order = Order.find(params[:id])
        @order.destroy

        redirect_to orders_path
    end


    private

    def order_params
        params.require(:id).permit(:name)
    end

end
