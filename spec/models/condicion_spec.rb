require 'spec_helper'

describe Condicion do
  before do
		@condicion = Condicion.new(detalle: "A")
	end

	subject { @condicion }

	it { should respond_to(:detalle) }

	it {should be_valid}

	describe "validations" do

		before {@condicion.detalle = ' '}
		it {should_not be_valid}
	end
end
