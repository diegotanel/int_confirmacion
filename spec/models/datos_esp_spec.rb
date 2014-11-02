#encoding: utf-8
require 'spec_helper'

describe DatosEsp do

  let(:formulario) { FactoryGirl.create(:formulario) }

  before do
    @datos_esp = DatosEsp.new(formulario: formulario, fecha_de_estreno: DateTime.now, nombre_autor: "asdfa", nacionalidad_autor: "fasd", duracion_espectaculo: "1234", sinopsis_obra: "adfas")
  end

  subject { @datos_esp }

  it { should be_valid }

  describe "Validar fecha" do
    it "no puede ser posterior a la fecha de inicio del tramite" do
      datos_esp
    end
  end
end
