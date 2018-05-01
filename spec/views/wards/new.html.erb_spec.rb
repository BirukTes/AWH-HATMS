require 'rails_helper'

RSpec.describe "wards/new", type: :view do
  before(:each) do
    assign(:ward, Ward.new(
      :name => "MyString",
      :wardNumber => 1,
      :numberOfBeds => 1,
      :bedStatus => 1,
      :patientGender => "MyString",
      :deptName => "MyString",
      :isPrivate => false
    ))
  end

  it "renders new ward form" do
    render

    assert_select "form[action=?][method=?]", wards_path, "post" do

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
