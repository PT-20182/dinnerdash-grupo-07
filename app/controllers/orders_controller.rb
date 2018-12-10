class OrdersController < ApplicationController
    def index
        #@orders = Order.all
        @orders = Order.paginate(:page=>params[:page],per_page:5)
    end

    def show
    end

    def new
        @order = Order.new
    end

    def edit
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
        params.require(:order).permit(:name)
    end

end
