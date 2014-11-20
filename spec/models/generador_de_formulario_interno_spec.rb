#encoding: utf-8
require 'spec_helper'

describe GeneradorDeFormularioInterno do
  let(:fecha_impresion_remito) { Time.zone.local(2014, 4, 14, 12, 41, 32) }
  let(:fecha_de_creacion_del_tramite) { Time.zone.local(2013, 9, 10, 22, 41) }
  let(:formulario) { FactoryGirl.create(:formulario, :created_at => fecha_de_creacion_del_tramite) }
  let(:ruta_archivo_odt) { Rails.root.join("public/forms_fomento/formulario_interno_convocatoria_2015_20140414124132.odt") }
  let(:ruta_archivo_pdf) { Rails.root.join("public/forms_fomento/formulario_interno_convocatoria_2015_20140414124132.pdf") }


  before do
    Timecop.freeze(fecha_impresion_remito) do
      @generador_de_formulario_interno = GeneradorDeFormularioInterno.new
    end
    @gen_esp1 = GenEsp.create!(detalle: "g")
    @publ_exp = PublExp.create!(detalle: "p")
    @publ_edad = PublEdad.create!(detalle: "e")
    @formato = Formato.create!(detalle: "f")
    @principal = FactoryGirl.create(:principal, :formulario => formulario, nombre: "Los Chaqueños")
    @datos_esp = formulario.create_datos_esp(:gen_esp_ids => @gen_esp1.id, :publ_edad_ids => @publ_edad.id, :publ_exp_ids => @publ_exp.id, :formato_ids => @formato.id, fecha_de_estreno: DateTime.now, nombre_autor: "asdfa", nacionalidad_autor: "fasd", duracion_espectaculo: "1234", sinopsis_obra: "adfas")
    formulario.datos_esp.saltear_validaciones_de_presencia = true
    formulario.datos_esp.save!
    formulario.build_elenco_en_gira
    formulario.elenco_en_gira.saltear_validaciones_de_presencia = true
    formulario.elenco_en_gira.save!
    @fecha_de_estreno = DateTime.now
    @fecha = Date.today
    paramsIntegrante = {type: 'Actor', nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "20284635486", fecha_de_nacimiento: @fecha, calle: "Santa Fe", altura_calle: "1000", localidad: @principal.localidad, codigo_postal: "1406", tel_celular: "5345345", tel_particular: "1115345"}
    @integrante_de_elenco_en_gira = formulario.elenco_en_gira.integrantes_de_elenco_en_gira.create!(paramsIntegrante)

  end

  subject { @generador_de_formulario_interno }

  it { should respond_to(:generar_pdf) }

  describe "verificar si se genera el archivo odt" do
    before do
      formulario.create_responsable
      @persona_fisica_e = formulario.responsable.build_persona_fisica_e(integrante_de_elenco_en_gira_id: @integrante_de_elenco_en_gira.id)
      @persona_fisica_e.save!
      formulario.responsable.save!
    end

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
    before do
      formulario.create_responsable
      @persona_fisica_e = formulario.responsable.build_persona_fisica_e(integrante_de_elenco_en_gira_id: @integrante_de_elenco_en_gira.id)
      @persona_fisica_e.save!
      formulario.responsable.save!
    end

    it {
      Timecop.freeze(fecha_impresion_remito) do
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
        datos = subject.generar_pdf(formulario)
        pdf = File.read(ruta_archivo_pdf)
        File.delete(ruta_archivo_pdf)
      end
    }
  end

  describe "generar el formulario interno con formato pdf con responsable persona fisica existente" do
    before do
      formulario.create_responsable
      @persona_fisica_e = formulario.responsable.build_persona_fisica_e(integrante_de_elenco_en_gira_id: @integrante_de_elenco_en_gira.id)
      @persona_fisica_e.save!
      formulario.responsable.save!
    end

    it {
      Timecop.freeze(fecha_impresion_remito) do
        File.delete(ruta_archivo_odt) if File.exist?(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
        subject.generar_pdf(formulario)

        reader = PDF::Reader.new(ruta_archivo_pdf)

        @text = ""
        reader.pages.each do |page|
          @text = @text + page.text
        end

        @text.should include("Los Chaqueños")
        @text.should include("asdfa")
        @text.should include("Buenos Aires")
        #@text.should include(I18n.l(@fecha_de_estreno))
        @text.should include("Gomez")
        @text.should include("Pedro")
        @text.should include("20284635486")
        #@text.should include(I18n.l(@fecha))
        @text.should include("Santa Fe")
        @text.should include("1000")
        @text.should include("Buenos Aires")
        @text.should include("Capital Federal")
        @text.should include("1406")
        @text.should include("5345345")
        @text.should include("1115345")
        @text.should include("pedro.gomez@gmail.com")

       File.delete(ruta_archivo_odt)
       File.delete(ruta_archivo_pdf)
      end
    }
  end

  describe "generar el formulario interno con formato pdf con responsable persona fisica nueva" do
    before do
      @fecha = Date.today
      paramsPFN = {nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "20284635486", fecha_de_nacimiento: @fecha, calle: "Santa Fe", altura_calle: "1000", localidad: @principal.localidad, codigo_postal: "1406", tel_celular: "5345345", tel_particular: "1115345"}
      formulario.create_responsable
      @persona_fisica_e = formulario.responsable.create_persona_fisica_n(paramsPFN)
    end

    it {
      Timecop.freeze(fecha_impresion_remito) do
        File.delete(ruta_archivo_odt) if File.exist?(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
        subject.generar_pdf(formulario)

        reader = PDF::Reader.new(ruta_archivo_pdf)

        @text = ""
        reader.pages.each do |page|
          @text = @text + page.text
        end

        @text.should include("Los Chaqueños")
        @text.should include("asdfa")
        @text.should include("Buenos Aires")
        #@text.should include(I18n.l(@fecha_de_estreno))
        @text.should include("Gomez")
        @text.should include("Pedro")
        @text.should include("20284635486")
        #@text.should include(I18n.l(@fecha))
        @text.should include("Santa Fe")
        @text.should include("1000")
        @text.should include("Buenos Aires")
        @text.should include("Capital Federal")
        @text.should include("1406")
        @text.should include("5345345")
        @text.should include("1115345")
        @text.should include("pedro.gomez@gmail.com")


        File.delete(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf)
      end
    }
  end

  describe "generar el formulario interno con formato pdf con responsable persona juridica" do
    before do
      @fecha = Date.today
      paramsPJ = {nombre_per_juridica: "Pedro", num_per_juridica: "23", email_entidad: "pedro.gomez@gmail.com", num_cuit: "20284635486", calle: "Santa Fe", altura_calle: "1000", localidad: @principal.localidad, codigo_postal: "1406", tel_entidad: "5345345"}
      formulario.create_responsable
      @persona_juridica = formulario.responsable.create_persona_juridica(paramsPJ)
      paramsCD = { cargo: "socio", apellido: "Santa Cruz", nombre: "Gonzalo", cuil_cuit: "20288034363", fecha_de_nacimiento: @fecha, email: "gonzalo.santacruz@gmail.com", calle: "Corrientes", altura_calle: "1541", localidad: @principal.localidad, codigo_postal: "9415", tel_celular: "6261155", tel_particular: "4151155"}
      @persona_juridica.integrantes_comision_directiva.create!(paramsCD)
    end

    it {
      Timecop.freeze(fecha_impresion_remito) do
        File.delete(ruta_archivo_odt) if File.exist?(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf) if File.exist?(ruta_archivo_pdf)
        subject.generar_pdf(formulario)

        reader = PDF::Reader.new(ruta_archivo_pdf)

        @text = ""
        reader.pages.each do |page|
          @text = @text + page.text
        end
        @text.should include("Los Chaqueños")
        @text.should include("asdfa")
        @text.should include("Buenos Aires")
        #@text.should include(I18n.l(@fecha_de_estreno))
        @text.should include("Pedro")
        @text.should include("23")
        @text.should include("Buenos Aires")
        @text.should include("Capital Federal")
        @text.should include("5345345")
        @text.should include("1406")
        @text.should include("Santa Fe")
        @text.should include("1000")
        #@text.should include(I18n.l(@fecha))
        @text.should include("20284635486")
        @text.should include("pedro.gomez@gmail.com")
        @text.should include("socio")
        @text.should include("Santa Cruz")
        @text.should include("Gonzalo")
        @text.should include("20288034363")
        #@text.should include("gonzalo.santacruz@gmail.com")
        @text.should include("Corrientes")
        @text.should include("1541")
        @text.should include("9415")
        @text.should include("6261155")
        @text.should include("4151155")

        File.delete(ruta_archivo_odt)
        File.delete(ruta_archivo_pdf)
      end
    }
  end
end
