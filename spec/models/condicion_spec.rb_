#encoding: utf-8
require 'spec_helper'

describe Condicion do
	before do
		@condicion = Condicion.new(codigo: "ic2014", detalle: "Espectáculo Integrante Catálogo 2014")
	end

	subject { @condicion }

	it { should respond_to(:codigo) }
	it { should respond_to(:detalle) }

	it {should be_valid}

	describe "validations" do
		describe "detalle" do
			before {@condicion.detalle = ' '}
			it {should_not be_valid}
		end

		describe "código" do
			before {@condicion.codigo = ' '}
			it {should_not be_valid}
		end
	end

	describe "relacion con principal" do
		it { should respond_to(:principals) }

		let(:principal) { FactoryGirl.build(:principal) }

		it  {
			principal.condiciones << @condicion
			principal.save!
			@condicion.principals.first.condiciones.first.id.should == @condicion.id
		}
	end
end
