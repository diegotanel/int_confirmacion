#encoding: utf-8
require 'spec_helper'

describe "Principal" do

  subject { page }

  describe "deben inicializarse todos los combobox del formulario en blanco" do
    before {visit new_principal_path}

    it {
      should have_selector("select#principal_provincia_id") do |n|
        n.should have_selector('option[value=""]', :content => "Seleccione una provincia...")
        n.should have_selector('option[value="1"]', :content => "Buenos Aires")
      end
    }

    it {
      should have_selector("select#principal_provincia_id") do |n|
        n.should have_selector('option[value=""]', :content => "Seleccione una provincia...")
        n.should have_selector('option[value="1"]', :content => "Buenos Aires")
      end
    }

    it { should have_selector('#region', text: '') }

    it {
      should have_selector("select#principal_localidad_id") do |n|
        n.should have_selector('option[value=""]', :content => "Seleccione una localidad...")
      end
    }

    it {
      should have_selector("select#principal_grupo_id") do |n|
        n.should have_selector('option[value=""]', :content => "Seleccione grupo o...")
        n.should have_selector('option[value="1"]', :content => "Grupo")
      end
    }

    it {
      should have_selector("select#principal_registro_id") do |n|
        n.should have_selector('option[value=""]', :content => "Seleccione una opcion...")
        n.should have_selector('option[value="1"]', :content => "Ya registrado")
      end
    }

    describe "Principal exitoso" do
      before do
        before {visit new_principal_path}
        select "Buenos Aires", :from => :principal_provincia_id
        select "Capital Federal", :from => :principal_localidad_id
        select "Grupo", :from => :principal_grupo_id
        select "Sin registro", :from => :principal_registro_id
        fill_in :principal_nombre, :with => "Los Chaqueños"
        select "A", :from => :principal_condicion_id
        click_button
      end
    end
  end
end
