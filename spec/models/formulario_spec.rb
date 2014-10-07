#encoding: utf-8
require 'spec_helper'

describe Formulario do
	let(:user) { FactoryGirl.create(:user) }
  before do
    @formulario = Formulario.new(user_id: user.id, estado: 2)
  end

  subject { @formulario }

  it { should respond_to(:estado) }
  it { should respond_to(:user_id) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @formulario.user_id = nil }
    it { should_not be_valid }
  end
end