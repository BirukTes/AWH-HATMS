require 'rails_helper'

RSpec.describe "teams/show", type: :view do
  before(:each) do
    @team = assign(:team, Team.create!(
      :name => "Name",
      :head => "Head"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Head/)
  end
end
