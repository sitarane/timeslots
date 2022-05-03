class PasswordResetsController < ApplicationController
  def new
  end
  def edit
    # finds user with a valid token
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to sign_in_path, alert: t(:token_expired)
  end
  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      # send mail
      PasswordMailer.with(user: @user).reset.deliver_later
    end
    redirect_to root_path, notice: t(:check_email_password_reset)
  end
  def update
    # updates user's password
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    if @user.update(password_params)
      redirect_to login_path, notice: t(:password_reset)
      else
      render :edit
    end
  end
  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
