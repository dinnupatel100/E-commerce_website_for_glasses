class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :login]
  before_action :set_users, only: [:show, :update, :destroy]
  load_and_authorize_resource :except=> [:update, :destroy, :index]

  def index
    @users =  User.all
    if @users.empty?
      render json: { message: I18n.t("user.noUser") }, status: :ok
    else
      render json: @users , status: :ok
    end
  end

  def show
    if @user.nil?
      render json: {message:I18n.t("user.userNotExist")}, status: :ok
    else
      render json: @user, status: :ok
    end
  end

  def update
    if @user.nil?
      render json: { error: I18n.t("user.userUpdateError")}, status: :bad_request
    else
      @user.update(user_params)
      render json: {
        message: I18n.t("user.userUpdateSuccess"),
      }, status: :ok
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      token = encode_token(user_id: user.id)
      render json: {
        message: I18n.t("user.signupSuccess")
      },status: :ok
    else
      render json:{
        error: user.errors.full_messages
        }, status: :bad_request
    end
  end

  def destroy
    if @user.nil?
      render json: {error: I18n.t("user.userNotExist") }, status: :bad_request
    else
      @user.destroy
      render json: {message: I18n.t("user.deleteUser")}, status: :ok
    end
  end

  def login
    user = User.find_by(email: user_params[:email])
    if user
      if user.authenticate(user_params[:password])
        @token = encode_token(user_id: user.id)
        render json: {
            # user: UserSerializer.new(user),
            message: I18n.t('user.signinSuccess'),
            token: @token
        }, status: :ok
      else
        render json: {error: I18n.t("user.signinError")}, status: :bad_request
      end
    else
      render json: {error: I18n.t("user.signinError")}, status: :bad_request
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
