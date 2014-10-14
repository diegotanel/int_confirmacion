require 'spec_helper'

describe DatosGrupo do

	let(:formulario) { FactoryGirl.build(:formulario) }

  before do
    @datos_grupo = formulario.build_datos_grupo(nombre_grupo: "pepito y sus amigos", historia: "asadfadgfadgadgadvasdadv")
  end

  subject { @datos_grupo }

  it { should respond_to(:nombre_grupo) }
  it { should respond_to(:historia) }

  it { 
    formulario.save!
    should be_valid 
  }

  describe "when nombre_grupo is not present" do
    before { @datos_grupo.nombre_grupo = " " }
    it { should_not be_valid }
  end

  describe "when historia is not present" do
    before { @datos_grupo.historia = " " }
    it { should_not be_valid }
  end

  describe "when historia is too long" do
  	before { @datos_grupo.historia = "a" * 201 }
    it { should be_invalid }
  end

  describe "when historia is too long" do
 		before { @datos_grupo.nombre_grupo = "a" * 71 }
    it { should be_invalid }
  end

end
