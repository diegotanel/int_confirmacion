#encoding: utf-8

require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do

    before { visit signin_path }

    it { should have_content('Iniciar Sesion') }
    it { should have_title('Iniciar Sesion') }
  end

  describe "signin" do

  	before { visit signin_path }

  	describe "with invalid information" do

  		before {click_button "Iniciar Sesion"}

  		it {should have_selector ('div.alert.alert-error')}
  		it {should have_title("Iniciar Sesion")}

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
        click_button "Iniciar Sesion"
      end

      it { should have_title(user.name) }
      it { should have_link('Perfil',     href: user_path(user)) }
      it { should have_link('Configuracion',    href: edit_user_path(user)) }
      it { should have_link('Inscripcion al INT',     href: new_principal_path) }
      it { should have_link('Cerrar Sesion',    href: signout_path) }
      it { should_not have_link('Iniciar Sesion', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Cerrar Sesion" }
        it { should have_link('Iniciar Sesion') }
      end
  	end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Iniciar Sesion') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
  end
end