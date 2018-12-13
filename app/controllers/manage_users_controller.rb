class ManageUsersController < ApplicationController
    before_action :check_admin

    ENTRIES_PER_PAGE = 8

    def index
        @page = (params[:page] || 0).to_i
        @users = User.offset(ENTRIES_PER_PAGE * @page).limit(ENTRIES_PER_PAGE).order(:id)
        @page_continue = User.all.count > ENTRIES_PER_PAGE * (@page + 1) ? true : false
    end

    def show
    end

    def new
    end

    def edit
        @page = (params[:page] || 0).to_i
        @user = User.find(params[:id])
    end

    def update
        page = (params[:page] || 0).to_i
        @user = User.find(params[:id])
        unless current_user.id == @user.id
            @user.update(user_params)
        else
            @user.update(own_user_params)
        end

        redirect_to manage_users_path(page: page)
    end

    def create
        @user = User.new(order_params)
        if @user.save
            redirect_to manage_users_path
        else
            render :new
        end
    end

    def destroy
        page = (params[:page] || 0).to_i
        @user = User.find(params[:id])
        unless @user.is_admin
            @user.destroy
        else
            flash.alert = 'Não foi possível excluir usuário.'
        end
        redirect_to manage_users_path(page: page)
    end

    private
    def user_params
        params.require(:user).permit(:name, :is_admin, :email)
    end

    # Caso seja o próprio administrador tentando atualizar seu perfil, não pode mudar seu valor de is_admin.
    def own_user_params
        params.require(:user).permit(:name, :email)
    end

    def check_admin
        unless user_signed_in? && current_user.is_admin
            redirect_to :root
        end
    end

end
