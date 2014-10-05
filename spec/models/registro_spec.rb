#encoding: utf-8
require 'spec_helper'

describe Registro do
  before do
		@registro = Registro.new(numero: "00323", detalle: "Si")
	end

	subject { @registro }

	it { should respond_to(:numero) }
  it { should respond_to(:detalle) }

	it {should be_valid}

	describe "validations" do

		before {@registro.detalle = ' '}
		it {should_not be_valid}
	end

	describe "when detalle is too long" do
    	before { @registro.numero = "a" * 11 }
    	it { should_not be_valid }
  	end
end
