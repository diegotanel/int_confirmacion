#encoding: utf-8

require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { 
      sign_in user
      visit user_path(user) 
    }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Registrarse') }
    it { should have_title(('Registrarse')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Registrarse" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Registrarse') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Nombre",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Contraseña",     with: "foobar"
        fill_in "Confirmar Contraseña", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { 
          click_button submit 
        }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Cerrar Sesion') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenido') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Actualiza tu perfil") }
      it { should have_title("Editar Usuario") }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nombre",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Nueva Contraseña",         with: user.password
        fill_in "Confirmar Contraseña", with: user.password
        click_button "Salvar Cambios"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Cerrar Sesion', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "with invalid information" do
      before { click_button "Salvar Cambios" }

      it { should have_content('error') }
    end
  end
end
