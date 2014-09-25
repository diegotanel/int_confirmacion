#encoding: utf-8

require "spec_helper"

describe UserMailer do

  describe "password_recover" do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { UserMailer.password_recover(user) }

    it "renders the headers" do
      mail.subject.should eq("Recuperar Contraseña")
      mail.to.should eq(["michael@example.com"])
      mail.from.should eq(["INT@example.com"])
    end

    it "renders the body" do
      mensaje = "\r\n\r\n<!DOCTYPE html>\r\n<html>\r\n  <head>\r\n    <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />\r\n  </head>\r\n  <body>\r\n    <h1>Bienvenido al sistema de recuperacion de contraseña, Michael Hartl</h1>\r\n    <p>\r\n      Su contraseña es: foobar.<br>\r\n    </p>\r\n    <p>Si usted no realizo la accion de recuperar contraseña, por favor ignore este mail. Buenos dias!</p>\r\n  </body>\r\n</html>"
      mail.body.encoded.should match(mensaje)
    end
  end

end
