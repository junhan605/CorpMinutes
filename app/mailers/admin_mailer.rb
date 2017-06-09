class AdminMailer < ApplicationMailer
  default from: Rails.application.secrets.email_provider_username

  def welcome_email(user)
    @user = user
    @admin = Rails.application.secrets.email_provider_username
    @url  = "http://#{Rails.application.secrets.domain_name}/users/sign_in"
    mail(to: @user.email, subject: 'Welcome to Corp minutes site')
  end

  def invite_email(user)
    @user = user
    @admin = Rails.application.secrets.email_provider_username
    @url  = "http://#{Rails.application.secrets.domain_name}/users/sign_in"
    mail(to: @user.email, subject: 'Welcome to Corp minutes site')
  end

  def approve_email(user)
    @user = user
    @admin = Rails.application.secrets.email_provider_username
    @url  = "http://#{Rails.application.secrets.domain_name}/users/sign_in"
    mail(to: @user.email, subject: 'Welcome to Corp minutes site')
  end
end
