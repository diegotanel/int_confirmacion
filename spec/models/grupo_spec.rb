#encoding: utf-8
require 'spec_helper'

describe Grupo do
	before do
		@grupo = Grupo.new(detalle: "Grupo")
	end

	subject { @grupo }

	it { should respond_to(:detalle) }

	it {should be_valid}

	describe "validations" do

		before {@grupo.detalle = ' '}
		it {should_not be_valid}
	end
end
