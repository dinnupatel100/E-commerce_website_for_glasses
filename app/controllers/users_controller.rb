class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :login]
  before_action :set_users, only: [:show, :update, :destroy]

  def index
    @users =  User.all
    render json: @users
  end

  def show
    @user
  end

  def update
    if @user.update(user_params)
      render json: "User Updated Successfully"
    else
      render json: "Failed to update user"
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      token = encode_token(user_id: user.id)
      render json: {
        user: user,
        token: token
      },status: :created
    else
      render json: user.errors.full_messages
    end
  end

  def destroy
    @user.destroy
    if @user.destroyed?
      render json: "User Deleted Successfully"
    else
      render json: "Failed to delete user"
    end
  end

  def login
    user = User.find_by(email: user_params[:email])
    if user.authenticate(user_params[:password])
      @token = encode_token(user_id: user.id)
      render json: {
          user: user,
          token: @token
      }, status: :accepted
    else
      render json: {message: 'Incorrect password'}, status: :unauthorized
    end
  end


  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :dob, :mobile_no, :address, :city, :postal_code )
  end

  def set_users
    @user = User.find_by(id: params[:id])
  end
end
