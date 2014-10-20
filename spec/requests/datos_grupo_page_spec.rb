#encoding: utf-8
require 'spec_helper'

describe "Datos_Grupo" do

  subject { page }

  describe "pagina para crear los datos del grupo" do
    let(:formulario) { FactoryGirl.create(:formulario) }
    before {
      sign_in formulario.user
      visit new_formulario_datos_grupo_path(formulario)
    }

    it { should have_content("Datos del grupo") }
    it { should have_title("Datos del grupo") }

    describe "falla" do
      let(:submit) { "Cargar Datos" }

      describe "with invalid information" do
        it "should not create a datos_grupo" do
          expect { click_button submit }.not_to change(DatosGrupo, :count)
        end
        describe "after submission" do
          before { click_button submit }

          it { should have_title('Datos del grupo') }
          it { should have_content('error') }
        end
      end
    end

    describe "exitoso" do
      before do
        fill_in "Nombre del grupo", with: "Pampa"
        fill_in "Breve historia del grupo", with: "dfohjdfnhodjnhofgsjhnskfjhnfsñkjhnsfkhnsfhkjnfhknshknsfkhnfskhnsfh"
        click_button "Guardar Datos"
      end

      # it "should create a datos_grupo" do
      #   expect { click_button submit }.to change(DatosGrupo, :count).by(1)
      # end

      it {
        should have_selector("div.alert.alert-success")
        should have_content('Pampa')
        #should have_title('Formularios de Inscripcion del usuario')
      }
    end
  end
end
