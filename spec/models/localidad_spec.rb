require 'spec_helper'

describe Localidad do

	before do
		@localidad = Localidad.new(detalle: "Buenos Aires")
	end

	subject { @localidad }

	it { should respond_to(:detalle) }

	it {should be_valid}

	describe "validations" do

		before {@localidad.detalle = ' '}
		it {should_not be_valid}

		describe "when detalle is too long" do
    	before { @localidad.detalle = "a" * 70 }
    	it { should_not be_valid }
  	end
	end
end

