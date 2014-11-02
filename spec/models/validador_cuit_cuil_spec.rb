#encoding: utf-8
require 'spec_helper'

describe ValidadorCuitCuil do

  before do
    @validador = ValidadorCuitCuil.new
  end

  subject { @validador}

  it { should respond_to(:validardigitoverificador) }

  describe "validar" do
    it "exitoso" do
      @validador.validardigitoverificador("20284635486").should be_true
      @validador.validardigitoverificador("27127024125").should be_true
      @validador.validardigitoverificador("20108332507").should be_true
      @validador.validardigitoverificador("30609620729").should be_true

    end

    it "fallido" do
      @validador.validardigitoverificador("90284635486").should be_false
    end
  end
end
