#encoding: utf-8

require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do

    before { visit signin_path }

    it { should have_content('Iniciar Sesión') }
    it { should have_title("Iniciar Sesión") }
  end

  describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do

      before {click_button "Iniciar Sesión"}

      it {should have_selector ('div.alert.alert-error')}
      it {should have_title("Iniciar Sesión")}

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do

      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Contraseña", with: user.password
        click_button "Iniciar Sesión"
      end

      it { should have_title("Convocatoria INT Presenta 2015") }
      it { should have_link('Configuración de la cuenta',    href: edit_user_path(user)) }
      it { should have_link('Formulario convocatoria INT Presenta 2015',     href: formularios_path) }
      it { should have_link('Cerrar Sesión',    href: signout_path) }
      it { should_not have_link('Iniciar Sesión', href: signin_path) }

      describe "followed by signout" do
        before {
          visit formularios_path
          click_link "Cerrar Sesión"
        }
        it { should have_link('Iniciar Sesión') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Iniciar Sesión') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
  end
end
