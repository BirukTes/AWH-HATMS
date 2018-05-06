require 'rails_helper'

RSpec.describe "invoices/index", type: :view do
  before(:each) do
    assign(:invoices, [
      Invoice.create!(
        :paymentRecieved => false,
        :patient => nil
      ),
      Invoice.create!(
        :paymentRecieved => false,
        :patient => nil
      )
    ])
  end

  it "renders a list of invoices" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
