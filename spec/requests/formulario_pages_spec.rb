#encoding: utf-8
require 'spec_helper'

describe "Formulario" do

  subject { page }

  describe "formulario page" do
    #FactoryGirl.create(:formulario)

    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit formularios_path
    end

    it { should have_content('Formulario') }
    it { should have_title(('Formularios de Inscripcion del usuario')) }
  end

end
