require 'rails_helper'

RSpec.describe "invoices/show", type: :view do
  before(:each) do
    @invoice = assign(:invoice, Invoice.create!(
      :paymentReceived => false,
      :patient => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
