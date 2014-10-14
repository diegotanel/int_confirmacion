require 'spec_helper'

describe IntegranteDeElencoEnGira do

  date = Date.new(2007, 11, 10)
  let(:elenco_en_gira) { FactoryGirl.create(:elenco_en_gira) }
  let(:provincia) { FactoryGirl.create(:provincia) }
  let(:localidad) { FactoryGirl.create(:localidad) }

  describe "fallido" do
    describe "siempre debe guardarse con una instancia de una clase hijo" do
      before {
        @integrante_de_elenco_en_gira = elenco_en_gira.integrantes_de_elenco_en_gira.build(nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez1@gmail.com", cuil_cuit: "12345678912", fecha_de_nacimiento: date, calle: "Santa Fe", altura_calle: "1000", provincia: provincia, localidad: localidad, codigo_postal: "1406")
      }
      it {
        expect { @integrante_de_elenco_en_gira.save! }.to raise_error(ActiveRecord::StatementInvalid)
      }
    end
  end

  before do
    @integrante_de_elenco_en_gira = elenco_en_gira.integrantes_de_elenco_en_gira.create(type: 'Actor',nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "12345678912", fecha_de_nacimiento: date, calle: "Santa Fe", altura_calle: "1000", provincia: provincia, localidad: localidad, codigo_postal: "1406")
  end

  subject { @integrante_de_elenco_en_gira }

  it { should respond_to(:nombre) }
  it { should respond_to(:apellido) }
  it { should respond_to(:email) }
  it { should respond_to(:cuil_cuit) }
  it { should respond_to(:fecha_de_nacimiento) }
  it { should respond_to(:calle) }
  it { should respond_to(:altura_calle) }
  it { should respond_to(:provincia) }
  it { should respond_to(:localidad) }
  it { should respond_to(:codigo_postal) }
  it { should respond_to(:email) }
  it { should respond_to(:elenco_en_gira_id) }
  it { should respond_to(:type) }
  it { should be_valid }


  describe "When nombre is not present" do
    before {@integrante_de_elenco_en_gira.nombre = ' '}
    it {should_not be_valid}
  end

  describe "when nombre is too long" do
    before { @integrante_de_elenco_en_gira.nombre = "a" * 71 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @integrante_de_elenco_en_gira.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @integrante_de_elenco_en_gira.email = invalid_address
        expect(@integrante_de_elenco_en_gira).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @integrante_de_elenco_en_gira.email = valid_address
        expect(@integrante_de_elenco_en_gira).to be_valid
      end
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @integrante_de_elenco_en_gira.email = mixed_case_email
      @integrante_de_elenco_en_gira.save
      expect(@integrante_de_elenco_en_gira.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "When cuil_cuit is not present" do
    before {@integrante_de_elenco_en_gira.cuil_cuit = ' '}
    it {should_not be_valid}
  end

  describe "when fecha_de_nacimiento is not present" do
    before { @integrante_de_elenco_en_gira.fecha_de_nacimiento = " " }
    it { should_not be_valid }
  end

  describe "when calle is not present" do
    before { @integrante_de_elenco_en_gira.calle = " " }
    it { should_not be_valid }
  end

  describe "when altura_calle is not present" do
    before { @integrante_de_elenco_en_gira.altura_calle = " " }
    it { should_not be_valid }
  end

  describe "when provincia is not present" do
    before { @integrante_de_elenco_en_gira.provincia = nil }
    it { should_not be_valid }
  end

  describe "when localidad is not present" do
    before { @integrante_de_elenco_en_gira.localidad = nil }
    it { should_not be_valid }
  end

  describe "when codigo_postal is not present" do
    before { @integrante_de_elenco_en_gira.codigo_postal = " " }
    it { should_not be_valid }
  end

  describe "when elencos_en_gira_id is not present" do
    before {
      @integrante_de_elenco_en_gira = IntegranteDeElencoEnGira.new(nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "12345678912", fecha_de_nacimiento: date, calle: "Santa Fe", altura_calle: "1000",
                                                                   provincia: provincia, localidad: localidad, codigo_postal: "1406")
    }

    it { should_not be_valid }
  end

  describe "Agregar integrantes al elenco" do
    it { elenco_en_gira.should be_valid }
  end

  describe "obtener los hijos por tipo" do
    before do

    end
    it {
      elenco_en_gira.integrantes_de_elenco_en_gira.length.should == 1
      elenco_en_gira.integrantes_de_elenco_en_gira.create(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "76543218912", fecha_de_nacimiento: date, calle: "Padilla", altura_calle: "1212", provincia: provincia, localidad: localidad, codigo_postal: "1414")
      elenco_en_gira.integrantes_de_elenco_en_gira.length.should == 2
    }

    it {
      @director = elenco_en_gira.integrantes_de_elenco_en_gira.create(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "76543218912", fecha_de_nacimiento: date, calle: "Padilla", altura_calle: "1212", provincia: provincia, localidad: localidad, codigo_postal: "1414")
      elenco_en_gira.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should == @director.id
      elenco_en_gira.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should_not == @integrante_de_elenco_en_gira.id
    }

    let(:formulario2) {FactoryGirl.create(:formulario, id: 2, user: elenco_en_gira.formulario.user)}
    let(:elenco_en_gira2) {FactoryGirl.create(:elenco_en_gira, id: 2, formulario: formulario2)}

    it {
      @director = elenco_en_gira.integrantes_de_elenco_en_gira.create(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com", cuil_cuit: "76543218912", fecha_de_nacimiento: date, calle: "Padilla", altura_calle: "1212", provincia: provincia, localidad: localidad, codigo_postal: "1414")
      @director2 = elenco_en_gira2.integrantes_de_elenco_en_gira.create(type: 'Director', nombre: "Lucas", apellido: "Capo", email: "lucas.capo@gmail.com", cuil_cuit: "76543213235", fecha_de_nacimiento: date, calle: "Corrientes", altura_calle: "1553", provincia: provincia, localidad: localidad, codigo_postal: "1414")
      elenco_en_gira.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should == @director.id
      elenco_en_gira2.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should_not == @director.id
      elenco_en_gira2.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should == @director2.id
    }

  end
end
