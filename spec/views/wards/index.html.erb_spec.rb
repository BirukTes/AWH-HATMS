require 'rails_helper'

RSpec.describe "wards/index", type: :view do
  before(:each) do
    assign(:wards, [
      Ward.create!(
        :name => "Name",
        :wardNumber => 2,
        :numberOfBeds => 3,
        :bedStatus => 4,
        :patientGender => "Patient Gender",
        :deptName => "Dept Name",
        :isPrivate => false
      ),
      Ward.create!(
        :name => "Name",
        :wardNumber => 2,
        :numberOfBeds => 3,
        :bedStatus => 4,
        :patientGender => "Patient Gender",
        :deptName => "Dept Name",
        :isPrivate => false
      )
    ])
  end

  it "renders a list of wards" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Patient Gender".to_s, :count => 2
    assert_select "tr>td", :text => "Dept Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
