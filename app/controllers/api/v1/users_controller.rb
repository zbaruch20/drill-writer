class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  # GET /api/v1/users
  def index
    @users = User.all
  end

  # GET /api/v1/users/:username
  def show
    @user = User.find_by username: params[:username]

    if @user.nil?
      head :not_found
    end
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)

    if !@user.save
      render json: { errors: @user.errors.messages }, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/users/:username
  def update
    @user = User.find_by username: params[:username]

    if @user.nil?
      head :not_found
    elsif !@user.update user_params
      render json: { errors: @user.errors.messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/:username
  def destroy
    @user = User.find_by username: params[:username]

    if @user.nil?
      head :not_found
    elsif @user.destroy
      head :no_content
    else
      render json: { errors: @user.errors.messages }, status: :unprocessable_entity
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
