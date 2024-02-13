class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :login]
  before_action :set_users, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  load_and_authorize_resource

  def index
    @users =  User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def update
    
    if @user.update(user_params)
      render json: {
        message: "User Updated Successfully",
        user: @user
      }
    else
      render json: "Failed to update user"
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
    if user
      if user.authenticate(user_params[:password])
        @token = encode_token(user_id: user.id)
        render json: {
            user: UserSerializer.new(user),
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

  def record_not_found(e)
    render json: { error: e.record.errors.full_messages}, status: :unauthorized
  end

end
