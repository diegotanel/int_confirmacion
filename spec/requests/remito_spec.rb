#encoding: utf-8
require 'spec_helper'

describe "Remito" do

  subject { page }

  describe "Imprimir formulario" do
    let(:fecha_impresion_remito) { Time.zone.local(2013, 9, 15, 22, 41) }
    let(:fecha_de_creacion_del_tramite) { Time.zone.local(2013, 9, 10, 22, 41) }
    let(:formulario) { FactoryGirl.create(:formulario, :created_at => fecha_de_creacion_del_tramite, :estado => 1) }
    
    let(:ruta_archivo_odt) { Rails.root.join("public/remitos/remito_convocatoria_2015_20130915224100.odt") }
    let(:ruta_archivo_pdf) { Rails.root.join("public/remitos/remito_convocatoria_2015_20130915224100.pdf") }

    before do
      @fecha = Date.today
      @principal = FactoryGirl.create(:principal, :formulario => formulario, nombre: "Los Chaqueños")
      paramsIntegrante = {type: 'Actor', nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "20284635486", fecha_de_nacimiento: @fecha, calle: "Santa Fe", altura_calle: "1000", localidad: @principal.localidad, codigo_postal: "1406", tel_celular: "5345345", tel_particular: ''}
      formulario.build_elenco_en_gira
      formulario.elenco_en_gira.saltear_validaciones_de_presencia = true
      formulario.elenco_en_gira.save!
      @integrante_de_elenco_en_gira = formulario.elenco_en_gira.integrantes_de_elenco_en_gira.create!(paramsIntegrante)
      formulario.create_responsable
      @persona_fisica_e = formulario.responsable.build_persona_fisica_e(integrante_de_elenco_en_gira_id: @integrante_de_elenco_en_gira.id)
      @persona_fisica_e.save!
      formulario.estado = 1

      formulario.save!
      sign_in formulario.user
      visit formularios_path
    end

    it { should have_link('Imprimir remito', href: imprimir_remito_formulario_path(formulario)) }

    it "descargar el pdf" do
      Timecop.freeze(fecha_impresion_remito) do
        click_link "Imprimir remito"
        result = page.response_headers['Content-Type'].should == "application/pdf"
        if result
          nombre_del_archivo = "attachment; filename=\"remito_convocatoria_2015_20130915224100.pdf\""
          result = page.response_headers['Content-Disposition'].should == nombre_del_archivo
        end
      end
    end

    it "el pdf debe contener los datos correctos" do
      Timecop.freeze(fecha_impresion_remito) do
        File.delete(ruta_archivo_odt) if File.exist?(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
        click_link 'Imprimir remito'

        reader = PDF::Reader.new(ruta_archivo_pdf)
        @text = nil
        reader.pages.each do |page|
          @text = page.text
        end

        @text.should include("15/09/2013 22:41:00")
        @text.should include("Los Chaqueños")
        @text.should include("Buenos Aires")
        @text.should include("Centro")
        @text.should include("1")
        @text.should include("10/09/2013 22:41:00")
        @text.should include("Pedro")
        @text.should include("Gomez")
        @text.should include("20284635486")
        @text.should include(I18n.l(@fecha, format: :short))
        File.delete(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf)
      end
    end
  end

end
