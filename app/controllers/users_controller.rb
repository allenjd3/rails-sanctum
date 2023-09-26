class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  def show
    render json: User.find_by(id: session[:user_id])
  end
end
