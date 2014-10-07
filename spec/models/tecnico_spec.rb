require 'spec_helper'

describe Tecnico do
	date = Date.new(2007, 11, 10)
  let(:elencos_en_gira) { FactoryGirl.create(:elencos_en_gira) }

	before do
		@tecnico = Tecnico.new(nombre_tecnico: "Agustin", apellido_tecnico: "Gomez", email: "agustin.gomez@gmail.com", num_de_cuil_cuit: "12345678912", fecha_de_nacimiento: date, calle: "Santa Fe", altura_calle: "3000", 
											tecnico_provincia: "Buenos Aires", tecnico_localidad: "Capital Federal", codigo_postal: "1406", elencos_en_gira_id: elencos_en_gira.id)
	end

	subject { @tecnico }

  it { should respond_to(:nombre_tecnico) }
  it { should respond_to(:apellido_tecnico) }
  it { should respond_to(:email) }
  it { should respond_to(:num_de_cuil_cuit) }
  it { should respond_to(:fecha_de_nacimiento) }
  it { should respond_to(:calle) }
  it { should respond_to(:altura_calle) }
  it { should respond_to(:tecnico_provincia) }
  it { should respond_to(:tecnico_localidad) }
  it { should respond_to(:codigo_postal) }
  it { should respond_to(:elencos_en_gira_id) }


  it { should be_valid }

  describe "When nombre_tecnico is not present" do

  	before {@tecnico.nombre_tecnico = ' '}
  	it {should_not be_valid}
  end

  describe "when nombre_tecnico is too long" do
    before { @tecnico.nombre_tecnico = "a" * 71 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @tecnico.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @tecnico.email = invalid_address
        expect(@tecnico).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @tecnico.email = valid_address
        expect(@tecnico).to be_valid
      end
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @tecnico.email = mixed_case_email
      @tecnico.save
      expect(@tecnico.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "When num_de_cuil_cuit is not present" do
  	before {@tecnico.num_de_cuil_cuit = ' '}
  	it {should_not be_valid}
  end

  describe "when fecha_de_nacimiento is not present" do
    before { @tecnico.fecha_de_nacimiento = " " }
    it { should_not be_valid }
  end

  describe "when calle is not present" do
    before { @tecnico.calle = " " }
    it { should_not be_valid }
  end

  describe "when altura_calle is not present" do
    before { @tecnico.altura_calle = " " }
    it { should_not be_valid }
  end

  describe "when tecnico_provincia is not present" do
    before { @tecnico.tecnico_provincia = " " }
    it { should_not be_valid }
  end

  describe "when tecnico_localidad is not present" do
    before { @tecnico.tecnico_localidad = " " }
    it { should_not be_valid }
  end

  describe "when codigo_postal is not present" do
    before { @tecnico.codigo_postal = " " }
    it { should_not be_valid }
  end

  describe "when elencos_en_gira_id is not present" do
    before { 
    	@tecnico = Tecnico.new(nombre_tecnico: "Agustin", apellido_tecnico: "Gomez", email: "agustin.gomez@gmail.com", num_de_cuil_cuit: "12345678912", fecha_de_nacimiento: date, calle: "Santa Fe", altura_calle: "3000", 
											tecnico_provincia: "Buenos Aires", tecnico_localidad: "Capital Federal", codigo_postal: "1406", elencos_en_gira_id: nil)
 
    }
    it { should_not be_valid }
  end
end

