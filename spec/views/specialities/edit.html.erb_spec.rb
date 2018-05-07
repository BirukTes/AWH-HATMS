require 'rails_helper'

RSpec.describe "specialities/edit", type: :view do
  before(:each) do
    @speciality = assign(:speciality, Speciality.create!(
      :speciality => "MyString"
    ))
  end

  it "renders the edit speciality form" do
    render

    assert_select "form[action=?][method=?]", speciality_path(@speciality), "post" do

      assert_select "input[name=?]", "speciality[speciality]"
    end
  end
end
