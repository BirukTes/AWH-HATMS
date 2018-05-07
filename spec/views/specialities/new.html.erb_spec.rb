require 'rails_helper'

RSpec.describe "specialities/new", type: :view do
  before(:each) do
    assign(:speciality, Speciality.new(
      :speciality => "MyString"
    ))
  end

  it "renders new speciality form" do
    render

    assert_select "form[action=?][method=?]", specialities_path, "post" do

      assert_select "input[name=?]", "speciality[speciality]"
    end
  end
end
