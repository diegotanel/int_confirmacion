#encoding: utf-8
require 'spec_helper'

describe Localidad do

  let(:provincia) { FactoryGirl.create(:provincia) }
  before do
    @localidad = provincia.localidades.build(codigo: "bb", detalle: "Buenos Aires")
  end

  subject { @localidad }

  it { should respond_to(:codigo) }
  it { should respond_to(:detalle) }

  it {should be_valid}

  describe "validations" do

    it "should have the right associated provincia" do
      @localidad.provincia_id.should == provincia.id
    end

    describe "when provincia_id is not present" do
      before do
        @localidad = Localidad.new(provincia_id: " ", detalle: "CABA")
      end
      it { should_not be_valid }
    end

    describe "cuando detalle es nulo" do
      before {@localidad.detalle = ' '}
      it {should_not be_valid}
    end

    describe "cuando codigo es nulo" do
      before {@localidad.codigo = " "}
      it {should_not be_valid}
    end

    describe "when detalle is too long" do
      before { @localidad.detalle = "a" * 71 }
      it { should_not be_valid }
    end
  end
end
