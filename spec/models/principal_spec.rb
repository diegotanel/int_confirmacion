require 'spec_helper'

describe Principal do
  before do
		@region = Region.new(detalle: "Cuyo")
		@provincia = Provincia.new(region_id: @region.id, detalle: "Buenos Aires")
		@localidad = Localidad.new(detalle: "Capital Federal")
		@grupo = Grupo.new(detalle: "Grupo")
		@condicion = condicion.new(detalle: "A")
		@principal = Principal.new(provincia_id: @provincia.id, localidad_id: @localidad.id, grupo_id: @grupo.id, 
		condicion_id: @condicion.id, detalle: "Principal", nombre: "Los gauchitos")
	end

	subject { @principal }

	it { should respond_to(:detalle) }
	it { should respond_to(:nombre) }
	it { should respond_to(:provincia) }
	it { should respond_to(:localidad) }
	it { should respond_to(:grupo) }
	it { should respond_to(:condicion) }

	describe "validations" do

		before {@principal.detalle = ' '}
		it {should_not be_valid}

		before {@principal.nombre = ' '}
		it {should_not be_valid}

		it "should have the right associated provincia" do
			@Principal.provincia_id.should == @provincia.id
			@Principal.provincia.should == @provincia
		end

		it "should have the right associated localidad" do
			@Principal.localidad_id.should == @localidad.id
			@Principal.localidad.should == @localidad
		end

		it "should have the right associated grupo" do
			@Principal.grupo_id.should == @grupo.id
			@Principal.grupo.should == @grupo
		end

		it "should have the right associated condicion" do
			@Provincia.condicion_id.should == @condicion.id
			@Provincia.condicion.should == @condicion
		end

		describe "when provincia_id is not present" do
    	before do
      	@principal = Principal.new(provincia_id: " ", localidad_id: @localidad.id, grupo_id: @grupo.id, 
				condicion_id: @condicion.id, detalle: "Principal", nombre: "Los gauchitos")
    	end
    	it { should_not be_valid }
  	end

  	describe "when localidad_id is not present" do
    	before do
      	@principal = Principal.new(provincia_id: @provincia.id, localidad_id: " ", grupo_id: @grupo.id, 
				condicion_id: @condicion.id, detalle: "Principal", nombre: "Los gauchitos")
    	end
    	it { should_not be_valid }
  	end

  	describe "when grupo_id is not present" do
    	before do
      	@principal = Principal.new(provincia_id: @provincia.id, localidad_id: @localidad.id, grupo_id: " ", 
				condicion_id: @condicion.id, detalle: "Principal", nombre: "Los gauchitos")
    	end
    	it { should_not be_valid }
  	end

  	describe "when condicion_id is not present" do
    	before do
      	@principal = Principal.new(provincia_id: @provincia.id, localidad_id: @localidad.id, grupo_id: @grupo.id, 
				condicion_id: " ", detalle: "Principal", nombre: "Los gauchitos")
    	end
    	it { should_not be_valid }
  	end

  	describe "when detalle is not present" do
    	before do
      	@principal = Principal.new(provincia_id: @provincia.id, localidad_id: @localidad.id, grupo_id: @grupo.id, 
				condicion_id: @condicion.id, detalle: " ", nombre: "Los gauchitos")
    	end
    	it { should_not be_valid }
  	end

  	describe "when nombre is not present" do
    	before do
      	@principal = Principal.new(provincia_id: @provincia.id, localidad_id: @localidad.id, grupo_id: @grupo.id, 
				condicion_id: @condicion.id, detalle: "Principal", nombre: " ")
    	end
    	it { should_not be_valid }
  	end

  	describe "when nombre is too long" do
    	before { @principal.nombre = "a" * 70 }
    	it { should_not be_valid }
  	end
  end
end
