#encoding: utf-8

class UserMailer < ActionMailer::Base

	default from: 'INT@example.com'

  def password_recover(user)
  	@user = user
    mail(to: @user.email, subject: 'Recuperar Contraseña')
  end
end
