class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :login]
  before_action :set_users, only: [:show, :update, :destroy]
  load_and_authorize_resource :except=> [:update, :destroy, :index]

  def index
    @users =  User.all
    if @users.empty?
      render json: "no user found", status: :not_found
    else
      render json: @users , status: :ok
    end
  end

  def show
    if @user.nil?
      render json: "no data", status: :ok
    else
      render json: @user, status: :ok
    end
  end

  def update
    if @user.nil?
      render json: { message: "Failed to update user"}, status: :not_found
    else
      @user.update(user_params)
      render json: {
        message: "User Updated Successfully",
        user: @user
      }, status: :ok
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      token = encode_token(user_id: user.id)
      render json: {
        user: UserSerializer.new(user)
      },status: :created
    else
      render json: user.errors.full_messages, status: :bad_request
    end
  end

  def destroy
    if @user.nil?
      render json: "Failed to delete user", status: :bad_request
    else
      @user.destroy
      render json: "User Deleted Successfully", status: :ok
    end
  end

  def login
    user = User.find_by(email: user_params[:email])
    if user
      if user.authenticate(user_params[:password])
        @token = encode_token(user_id: user.id)
        render json: {
            # user: UserSerializer.new(user),
            message: "login successful",
            token: @token
        }, status: :accepted
      else
        render json: {error: 'Invalid email or  password'}, status: :unauthorized
      end
    else
      render json: {error: 'Invalid email or  password'}, status: :unauthorized
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
