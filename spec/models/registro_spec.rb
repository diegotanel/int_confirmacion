#encoding: utf-8
require 'spec_helper'

describe Registro do
  before do
		@registro = Registro.new(numero_de_registro: "1234567890", detalle: "Si")
	end

	subject { @registro }

	it { should respond_to(:numero_de_registro) }
  it { should respond_to(:detalle) }

	it {should be_valid}

	describe "validations" do

		before {@registro.detalle = ' '}
		it {should_not be_valid}
	end

  describe "when numero_de_registro is too short" do
    before { @registro.numero_de_registro = 123}
    it { should_not be_valid }
  end

  describe "when numero_de_registro is too long" do
    before { @registro.numero_de_registro = 123456789123}
    it { should_not be_valid }
  end
end
