#encoding: utf-8
require 'spec_helper'

describe "Principal" do

  subject { page }

  describe "deben inicializarse todos los combobox del formulario en blanco" do

    let(:formulario) { FactoryGirl.create(:formulario) }
    before {
      sign_in formulario.user
    }

    it {
      FactoryGirl.create(:provincia)
      visit new_formulario_principal_path(formulario)
      #should have_selector("select#principal_provincia_id") do |n|
      should have_selector('option[value=""]', :text => "Seleccione una provincia...")
      should have_selector('option[value="1"]', :text => "Buenos Aires")
      #end
    }

    it {
      visit new_formulario_principal_path(formulario)
      should have_selector('#region', text: '')
    }

    it {
      #should have_selector("select#principal_localidad_id") do |n|
      FactoryGirl.create(:localidad)
      visit new_formulario_principal_path(formulario)
      should have_selector('option[value=""]', :text => "Seleccione una localidad...")
      should have_selector('option[value="1"]', :text => "Capital Federal")
      #end
    }

    it {
      #should have_selector("select#principal_grupo_id") do |n|
      FactoryGirl.create(:grupo)
      visit new_formulario_principal_path(formulario)
      should have_selector('option[value=""]', :text => "Seleccione un si es grupo o espectáculo concertado...")
      should have_selector('option[value="1"]', :text => "Grupo")
      #end
    }

    it {
      #should have_selector("select#principal_registro_id") do |n|
      FactoryGirl.create(:registro)
      visit new_formulario_principal_path(formulario)
      should have_selector('option[value=""]', :text => "Seleccione una opcion...")
      should have_selector('option[value="1"]', :text => "Ya registrado")
      #end
    }

    it {
      condicion1 = FactoryGirl.create(:condicion)
      condicion2 = FactoryGirl.create(:condicion, codigo: "B", detalle: "fruta")

      visit new_formulario_principal_path(formulario)
      check "condicion_#{condicion2.id}"
      opcion1 = find("#condicion_#{condicion1.id}")
      opcion1.should_not be_checked
      opcion2 = find("#condicion_#{condicion2.id}")
      opcion2.should be_checked
    }

    describe "provinicia region" do
      before {
        FactoryGirl.create(:provincia)
        visit new_formulario_principal_path(formulario)
      }

      it "cuando se selecciona una provincia se debe completar la region", :js => :true do
        select "Buenos Aires", :from => :principal_provincia_id
        find('#region').value.should eq 'Centro'
      end
    end

    describe "Condiciones por la que llena el formulario" do

    end

  end

  describe "Principal" do
    let(:formulario) { FactoryGirl.create(:formulario) }

    before {
      sign_in formulario.user
    }

    describe "falla" do

      it {
        visit new_formulario_principal_path(formulario)
        click_button "Guardar Datos"
        should have_selector("div.alert.alert-error")
      }

      it "debe estar el campo region lleno", :js => :true do
        FactoryGirl.create(:provincia)
        visit new_formulario_principal_path(formulario)
        select "Buenos Aires", :from => :principal_provincia_id
        find('#region').value.should eq 'Centro'
        click_button "Guardar Datos"
        should have_selector("div.alert.alert-error")
        find('#region').value.should eq 'Centro'
      end
    end

    describe "exitoso" do
      before do
        FactoryGirl.create(:provincia)
        FactoryGirl.create(:localidad)
        FactoryGirl.create(:grupo)
        FactoryGirl.create(:registro)
        FactoryGirl.create(:condicion)
        visit new_formulario_principal_path(formulario)
        select "Buenos Aires", :from => :principal_provincia_id
        select "Capital Federal", :from => :principal_localidad_id
        select "Grupo", :from => :principal_grupo_id
        select "Ya registrado", :from => :principal_registro_id
        fill_in :principal_nombre, :with => "Los Chaqueños"
        check "condicion_1"
        click_button "Guardar Datos"
      end

      it {
        should have_selector("div.alert.alert-success")
        should have_content('Formulario')
        should have_title('Formularios de Inscripcion del usuario')
      }
    end
  end
end
