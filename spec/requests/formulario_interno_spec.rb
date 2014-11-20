#encoding: utf-8
require 'spec_helper'

describe "Formulario interno" do

  subject { page }

  describe "Imprimir formulario" do
    let(:fecha_impresion_remito) { Time.zone.local(2013, 9, 15, 22, 41) }
    let(:fecha_de_creacion_del_tramite) { Time.zone.local(2013, 9, 10, 22, 41) }
    let(:user) {FactoryGirl.create(:user, email: "dtanel@gmail.com")}
    let(:formulario) { FactoryGirl.create(:formulario, :created_at => fecha_de_creacion_del_tramite, user: user, :estado => 1) }

    let(:ruta_archivo_odt) { Rails.root.join("public/forms_fomento/formulario_interno_convocatoria_2015_20130915224100.odt") }
    let(:ruta_archivo_pdf) { Rails.root.join("public/forms_fomento/formulario_interno_convocatoria_2015_20130915224100.pdf") }

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

      formulario.create_responsable
      @persona_fisica_e = formulario.responsable.build_persona_fisica_e(integrante_de_elenco_en_gira_id: @integrante_de_elenco_en_gira.id)
      @persona_fisica_e.save!
      formulario.responsable.save!

      formulario.save!
      sign_in formulario.user
      visit ver_formularios_path
    end

    it { should have_link('Imprimir formulario interno', href: imprimir_interno_formulario_path(formulario)) }

    it "descargar el pdf" do
      Timecop.freeze(fecha_impresion_remito) do
        click_link "Imprimir formulario interno"
        result = page.response_headers['Content-Type'].should == "application/pdf"
        if result
          nombre_del_archivo = "attachment; filename=\"formulario_interno_convocatoria_2015_20130915224100.pdf\""
          result = page.response_headers['Content-Disposition'].should == nombre_del_archivo
        end
      end
    end
  end
end
