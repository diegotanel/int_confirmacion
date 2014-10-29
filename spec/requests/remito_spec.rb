#encoding: utf-8
require 'spec_helper'

describe "Remito" do

  subject { page }

  describe "Imprimir formulario" do
    let(:fecha_impresion_remito) { Time.zone.local(2013, 9, 15, 22, 41) }
    let(:fecha_de_creacion_del_tramite) { Time.zone.local(2013, 9, 10, 22, 41) }
    let(:formulario) { FactoryGirl.create(:formulario, :created_at => fecha_de_creacion_del_tramite) }
    

    before do
      FactoryGirl.create(:principal, :formulario => formulario, nombre: "Los Chaqueños")
      sign_in formulario.user
      visit formularios_path
    end

    it { should have_link('Imprimir remito', href: imprimir_remito_formulario_path(formulario)) }

    it "descargar el pdf" do
      Timecop.freeze(fecha_impresion_remito) do        
        click_link "Imprimir remito"
        result = page.response_headers['Content-Type'].should == "application/pdf"
        if result
          nombre_del_archivo = "attachment; filename=\"remito_convocatoria_2015_los_chaqueños_20130915224100.pdf\""
          result = page.response_headers['Content-Disposition'].should == nombre_del_archivo
        end
      end
    end

    it "el pdf debe contener los datos correctos" do

    end
  end

end
