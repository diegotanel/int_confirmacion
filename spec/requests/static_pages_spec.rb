#encoding: utf-8
require 'spec_helper'

describe "Static pages" do

	subject { page }

  describe "Home page" do

  	before {visit root_path}

    it { should have_content('INT') }

    it { should have_title('Home') }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Home"
    click_link "Registrarse!"
    expect(page).to have_title ('Registrarse')
    click_link "INT"
    expect(page).to have_title ('Home')
  end
end

