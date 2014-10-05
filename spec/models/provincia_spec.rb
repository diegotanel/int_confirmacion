#encoding: utf-8
require 'spec_helper'

describe Provincia do
  
  before do
		@region = Region.create(detalle: "Cuyo")
		@provincia = @region.provincias.build(detalle: "Buenos Aires")
	end

	subject { @provincia }

	it { should respond_to(:detalle) }
	it { should respond_to(:region) }

	it {should be_valid}

	describe "validations" do

		before {@provincia.detalle = " "}
		it {should_not be_valid}

		it "should have the right associated region" do
			@provincia.region_id.should == @region.id
		end

		describe "when region_id is not present" do
    	before do
      	@provincia = Provincia.new(region_id: " ", detalle: "Buenos Aires")
    	end
    	it { should_not be_valid }
  	end

  	describe "when detalle is not present" do
    	before do
      	@provincia = Provincia.new(region_id: @region.id, detalle: " ")
      end
    	it { should_not be_valid }
  	end

  	describe "when detalle is too long" do
    	before { @provincia.detalle = "a" * 71 }
    	it { should_not be_valid }
  	end
	end
end
