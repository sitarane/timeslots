class InvitationMailer < ApplicationMailer
  def create_user
    @calendar = params[:calendar]
    mail to: params[:email],
      subject: I18n.t(:invitation_mailer_create_user_subject)
  end
  def invite_user

  end
end
