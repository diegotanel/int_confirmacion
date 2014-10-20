#encoding: utf-8
require 'spec_helper'

describe "IntegrantesDeElencoEnGira" do

  subject { page }

  describe "Integrantes" do
    date = Date.new(2007, 11, 10)
    let(:elenco_en_gira) { FactoryGirl.create(:elenco_en_gira) }

    before do
      sign_in elenco_en_gira.formulario.user
    end

    describe "alta de integrante" do
      before do
        FactoryGirl.create(:localidad)
        visit new_formulario_actor_path(elenco_en_gira.formulario)
      end

      it { should have_content('Alta de integrante') }
      it { should have_title(('Formulario de alta de integrante')) }

      it {
        #should have_selector("select#principal_provincia_id") do |n|
        should have_selector('option[value=""]', :text => "Seleccione una provincia...")
        should have_selector('option[value="1"]', :text => "Buenos Aires")
        #end
      }

      it {
        #should have_selector("select#principal_localidad_id") do |n|
        should have_selector('option[value=""]', :text => "Seleccione una localidad...")
        should have_selector('option[value="1"]', :text => "Capital Federal")
        #end
      }

      describe "fallido" do
        before {
          click_button "Guardar Datos"
        }


        it {
          should have_selector("div.alert.alert-error")
        }

        it {
          fill_in :actor_nombre, :with => "Diego"
          fill_in :actor_apellido, :with => "Tanel"
          fill_in :actor_cuil_cuit, :with => "20284635486"
          select "13", :from => "actor_fecha_de_nacimiento_3i"
          select "octubre", :from => "actor_fecha_de_nacimiento_2i"
          select "2014", :from => "actor_fecha_de_nacimiento_1i"
          fill_in :actor_calle, :with => "Padilla"
          fill_in :actor_altura_calle, :with => "231"
          select "Buenos Aires", :from => :ideec_provincia_id
          select "Capital Federal", :from => :actor_localidad_id
          fill_in :actor_codigo_postal, :with => "1414"
          fill_in :actor_tel_celular, :with => "3123123"
          fill_in :actor_email, :with => "dtanel@gmail.com"
          click_button "Guardar Datos"
          should have_selector("div.alert.alert-success")
        }
      end

      describe "exitoso" do
        before {
          fill_in :actor_nombre, :with => "Diego"
          fill_in :actor_apellido, :with => "Tanel"
          fill_in :actor_cuil_cuit, :with => "20284635486"
          select "13", :from => "actor_fecha_de_nacimiento_3i"
          select "octubre", :from => "actor_fecha_de_nacimiento_2i"
          select "2014", :from => "actor_fecha_de_nacimiento_1i"
          fill_in :actor_calle, :with => "Padilla"
          fill_in :actor_altura_calle, :with => "231"
          select "Buenos Aires", :from => :ideec_provincia_id
          select "Capital Federal", :from => :actor_localidad_id
          fill_in :actor_codigo_postal, :with => "1414"
          fill_in :actor_tel_celular, :with => "3123123"
          fill_in :actor_email, :with => "dtanel@gmail.com"
          click_button "Guardar Datos"
        }

        it {
          should have_selector("div.alert.alert-success")
          should have_content('Elenco en gira')
          should have_title('Formulario de elenco en gira')
        }
      end
    end

    describe "lista de localidades" do
      it "debe listarse las localidades correspondientes a la provincia", js: :true do
        @reg1 = Region.create!(detalle: "NOA")
        @provincia1 = @reg1.provincias.create!(detalle: "Jujuy")
        @localidad1 = @provincia1.localidades.create!(detalle: "9 de Octubre")
        @reg2 = Region.create!(detalle: "Centro")
        @provincia2 = @reg2.provincias.create!(detalle: "Buenos Aires")
        @localidad2 = @provincia2.localidades.create!(detalle: "CABA")
        visit new_formulario_actor_path(elenco_en_gira.formulario)
        select "Buenos Aires", :from => :ideec_provincia_id
        should have_selector(%-option[value="#{@localidad2.id}"]-, :text => "Buenos Aires")
        should_not have_selector(%-option[value="#{@localidad1.id}"]-, :text => "9 de Octubre")
      end
    end

    describe "acciones" do
      let(:localidad) {FactoryGirl.create(:localidad)}
      before do
        @integrante_de_elenco_en_gira = elenco_en_gira.integrantes_de_elenco_en_gira.create(type: 'Actor',nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "12345678912", fecha_de_nacimiento: date, calle: "Santa Fe", altura_calle: "1000", localidad: localidad, codigo_postal: "1406", tel_celular: "13123")
      end

      describe "modificacion" do
        before do
          visit edit_formulario_actor_path(elenco_en_gira.formulario, @integrante_de_elenco_en_gira)
        end

        it { should have_content('Modificación de integrante') }
        it { should have_title(('Formulario de modificación de integrante')) }

        it {
          #should have_selector("select#principal_provincia_id") do |n|
          should have_selector('option[value=""]', :text => "Seleccione una provincia...")
          should have_selector('option[value="1"]', :text => "Buenos Aires")
          #end
        }

        it {
          #should have_selector("select#principal_localidad_id") do |n|
          should have_selector('option[value=""]', :text => "Seleccione una localidad...")
          should have_selector('option[value="1"]', :text => "Capital Federal")
          #end
        }

        describe "fallido" do
          before {
            fill_in :actor_nombre, :with => ""
            click_button "Guardar Datos"
          }

          it {
            should have_selector("div.alert.alert-error")
          }

          it {
            fill_in :actor_nombre, :with => "fruta"
            click_button "Guardar Datos"
            should have_selector("div.alert.alert-success")
          }
        end

        describe "exitoso" do
          before {
            fill_in :actor_nombre, :with => "Fernando"
            click_button "Guardar Datos"
          }

          it {
            should have_selector("div.alert.alert-success")
            should have_content('Elenco en gira')
            should have_title('Formulario de elenco en gira')
            should have_selector("td", :text => "Fernando")
          }
        end
      end

      describe "visualizar" do
        before do
          visit formulario_actor_path(elenco_en_gira.formulario, @integrante_de_elenco_en_gira)
        end

        it { should have_content('Datos del integrante') }
        it { should have_title(('Datos del integrante')) }

        it {
          should have_selector("p", :text => "Pedro")
          should have_selector("p", :text => "Gomez")
          should have_selector("p", :text => "pedro.gomez@gmail.com")
          should have_selector("p", :text => "12345678912")
          should have_selector("p", :text => "Pedro")
          should have_selector("p", :text => "Santa Fe")
          should have_selector("p", :text => "1000")
          should have_selector("p", :text => localidad.provincia.detalle)
          should have_selector("p", :text => localidad.detalle)
          should have_selector("p", :text => "1406")
        }
      end

      describe "eliminar" do
        before do
          visit formulario_elencos_en_gira_path(elenco_en_gira.formulario)
        end

        it "eliminar un integrante", :js => true do
          #should have_content('Elenco en gira')
          should have_selector("td", :text => "Pedro")
          click_link "Eliminar"
          page.driver.browser.switch_to.alert.accept
          should have_selector("div.alert.alert-success")
          should_not have_selector("td", :text => "Pedro")
          should have_title('Formulario de elenco en gira')
          #should have_content('Elenco en gira')
        end
      end
    end


  end
end
