require 'spec_helper'

describe ElencoEnGira do

	let(:formulario) { FactoryGirl.create(:formulario) }

  before { @elenco = formulario.build_elenco_en_gira() }

  subject { @elenco }

  it { should be_valid }

  it "Validar que por lo menos se agregue un actor"

end
