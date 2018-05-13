require 'rails_helper'

RSpec.describe "diagnoses/edit", type: :view do
  before(:each) do
    @diagnosis = assign(:diagnoses, Diagnosis.create!(
      :title => "MyString",
      :description => "MyString",
      :admission => nil
    ))
  end

  it "renders the edit diagnoses form" do
    render

    assert_select "form[action=?][method=?]", diagnosis_path(@diagnosis), "post" do

      assert_select "input[name=?]", "diagnoses[title]"

      assert_select "input[name=?]", "diagnoses[description]"

      assert_select "input[name=?]", "diagnoses[admission_id]"
    end
  end
end
