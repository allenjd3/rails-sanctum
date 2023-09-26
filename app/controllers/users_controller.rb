class UsersController < ApplicationController
  def show
    render json: User.find_by(id: session[:user_id])
  end
end
