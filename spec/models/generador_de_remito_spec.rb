#encoding: utf-8
require 'spec_helper'

describe GeneradorDeRemito do
  let(:fecha_impresion_remito) { Time.zone.local(2014, 4, 14, 12, 41, 32) }
  let(:fecha_de_creacion_del_tramite) { Time.zone.local(2014, 4, 10, 22, 46, 56) }
  let(:formulario) { FactoryGirl.create(:formulario, :created_at => fecha_de_creacion_del_tramite) }


  before do
    @generador_de_remito = GeneradorDeRemito.new
  end

  subject { @generador_de_remito }

  it { should respond_to(:obtener_datos_para_remito) }
  it { should respond_to(:generar_pdf) }

  it { should be_valid }

  describe "obtener datos para remito" do

    it {
      FactoryGirl.create(:principal, :formulario => formulario, nombre: "Los Chaqueños")
      Timecop.freeze(fecha_impresion_remito) do
        datos = subject.obtener_datos_para_remito(formulario)
        datos.fecha_de_impresion_del_remito.should == "14/04/2014 12:41:32"
        datos.nombre_del_espectaculo.should == "Los Chaqueños"
        datos.provincia.should == "Buenos Aires"
        datos.region.should == "Centro"
        datos.numero_de_tramite.should == "1"
        datos.fecha_de_tramite.should == "10/04/2014 22:46:56"
        datos.datos_del_responsable.should == "fruta"
      end
    }
  end

  describe "when user_id is not present" do
    before { @formulario.user_id = nil }
    it { should_not be_valid }
  end
end
