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
      mail.body.encoded.should match("Hi")
    end
  end

end
