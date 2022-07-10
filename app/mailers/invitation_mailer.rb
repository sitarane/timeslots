class InvitationMailer < ApplicationMailer
  def created_user
    @calendar = params[:calendar]
    @user = params[:user]
    @token = params[:token]
    mail to: @user.email,
      subject: I18n.t(:invitation_mailer_created_user_subject)
  end
  def invited_user
    @calendar = params[:calendar]
    @user = params[:user]
    mail to: @user.email,
      subject: I18n.t(:invitation_mailer_invited_user_subject)
  end
end
