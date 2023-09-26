class ApplicationController < ActionController::Base

  before_action :check_csrf

  def authenticate_user
    if session[:user_id].nil?
      render json: { error: 'You must be logged in to do that' }, status: :unauthorized
    end
  end

  private

  def check_csrf
    unless request.get?
      unless ActiveSupport::SecurityUtils.secure_compare(cookies.encrypted['XSRF-TOKEN'], decrypt_cookie(request.headers['X-XSRF-TOKEN']))
        render json: { error: 'CSRF token mismatch' }, status: :unprocessable_entity
        return
      end
    end
  end

  def decrypt_cookie(cookie)
    data, iv, auth_tag = cookie.split("--").map do |v|
      Base64.strict_decode64(v)
    end
    cipher = OpenSSL::Cipher.new("aes-256-gcm")

    # Compute the encryption key
    secret_key_base = Rails.application.secret_key_base
    secret = OpenSSL::PKCS5.pbkdf2_hmac(secret_key_base, "authenticated encrypted cookie", 1000, cipher.key_len, OpenSSL::Digest::SHA256.new)

    # Setup cipher for decryption and add inputs
    cipher.decrypt
    cipher.key = secret
    cipher.iv  = iv
    cipher.auth_tag = auth_tag
    cipher.auth_data = ""

    # Perform decryption
    cookie_payload = cipher.update(data)
    cookie_payload << cipher.final
    cookie_payload = JSON.parse(cookie_payload)

    # Decode Base64 encoded stored data
    decoded_stored_value = Base64.decode64(cookie_payload["_rails"]["message"])
    stored_value = JSON.parse(decoded_stored_value)
  end
end
