#encoding: utf-8
require 'spec_helper'

describe Principal do

  #let(:provincia) { FactoryGirl.build(:provincia) }
  let(:localidad) { FactoryGirl.build(:localidad) }
  let(:grupo) { FactoryGirl.build(:grupo) }
  let(:formulario) { FactoryGirl.build(:formulario) }

  before do
    @principal = formulario.build_principal(provincia: localidad.provincia, localidad: localidad, grupo: grupo,
                                            nombre: "Los gauchitos")
  end

  subject { @principal }

  it { should respond_to(:nombre) }
  it { should respond_to(:provincia) }
  it { should respond_to(:provincia_id) }
  it { should respond_to(:localidad) }
  it { should respond_to(:grupo) }
  it { 
    formulario.save!
    should be_valid 
  }

  describe "validations" do

    before {@principal.nombre = ' '}
    it {should_not be_valid}

    it "should have the right associated provincia" do
      @principal.localidad.provincia_id.should == provincia.id
    end

    it "should have the right associated localidad" do
      @principal.localidad_id.should == localidad.id
    end

    it "should have the right associated grupo" do
      @principal.grupo_id.should == grupo.id
    end


    describe "when provincia_id is not present" do
      before do
        @principal.provincia = nil
      end
      it { should_not be_valid }
    end

    describe "when localidad_id is not present" do
      before do
        @principal.localidad = nil
      end
      it { should_not be_valid }
    end

    describe "when grupo_id is not present" do
      before do
        @principal.grupo = nil
      end
      it { should_not be_valid }
    end

    describe "when nombre is not present" do
      before do
        @principal = Principal.new(formulario_id: 1, provincia: localidad.provincia, localidad: localidad, grupo: grupo,
                                   nombre: " ")
      end
      it { should_not be_valid }
    end

    describe "when nombre is too long" do
      before { @principal.nombre = "a" * 71 }
      it { should_not be_valid }
    end
  end

end
