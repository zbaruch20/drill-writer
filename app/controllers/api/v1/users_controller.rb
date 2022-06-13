class Api::V1::UsersController < ApplicationController

  # GET /api/v1/users
  def index
    @users = User.all
  end

  # GET /api/v1/users/:username
  def show
    @user = User.find_by username: params[:username]

    if @user.nil?
      render status: :not_found
    end
  end

  private

  # Strong parameters
  def user_params
    params.require(:user).permit :username,
                                 :email,
                                 :password,
                                 :password_confirmation
  end
end
