require 'spec_helper'

describe Region do
	
	before do
		@region = Region.new(detalle: "Cuyo")
	end

	subject { @region }

	it { should respond_to(:detalle) }

	it {should be_valid}

	describe "validations" do

		before {@region.detalle = ' '}
		it {should_not be_valid}

		describe "when detalle is too long" do
    	before { @region.detalle = "a" * 70 }
    	it { should_not be_valid }
  	end
	end
end
