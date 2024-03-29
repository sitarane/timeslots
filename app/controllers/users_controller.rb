class UsersController < ApplicationController
  # instantiates new user
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      WelcomeMailer.with(user: @user).welcome_email.deliver_now
      # stores saved user id in a session
      session[:user_id] = @user.id
      redirect_to root_path, notice: t(:user_created)
    else
      render :new
    end
  end

  def update
    if Current.user.update(user_params)
      redirect_back_or_to root_url, notice: t(:user_updated)
    else
      redirect_back_or_to root_url, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # strong parameters
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :timezone
    )
  end
end
