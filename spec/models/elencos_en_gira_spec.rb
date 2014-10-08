require 'spec_helper'

describe ElencosEnGira do

	let(:formulario) { FactoryGirl.create(:formulario) }

  before { @elencos = formulario.build_elencos_en_gira() }

  subject { @elencos }

  it { should be_valid }

end
