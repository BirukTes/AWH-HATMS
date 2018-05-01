require 'rails_helper'

RSpec.describe "drugs/index", type: :view do
  before(:each) do
    assign(:drugs, [
      Drug.create!(
        :code => "Code",
        :name => "Name"
      ),
      Drug.create!(
        :code => "Code",
        :name => "Name"
      )
    ])
  end

  it "renders a list of drugs" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
