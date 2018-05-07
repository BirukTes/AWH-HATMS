require 'rails_helper'

RSpec.describe "specialities/index", type: :view do
  before(:each) do
    assign(:specialities, [
      Speciality.create!(
        :speciality => "Speciality"
      ),
      Speciality.create!(
        :speciality => "Speciality"
      )
    ])
  end

  it "renders a list of specialities" do
    render
    assert_select "tr>td", :text => "Speciality".to_s, :count => 2
  end
end
