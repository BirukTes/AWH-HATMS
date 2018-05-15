require 'rails_helper'

RSpec.describe "invoices/edit", type: :view do
  before(:each) do
    @invoice = assign(:invoice, Invoice.create!(
      :paymentReceived => false,
      :patient => nil
    ))
  end

  it "renders the edit invoice form" do
    render

    assert_select "form[action=?][method=?]", invoice_path(@invoice), "post" do

      assert_select "input[name=?]", "invoice[paymentRecieved]"

      assert_select "input[name=?]", "invoice[patient_id]"
    end
  end
end
