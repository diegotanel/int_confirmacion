require 'spec_helper'

describe ElencoEnGira do

  let(:formulario) { FactoryGirl.create(:formulario) }
  let(:localidad) { FactoryGirl.create(:localidad) }

  def params
    {type: 'Actor', nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "12345678912", fecha_de_nacimiento: DateTime.now, calle: "Santa Fe", altura_calle: "1000", localidad: localidad, codigo_postal: "1406", tel_celular: "5345345", tel_particular: ''}
  end

  before {
    @elenco = formulario.create_elenco_en_gira()
    @integrante = @elenco.integrantes_de_elenco_en_gira.create(params)
  }

  subject { @elenco }

  it { should be_valid }

  it "verificar que un integrante es actor" do
    subject.es_interprete?.should be_true
  end

  it "verificar que un integrante no es actor" do
    @integrante.type = "Director"
    subject.es_interprete?.should be_false
  end

  it "verificar si hay varios integrantes y uno es actor" do
    @integrante2 = @elenco.integrantes_de_elenco_en_gira.create(params.merge(type: "Director"))
    subject.es_interprete?.should be_true
  end

  it "Validar que por lo menos se agregue un actor" do
    subject.integrantes_de_elenco_en_gira.destroy(@integrante)
    subject.should_not be_valid
    @elenco2 = formulario.create_elenco_en_gira()
    @elenco2.should_not be_valid
  end
end
