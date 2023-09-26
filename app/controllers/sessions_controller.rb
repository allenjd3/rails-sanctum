class SessionsController < ApplicationController
  before_action :authenticate_user, only: [:destroy]

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      old_values = session.to_hash
      reset_session
      session.update old_values.except('user_id')

      session[:user_id] = user.id
      render json: { status: :created, user: user }
    else
      render json: { errors: {email: ['Those credentials did not match our records. Please try again.']} }, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    session[:user_id] = nil
    render json: { status: 200 }
  end

  def csrf
    cookies.encrypted['XSRF-TOKEN'] = {
      value: SecureRandom.hex(32),
    }

    render json: {}, status: :no_content
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
