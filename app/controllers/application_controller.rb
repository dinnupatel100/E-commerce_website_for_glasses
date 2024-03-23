class ApplicationController < ActionController::API
  before_action :authorized
  rescue_from CanCan::AccessDenied, with: :handle_authorization
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # load_and_authorize_resource

  def encode_token(payload)
    JWT.encode(payload,Rails.application.credentials.secret_key_base)
  end

  def decode_token
    header = request.headers['authorization']
    if header
      token = header.split(" ")[1]
      begin
        JWT.decode(token, Rails.application.credentials.secret_key_base)
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decode_token
      user_id = decode_token[0]['user_id']
      user = User.find_by(id: user_id)
    end
  end

  def authorized
    unless !!current_user
      render json: "please login first"
    end
  end

  private

  def handle_authorization
    render json: { message: "You don't have access"}, status: :unauthorized
  end

  def record_not_found
    render json: "Record not found", status: :not_found
  end
end
