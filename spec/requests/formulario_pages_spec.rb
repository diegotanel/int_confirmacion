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
    let(:formulario) { FactoryGirl.create(:formulario) }
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

      describe "Formulario show debe tener" do
        visit formularios_path(formulario)

        it { should have_link('Editar Datos principales') }
        it { should have_link('Cargar Datos del grupo') }
      end
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

    describe "con instancia elenco_en_gira creada" do
      let(:elenco_en_gira) { FactoryGirl.build(:elenco_en_gira) }

      before do
        elenco_en_gira.save!
        sign_in elenco_en_gira.formulario.user
        visit formularios_path
      end

      it { should_not have_selector("td", :text => "Los Chaquenos")}
      it { should have_selector("td", :text => "borrador")}
    end

    describe "con instancia datos_grupo creada" do
      let(:datos_grupo) { FactoryGirl.build(:datos_grupo) }

      before do
        datos_grupo.save!
        sign_in datos_grupo.formulario.user
        visit formularios_path
      end

      it { should_not have_selector("td", :text => "Los Chaquenos")}
      it { should have_selector("td", :text => "borrador")}

      describe "Formulario show debe tener" do
        visit formularios_path(formulario)

        it { should have_link('Cargar Datos principales') }
        it { should have_link('Editar Datos del grupo') }
      end
    end
  end
end
