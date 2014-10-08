#encoding: utf-8
require 'spec_helper'

describe "Formulario" do

  subject { page }

  describe "formulario page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit formularios_path
    end

    it { should have_content('Formulario') }
    it { should have_title(('Formularios de Inscripcion del usuario')) }
  end

  describe "lista de formularios" do
    describe "con instancia principal creada" do
      let(:principal) { FactoryGirl.build(:principal) }
      let(:condicion) { FactoryGirl.create(:condicion) }

      before do
        principal.condiciones << condicion
        principal.save!
        sign_in principal.formulario.user
        visit formularios_path
      end

      it { should have_selector("td", :text => "Los Chaquenos")}
      it { should have_selector("td", :text => "borrador")}
    end

    describe "sin instancia principal creada" do
      let(:formulario) { FactoryGirl.create(:formulario) }

      before do
        sign_in formulario.user
        visit formularios_path
      end

      it { should_not have_selector("td", :text => "Los Chaquenos")}
      it { should have_selector("td", :text => "borrador")}
    end
  end
end
