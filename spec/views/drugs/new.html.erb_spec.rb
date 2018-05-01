require 'rails_helper'

RSpec.describe "drugs/new", type: :view do
  before(:each) do
    assign(:drug, Drug.new(
      :code => "MyString",
      :name => "MyString"
    ))
  end

  it "renders new drug form" do
    render

    assert_select "form[action=?][method=?]", drugs_path, "post" do

      assert_select "input[name=?]", "drug[code]"

      assert_select "input[name=?]", "drug[name]"
    end
  end
end
