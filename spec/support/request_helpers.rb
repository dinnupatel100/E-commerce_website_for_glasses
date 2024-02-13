module RequestHelpers
  def add_headers(user)
    request.headers['Content-Type'] = 'application/json'
    token = encode_token(user_id: user.id)
    token = "Bearer #{token}"
    request.headers['Authorization'] = token
  end

  def encode_token(payload)
    JWT.encode(payload,Rails.application.credentials.secret_key_base)
  end
end
