#encoding: utf-8
require 'spec_helper'

describe "Static pages" do

	subject { page }

  describe "Home page" do

  	before {visit root_path}

    it { should have_content('Bienvenido') }

    it { should have_title('Convocatoria INT Presenta 2015') }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Home"
    click_link "Registrarse!"
    expect(page).to have_title ('Registrarse')
    click_link "INT"
  end
end

