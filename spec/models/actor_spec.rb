require 'spec_helper'

describe Actor do

	date = Date.new(2007, 11, 10)
	let(:elencos_en_gira) { FactoryGirl.create(:elencos_en_gira) }

	before do
		@actor = Actor.new(nombre_actor: "Pedro", apellido_actor: "Gomez", email: "pedro.gomez@gmail.com", num_de_cuil_cuit: "12345678912", fecha_de_nacimiento: date, calle: "Santa Fe", altura_calle: "1000", 
											actor_provincia: "Buenos Aires", actor_localidad: "Capital Federal", codigo_postal: "1406", elencos_en_gira_id: elencos_en_gira.id)
	end

	subject { @actor }

  it { should respond_to(:nombre_actor) }
  it { should respond_to(:apellido_actor) }
  it { should respond_to(:email) }
  it { should respond_to(:num_de_cuil_cuit) }
  it { should respond_to(:fecha_de_nacimiento) }
  it { should respond_to(:calle) }
  it { should respond_to(:altura_calle) }
  it { should respond_to(:actor_provincia) }
  it { should respond_to(:actor_localidad) }
  it { should respond_to(:codigo_postal) }
  it { should respond_to(:elencos_en_gira_id) }


  it { should be_valid }

  describe "When nombre_actor is not present" do

  	before {@actor.nombre_actor = ' '}
  	it {should_not be_valid}
  end

  describe "when nombre_actor is too long" do
    before { @actor.nombre_actor = "a" * 71 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @actor.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @actor.email = invalid_address
        expect(@actor).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @actor.email = valid_address
        expect(@actor).to be_valid
      end
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @actor.email = mixed_case_email
      @actor.save
      expect(@actor.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "When num_de_cuil_cuit is not present" do
  	before {@actor.num_de_cuil_cuit = ' '}
  	it {should_not be_valid}
  end

  describe "when fecha_de_nacimiento is not present" do
    before { @actor.fecha_de_nacimiento = " " }
    it { should_not be_valid }
  end

  describe "when calle is not present" do
    before { @actor.calle = " " }
    it { should_not be_valid }
  end

  describe "when altura_calle is not present" do
    before { @actor.altura_calle = " " }
    it { should_not be_valid }
  end

  describe "when actor_provincia is not present" do
    before { @actor.actor_provincia = " " }
    it { should_not be_valid }
  end

  describe "when actor_localidad is not present" do
    before { @actor.actor_provincia = " " }
    it { should_not be_valid }
  end

  describe "when codigo_postal is not present" do
    before { @actor.codigo_postal = " " }
    it { should_not be_valid }
  end

  describe "when elencos_en_gira_id is not present" do
    before { @actor = Actor.new(nombre_actor: "Pedro", apellido_actor: "Gomez", email: "pedro.gomez@gmail.com", num_de_cuil_cuit: "12345678912", fecha_de_nacimiento: date, calle: "Santa Fe", altura_calle: "1000", 
											actor_provincia: "Buenos Aires", actor_localidad: "Capital Federal", codigo_postal: "1406", elencos_en_gira_id: nil) }
    it { should_not be_valid }
  end
end
