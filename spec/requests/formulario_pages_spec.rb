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
      let(:principal) { FactoryGirl.create(:principal) }

      before do
        sign_in principal.formulario.user
        visit formularios_path
      end

      it { should have_selector("td", :text => "Los Chaquenos")}
      it { should have_selector("td", :text => "borrador")}

      describe "Formulario edit debe tener" do
        before do
          visit edit_formulario_path(principal.formulario)
        end

        #it { should have_link('Datos Principales') }
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
      let(:elenco_en_gira) { FactoryGirl.create(:elenco_en_gira) }

      before do
        sign_in elenco_en_gira.formulario.user
        visit formularios_path
      end

      it { should_not have_selector("td", :text => "Los Chaquenos")}
      it { should have_selector("td", :text => "borrador")}
    end

    describe "con instancia datos_grupo creada" do
      let(:datos_grupo) { FactoryGirl.create(:datos_grupo) }

      before do
        sign_in datos_grupo.formulario.user
        visit formularios_path
      end

      it { should_not have_selector("td", :text => "Los Chaquenos")}
      it { should have_selector("td", :text => "borrador")}

      describe "Formulario edit debe tener" do
        before do
          visit edit_formulario_path(datos_grupo.formulario)
        end
        it {
          should have_selector("td", :text => "Datos Principales")
          should have_selector("td", :text => "Datos generales del espectáculo")
          should have_selector("td", :text => "Datos técnicos del espectáculo")
          should have_selector("td", :text => "Datos del elenco en gira")
          should have_selector("td", :text => "Datos del responsable")
        }
        it { should have_link('Alta') }
      end
    end
  end
end
