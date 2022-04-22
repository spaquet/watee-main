class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :destroy, :update]
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

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path, notice: "Your account has been deleted."
  end

  def edit
    @user = current_user
  end

  def new
    @user = User.new
  end

  def update
    @user = current_user
    msg = "Account updated successfully." # default message

    # If the user's account is locked, do nothing but warn them
    if !@user.locked
      # If the user is updating their email, send a confirmation email and adavise them to check their email
      if update_user_params[:email].present?
        msg = "Email & account updated successfully. Please check your mail for confirmation instructions."
      end

      # Save the user's changes
      if @user.update(update_user_params)
        @user.send_confirmation_email! unless !update_user_params[:email].present?
        redirect_to root_path, notice: msg
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:error] = "Your account has been locked. Please contact support."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_user_params
    params.require(:user).permit(:email, :password, :nickname)
  end

  def update_user_params
    params.require(:user).permit(:email, :nickname)
  end

end
