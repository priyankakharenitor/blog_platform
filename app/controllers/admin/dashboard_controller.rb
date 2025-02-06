module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    before_action :set_user, only: [:edit_user, :update_user, :destroy_user]

    def index
      @users = User.includes(:posts).all
    end

    def edit_user
    end

    def update_user
      if @user.update(user_params)
        redirect_to admin_dashboard_path, notice: 'User updated successfully.'
      else
        render :edit_user, alert: 'Failed to update user.'
      end
    end

    def destroy_user
      if @user.destroy
        redirect_to admin_dashboard_path, notice: 'User deleted successfully.'
      else
        redirect_to admin_dashboard_path, alert: 'Failed to delete user.'
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email)  # Include other attributes as necessary
    end

    def check_admin
      redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
    end
  end
end
