require 'rails_helper'

RSpec.describe "diagnoses/index", type: :view do
  before(:each) do
    assign(:diagnoses, [
        Diagnosis.create!(
        :title => "Title",
        :description => "Description",
        :admission => nil
      ),
        Diagnosis.create!(
        :title => "Title",
        :description => "Description",
        :admission => nil
      )
    ])
  end

  it "renders a list of diagnoses" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
