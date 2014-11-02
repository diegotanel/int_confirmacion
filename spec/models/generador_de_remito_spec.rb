#encoding: utf-8
require 'spec_helper'

describe GeneradorDeRemito do
  let(:fecha_impresion_remito) { Time.zone.local(2014, 4, 14, 12, 41, 32) }
  let(:fecha_de_creacion_del_tramite) { Time.zone.local(2014, 4, 10, 22, 46, 56) }
  let(:formulario) { FactoryGirl.create(:formulario, :created_at => fecha_de_creacion_del_tramite) }
  let(:ruta_archivo_odt) { Rails.root.join("public/remitos/remito_convocatoria_2015_20140414124132.odt") }
  let(:ruta_archivo_pdf) { Rails.root.join("public/remitos/remito_convocatoria_2015_20140414124132.pdf") }


  before do
    Timecop.freeze(fecha_impresion_remito) do
      @generador_de_remito = GeneradorDeRemito.new
    end
    @principal = FactoryGirl.create(:principal, :formulario => formulario, nombre: "Los Chaqueños")
  end

  subject { @generador_de_remito }

  #it { should respond_to(:obtener_datos_para_remito) }
  it { should respond_to(:generar_pdf) }

  # describe "obtener datos para remito" do
  #   it {
  #     Timecop.freeze(fecha_impresion_remito) do
  #       datos = subject.obtener_datos_para_remito(formulario)
  #       datos.fecha_de_impresion_del_remito.should == "14/04/2014 12:41:32"
  #       datos.nombre_del_espectaculo.should == "Los Chaqueños"
  #       datos.provincia.should == "Buenos Aires"
  #       datos.region.should == "Centro"
  #       datos.numero_de_tramite.should == "1"
  #       datos.fecha_de_tramite.should == "10/04/2014 22:46:56"
  #       datos.datos_del_responsable.should == "fruta"
  #     end
  #   }
  # end

  describe "verificar si se genera el archivo odt" do
    it {
      Timecop.freeze(fecha_impresion_remito) do
        File.delete(ruta_archivo_odt) if File.exist?(ruta_archivo_odt)
        datos = subject.generar_pdf(formulario)
        odt = File.read(ruta_archivo_odt)
        File.delete(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
      end
    }
  end

  describe "verificar si se genera el archivo pdf" do
    it {
      Timecop.freeze(fecha_impresion_remito) do
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
        datos = subject.generar_pdf(formulario)
        pdf = File.read(ruta_archivo_pdf)
        File.delete(ruta_archivo_pdf)
      end
    }
  end

  # describe "generar el remito con formato pdf" do
  #   it {
  #     Timecop.freeze(fecha_impresion_remito) do
  #       subject.generar_pdf(formulario)
  #       File.delete(ruta_archivo_odt) if File.exist?(ruta_archivo_odt)
  #       File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
  #       subject.generar_pdf(formulario)

  #       reader = PDF::Reader.new(ruta_archivo_pdf)

  #       @text = nil
  #       reader.pages.each do |page|
  #         @text = page.text
  #       end

  #       @text.should include("14/04/2014 12:41:32")
  #       @text.should include("Los Chaqueños")
  #       @text.should include("Buenos Aires")
  #       @text.should include("Centro")
  #       @text.should include("1")
  #       @text.should include("10/04/2014 22:46:56")
  #       @text.should include("fruta")
  #       File.delete(ruta_archivo_odt)
  #       File.delete(ruta_archivo_pdf)
  #     end
  #   }
  # end

  #let(:elenco_en_gira) { FactoryGirl.build(:elenco_en_gira) }

  describe "generar el remito con formato pdf con responsable persona fisica existente" do
    before do
      @fecha = Date.today
      paramsIntegrante = {type: 'Actor', nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "20284635486", fecha_de_nacimiento: @fecha, calle: "Santa Fe", altura_calle: "1000", localidad: @principal.localidad, codigo_postal: "1406", tel_celular: "5345345", tel_particular: ''}
      formulario.build_elenco_en_gira
      formulario.elenco_en_gira.saltear_validaciones_de_presencia = true
      formulario.elenco_en_gira.save!
      @integrante_de_elenco_en_gira = formulario.elenco_en_gira.integrantes_de_elenco_en_gira.create!(paramsIntegrante)
      formulario.create_responsable
      @persona_fisica_e = formulario.responsable.build_persona_fisica_e(integrante_de_elenco_en_gira_id: @integrante_de_elenco_en_gira.id)
      @persona_fisica_e.save!
    end

    it {
      Timecop.freeze(fecha_impresion_remito) do
        subject.generar_pdf(formulario)
        File.delete(ruta_archivo_odt) if File.exist?(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
        subject.generar_pdf(formulario)

        reader = PDF::Reader.new(ruta_archivo_pdf)

        @text = nil
        reader.pages.each do |page|
          @text = page.text
        end

        @text.should include("14/04/2014 12:41:32")
        @text.should include("Los Chaqueños")
        @text.should include("Buenos Aires")
        @text.should include("Centro")
        @text.should include("1")
        @text.should include("10/04/2014 22:46:56")
        @text.should include("Pedro")
        @text.should include("Gomez")
        @text.should include("20284635486")
        @text.should include(I18n.l(@fecha, format: :short))

        File.delete(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf)
      end
    }
  end

  describe "generar el remito con formato pdf con responsable persona fisica nueva" do
    before do
      @fecha = Date.today
      paramsPFN = {nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "20284635486", fecha_de_nacimiento: @fecha, calle: "Santa Fe", altura_calle: "1000", localidad: @principal.localidad, codigo_postal: "1406", tel_celular: "5345345", tel_particular: ''}
      formulario.create_responsable
      @persona_fisica_e = formulario.responsable.create_persona_fisica_n(paramsPFN)
    end

    it {
      Timecop.freeze(fecha_impresion_remito) do
        subject.generar_pdf(formulario)
        File.delete(ruta_archivo_odt) if File.exist?(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
        subject.generar_pdf(formulario)

        reader = PDF::Reader.new(ruta_archivo_pdf)

        @text = nil
        reader.pages.each do |page|
          @text = page.text
        end

        @text.should include("14/04/2014 12:41:32")
        @text.should include("Los Chaqueños")
        @text.should include("Buenos Aires")
        @text.should include("Centro")
        @text.should include("1")
        @text.should include("10/04/2014 22:46:56")
        @text.should include("Pedro")
        @text.should include("Gomez")
        @text.should include(I18n.l(@fecha, format: :short))
        @text.should include("20284635486")


        File.delete(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf)
      end
    }
  end

  describe "generar el remito con formato pdf con responsable persona juridica" do
    before do
      @fecha = Date.today
      paramsPJ = {nombre_per_juridica: "Pedro", num_per_juridica: "23", email_entidad: "pedro.gomez@gmail.com", num_cuit: "20284635486", calle: "Santa Fe", altura_calle: "1000", localidad: @principal.localidad, codigo_postal: "1406"}
      formulario.create_responsable
      @persona_juridica = formulario.responsable.create_persona_juridica(paramsPJ)
    end

    it {
      Timecop.freeze(fecha_impresion_remito) do
        subject.generar_pdf(formulario)
        File.delete(ruta_archivo_odt) if File.exist?(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
        subject.generar_pdf(formulario)

        reader = PDF::Reader.new(ruta_archivo_pdf)

        @text = nil
        reader.pages.each do |page|
          @text = page.text
        end

        @text.should include("14/04/2014 12:41:32")
        @text.should include("Los Chaqueños")
        @text.should include("Buenos Aires")
        @text.should include("Centro")
        @text.should include("1")
        @text.should include("10/04/2014 22:46:56")
        @text.should include("Pedro")
        @text.should include("20284635486")


        File.delete(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf)
      end
    }
  end
end
