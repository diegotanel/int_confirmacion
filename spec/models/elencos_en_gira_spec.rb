require 'spec_helper'

describe ElencosEnGira do

	let(:formulario) { FactoryGirl.create(:formulario) }

  before { @elencos = Elencos_en_gira.new(formulario_id: formulario.id) }

  subject { @elencos }

  it { should be_valid }

end
