require 'rails_helper'

RSpec.describe "diagnoses/new", type: :view do
  before(:each) do
    assign(:diagnoses, Diagnosis.new(
      :title => "MyString",
      :description => "MyString",
      :admission => nil
    ))
  end

  it "renders new diagnoses form" do
    render

    assert_select "form[action=?][method=?]", diagnoses_path, "post" do

      assert_select "input[name=?]", "diagnoses[title]"

      assert_select "input[name=?]", "diagnoses[description]"

      assert_select "input[name=?]", "diagnoses[admission_id]"
    end
  end
end
