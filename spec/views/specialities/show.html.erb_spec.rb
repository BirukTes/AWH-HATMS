require 'rails_helper'

RSpec.describe "specialities/show", type: :view do
  before(:each) do
    @speciality = assign(:speciality, Speciality.create!(
      :speciality => "Speciality"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Speciality/)
  end
end
