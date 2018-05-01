require 'rails_helper'

RSpec.describe "wards/show", type: :view do
  before(:each) do
    @ward = assign(:ward, Ward.create!(
      :name => "Name",
      :wardNumber => 2,
      :numberOfBeds => 3,
      :bedStatus => 4,
      :patientGender => "Patient Gender",
      :deptName => "Dept Name",
      :isPrivate => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Patient Gender/)
    expect(rendered).to match(/Dept Name/)
    expect(rendered).to match(/false/)
  end
end
