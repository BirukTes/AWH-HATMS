require 'rails_helper'

RSpec.describe "invoices/new", type: :view do
  before(:each) do
    assign(:invoice, Invoice.new(
      :paymentRecieved => false,
      :patient => nil
    ))
  end

  it "renders new invoice form" do
    render

    assert_select "form[action=?][method=?]", invoices_path, "post" do

      assert_select "input[name=?]", "invoice[paymentRecieved]"

      assert_select "input[name=?]", "invoice[patient_id]"
    end
  end
end
