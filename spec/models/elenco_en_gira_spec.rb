#encoding: utf-8
require 'spec_helper'

describe ElencoEnGira do

  let(:formulario) { FactoryGirl.create(:formulario) }
  let(:localidad) { FactoryGirl.create(:localidad) }

  def params
    {type: 'Actor', nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "12345678912", fecha_de_nacimiento: DateTime.now, calle: "Santa Fe", altura_calle: "1000", localidad: localidad, codigo_postal: "1406", tel_celular: "5345345", tel_particular: ''}
  end

  before {
    @elenco = formulario.build_elenco_en_gira()
    @elenco.saltear_validaciones_de_presencia = true
    @elenco.save!
    @integrante = @elenco.integrantes_de_elenco_en_gira.create(params)
  }

  subject { @elenco }

  it { should be_valid }

  describe "intérprete" do
    it "verificar que un integrante es intérprete" do
      subject.minimo_un_interprete.should be_true
    end

    it "verificar que un integrante no es intérprete" do
      @integrante.update_attributes(type: "Director")
      subject.minimo_un_interprete.should be_false
    end

    it "verificar si hay varios integrantes y uno es intérprete" do
      @integrante2 = @elenco.integrantes_de_elenco_en_gira.create(params.merge(type: "Director"))
      subject.minimo_un_interprete.should be_true
    end

    it "si hay dos intérprete debe retornar verdadero" do
      @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Actor', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
      subject.minimo_un_interprete.should be_true
    end

    it "validar que por lo menos se agregue un intérprete" do
      subject.integrantes_de_elenco_en_gira.destroy(@integrante)
      @elenco.saltear_validaciones_de_presencia = false
      subject.should_not be_valid
      @elenco2 = formulario.create_elenco_en_gira()
      @elenco2.should_not be_valid
      subject.errors.full_messages.should include("Como mínimo se debe adicionar un intérprete en elenco en gira")
    end
  end

  describe "director" do

    describe "verdadero" do
      it "si no hay integrantes" do
        subject.integrantes_de_elenco_en_gira.destroy(@integrante)
        subject.integrantes_de_elenco_en_gira.count.should == 0
        subject.maximo_tres_directores.should be_true
      end

      it "si no hay directores" do
        subject.integrantes_de_elenco_en_gira.count.should == 1
        subject.maximo_tres_directores.should be_true
      end

      it "hasta tres directores" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.integrantes_de_elenco_en_gira.count.should == 3
        subject.maximo_tres_directores.should be_true
      end

      it "hasta tres directores y otros integrantes" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante4 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Actor', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.integrantes_de_elenco_en_gira.count.should == 4
        subject.maximo_tres_directores.should be_true
      end
    end

    describe "false" do
      it "si hay mas de 3 directores" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante4 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante5 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.integrantes_de_elenco_en_gira.count.should == 5
        subject.maximo_tres_directores.should be_false
      end

      it "validar que muestre el error" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante4 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante5 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.should_not be_valid
        subject.errors.full_messages.should include("No puede haber más de tres directores")
      end
    end
  end

  describe "técnico" do

    describe "verdadero" do
      it "si no hay integrantes" do
        subject.integrantes_de_elenco_en_gira.destroy(@integrante)
        subject.integrantes_de_elenco_en_gira.count.should == 0
        subject.maximo_dos_tecnicos.should be_true
      end

      it "si no hay técnicos" do
        subject.integrantes_de_elenco_en_gira.count.should == 1
        subject.maximo_dos_tecnicos.should be_true
      end

      it "hasta tres técnicos" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.integrantes_de_elenco_en_gira.count.should == 3
        subject.maximo_dos_tecnicos.should be_true
      end

      it "hasta dos técnicos y otros integrantes" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante4 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Actor', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.integrantes_de_elenco_en_gira.count.should == 4
        subject.maximo_dos_tecnicos.should be_true
      end
    end

    describe "false" do
      it "si hay mas de dos técnicos" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante4 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante5 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.integrantes_de_elenco_en_gira.count.should == 5
        subject.maximo_dos_tecnicos.should be_false
      end

      it "validar que muestre el error" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante4 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante5 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.should_not be_valid
        subject.errors.full_messages.should include("No puede haber más de dos técnicos")
      end
    end
  end

  describe "como máximo la cantidad de tres, entre directores y técnicos" do
    describe "verdadero" do
      it "si no hay integrantes" do
        subject.integrantes_de_elenco_en_gira.destroy(@integrante)
        subject.integrantes_de_elenco_en_gira.count.should == 0
        subject.combinacion_director_tecnico.should be_true
      end

      it "si no hay técnicos o directores" do
        subject.integrantes_de_elenco_en_gira.count.should == 1
        subject.combinacion_director_tecnico.should be_true
      end

      it "hasta 3" do
        subject.integrantes_de_elenco_en_gira.destroy(@integrante)
        @integrante1 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.integrantes_de_elenco_en_gira.count.should == 3
        subject.combinacion_director_tecnico.should be_true
      end
    end

    describe "false" do
      it "si hay mas de dos técnicos y un director" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante4 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante5 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.integrantes_de_elenco_en_gira.count.should == 5
        subject.combinacion_director_tecnico.should be_false
      end

      it "validar que muestre el error" do
        @integrante2 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante3 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Tecnico', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante4 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        @integrante5 = @elenco.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "45324567893"))
        subject.should_not be_valid
        subject.errors.full_messages.should include("Como máximo la cantidad de tres, entre directores y técnicos")
      end
    end

  end
end
