require 'spec_helper'

describe Formulario do

  let(:user) { FactoryGirl.create(:user) }
  before { @formulario = user.formularios.build(content: "Lorem ipsum") }


  subject { @formulario }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @formulario.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @formulario.content = " " }
    it { should_not be_valid }
  end
end