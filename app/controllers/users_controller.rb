class UsersController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_confirmation_email!
      redirect_to root_path, notice: "Please check your email for confirmation instructions."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  private

  def create_user_params
    params.require(:user).permit(:email, :password, :nickname)
  end

  def update_user_params
    params.require(:user).permit(:current_password, :password)
  end

end
