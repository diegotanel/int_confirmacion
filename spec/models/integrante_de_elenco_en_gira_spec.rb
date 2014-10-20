#encoding: utf-8
require 'spec_helper'

describe IntegranteDeElencoEnGira do

  let(:elenco_en_gira) { FactoryGirl.create(:elenco_en_gira) }
  let(:localidad) { FactoryGirl.create(:localidad) }

  def params
    {type: 'Actor', nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "12345678912", fecha_de_nacimiento: DateTime.now, calle: "Santa Fe", altura_calle: "1000", localidad: localidad, codigo_postal: "1406", tel_celular: "5345345", tel_particular: ''}
  end

  describe "fallido" do
    describe "siempre debe guardarse con una instancia de una clase hijo" do
      before {
        @integrante_de_elenco_en_gira = elenco_en_gira.integrantes_de_elenco_en_gira.build(params.merge(type: nil))
      }
      it {
        expect { @integrante_de_elenco_en_gira.save! }.to raise_error(ActiveRecord::StatementInvalid)
      }
    end
  end

  describe "exitoso" do
    before do
      @integrante_de_elenco_en_gira = elenco_en_gira.integrantes_de_elenco_en_gira.create(params)
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
    it { should respond_to(:provincia_id) }
    it { should respond_to(:localidad) }
    it { should respond_to(:codigo_postal) }
    it { should respond_to(:email) }
    it { should respond_to(:elenco_en_gira_id) }
    it { should respond_to(:type) }
    it { should respond_to(:tel_particular) }
    it { should respond_to(:tel_celular) }
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

    describe "cuil_cuit debe ser numérico" do
      before {@integrante_de_elenco_en_gira.cuil_cuit = 'asdfas'}
      it {should_not be_valid}
    end

    describe "cuil_cuit deben ser 11 caracteres" do
      it {
        @integrante_de_elenco_en_gira.cuil_cuit = "1" * 9
        should_not be_valid
      }
      it {
        @integrante_de_elenco_en_gira.cuil_cuit = "1" * 23
        should_not be_valid
      }
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

    describe "when localidad is not present" do
      before { @integrante_de_elenco_en_gira.localidad = nil }
      it { should_not be_valid }
    end

    describe "when codigo_postal is not present" do
      before { @integrante_de_elenco_en_gira.codigo_postal = " " }
      it { should_not be_valid }
    end

    describe "tel_particular debe ser numérico" do
      before {@integrante_de_elenco_en_gira.tel_particular = 'asdfas'}
      it {should_not be_valid}
    end


    describe "tel_celular" do
      describe "When tel_celular is not present" do
        before {@integrante_de_elenco_en_gira.tel_celular = ''}
        it { should_not be_valid }
      end

      describe "tel_celular debe ser numérico" do
        before {@integrante_de_elenco_en_gira.tel_celular = 'asdfas'}
        it {should_not be_valid}
      end
    end


    describe "when elencos_en_gira_id is not present" do
      before {
        @integrante_de_elenco_en_gira = IntegranteDeElencoEnGira.new(nombre: "Pedro", apellido: "Gomez", email: "pedro.gomez@gmail.com", cuil_cuit: "12345678912", fecha_de_nacimiento: DateTime.now, calle: "Santa Fe", altura_calle: "1000",
                                                                     localidad: localidad, codigo_postal: "1406", tel_celular: "fasdfas")
      }

      it { should_not be_valid }
    end

    describe "Agregar integrantes al elenco" do
      it { elenco_en_gira.should be_valid }
    end

    describe "obtener los hijos por tipo" do
      it {
        elenco_en_gira.integrantes_de_elenco_en_gira.length.should == 1
        elenco_en_gira.integrantes_de_elenco_en_gira.create(params.merge(type: 'Director'))
        elenco_en_gira.integrantes_de_elenco_en_gira.length.should == 2
      }

      it {
        @director = elenco_en_gira.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com"))
        elenco_en_gira.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should == @director.id
        elenco_en_gira.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should_not == @integrante_de_elenco_en_gira.id
      }

      let(:formulario2) {FactoryGirl.create(:formulario, id: 2, user: elenco_en_gira.formulario.user)}
      let(:elenco_en_gira2) {FactoryGirl.create(:elenco_en_gira, id: 2, formulario: formulario2)}

      it {
        @director = elenco_en_gira.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Roberto", apellido: "Carlos", email: "roberto.carlos@gmail.com"))
        @director2 = elenco_en_gira2.integrantes_de_elenco_en_gira.create!(params.merge(type: 'Director', nombre: "Lucas", apellido: "Capo", email: "lucas.capo@gmail.com"))
        elenco_en_gira.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should == @director.id
        elenco_en_gira2.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should_not == @director.id
        elenco_en_gira2.integrantes_de_elenco_en_gira.find_by(type: 'Director').id.should == @director2.id
      }

    end
  end


end
