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

        @total = 0
        @ordermeals.each do |o|
            @total = @total + Meal.find(o.meal_id).price * o.quantity
        end

        @offset = ORDERS_PER_PAGE * @page

        @page_continue = @ordermeals[@offset + ORDERS_PER_PAGE + 1] == nil ? false : true

        @ordermeals = @ordermeals.slice(@offset, ORDERS_PER_PAGE)

    end

    def new
        @order = Order.new
    end

    def edit
        @page = (params[:page] || 0).to_i
        @order = Order.find(params[:id])
    end

    def update
        page = (params[:page] || 0).to_i
        @order = Order.find(params[:id])
        @order.update(order_params)

        redirect_to orders_path(page: page)
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
        page = (params[:page] || 0).to_i
        @order = Order.find(params[:id])
        @order.destroy

        page = Order.all.count > ENTRIES_PER_PAGE * page ? page : page - 1
        redirect_to orders_path(page: page)
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

end
