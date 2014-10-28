#encoding: utf-8
require 'spec_helper'

describe "ElencoEnGira" do

  subject { page }

  describe "lista de integrantes" do
    let(:elenco_en_gira) { FactoryGirl.create(:elenco_en_gira) }
    let(:localidad) { FactoryGirl.create(:localidad) }

    def params
      {type: 'Actor', nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "12345678912", fecha_de_nacimiento: DateTime.now, calle: "Santa Fe", altura_calle: "1000", localidad: localidad, codigo_postal: "1406", tel_celular: "5345345", tel_particular: ''}
    end

    before do
      sign_in elenco_en_gira.formulario.user
    end

    describe "listar integrantes" do
      before do
        @actor = elenco_en_gira.integrantes_de_elenco_en_gira.create!(params)
        @director = elenco_en_gira.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "12345678442"))
        @tecnico = elenco_en_gira.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Lucas", apellido: "Capo", email: "lucas.capo@gmail.com", cuil_cuit: "12345678445"))
        visit formulario_elencos_en_gira_path(elenco_en_gira.formulario)
      end

      it { should have_selector("td", :text => "Pedro")}
      it { should have_selector("td", :text => "Roberto")}
      it { should have_selector("td", :text => "Lucas")}


      it { should have_content('Elenco en gira') }
      it { should have_title(('Formulario de elenco en gira')) }

      describe "links de actor" do
        it {
          should have_link('Nuevo actor', href: new_formulario_actor_path(elenco_en_gira.formulario))
        }

        it {
          should have_link('Ver', href: formulario_actor_path(elenco_en_gira.formulario, @actor))
        }

        it {
          should have_link('Modificar', href: edit_formulario_actor_path(elenco_en_gira.formulario, @actor))
        }

        it {
          should have_link('Eliminar', href: formulario_actor_path(elenco_en_gira.formulario, @actor))
        }
      end

      describe "links de director" do
        it {
          should have_link('Nuevo director', href: new_formulario_director_path(elenco_en_gira.formulario))
        }

        it {
          should have_link('Ver', href: formulario_director_path(elenco_en_gira.formulario, @director))
        }

        it {
          should have_link('Modificar', href: edit_formulario_director_path(elenco_en_gira.formulario, @director))
        }

        it {
          should have_link('Eliminar', href: formulario_director_path(elenco_en_gira.formulario, @director))
        }
      end

      describe "links de técnico" do
        it {
          should have_link('Nuevo técnico', href: new_formulario_tecnico_path(elenco_en_gira.formulario))
        }

        it {
          should have_link('Ver', href: formulario_tecnico_path(elenco_en_gira.formulario, @tecnico))
        }

        it {
          should have_link('Modificar', href: edit_formulario_tecnico_path(elenco_en_gira.formulario, @tecnico))
        }

        it {
          should have_link('Eliminar', href: formulario_tecnico_path(elenco_en_gira.formulario, @tecnico))
        }
      end
    end
  end

end
