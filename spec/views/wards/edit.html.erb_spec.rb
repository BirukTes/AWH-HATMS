require 'rails_helper'

RSpec.describe "wards/edit", type: :view do
  before(:each) do
    @ward = assign(:ward, Ward.create!(
      :name => "MyString",
      :wardNumber => 1,
      :numberOfBeds => 1,
      :bedStatus => 1,
      :patientGender => "MyString",
      :deptName => "MyString",
      :isPrivate => false
    ))
  end

  it "renders the edit ward form" do
    render

    assert_select "form[action=?][method=?]", ward_path(@ward), "post" do

      assert_select "input[name=?]", "ward[name]"

      assert_select "input[name=?]", "ward[wardNumber]"

      assert_select "input[name=?]", "ward[numberOfBeds]"

      assert_select "input[name=?]", "ward[bedStatus]"

      assert_select "input[name=?]", "ward[patientGender]"

      assert_select "input[name=?]", "ward[deptName]"

      assert_select "input[name=?]", "ward[isPrivate]"
    end
  end
end
