class WelcomeMailer < ApplicationMailer
  def welcome_email
      @user = params[:user]
      mail(to: @user.email, subject: 'Welcome to Timeslots')
    end
end
