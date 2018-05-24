# frozen_string_literal: true

class InvoicePaymentsController < ApplicationController
  respond_to(:json, :js, :html)

  before_action(:set_admission, only: %i[new create])

  def new
    # Initial Braintree Gateway and assign to variable
    gateway = Braintree::Gateway.new(environment: Rails.application.secrets.braintree_environment.to_s.to_sym,
                                     merchant_id: Rails.application.secrets.braintree_merchant_id,
                                     public_key: Rails.application.secrets.braintree_public_key,
                                     private_key: Rails.application.secrets.braintree_private_key)

    # Get client authorization token,
    # include :customer_id => a_customer_id to identify previous customer
    @client_token = gateway.client_token.generate

    respond_modal_with(@client_token)
    # render layout: 'layouts/modal'
  end

  def create

    gateway = Braintree::Gateway.new(environment: Rails.application.secrets.braintree_environment.to_s.to_sym,
                                     merchant_id: Rails.application.secrets.braintree_merchant_id,
                                     public_key: Rails.application.secrets.braintree_public_key,
                                     private_key: Rails.application.secrets.braintree_private_key)
    nonce_from_the_client = params[:payment_method_nonce]

    binding.pry
    result = gateway.customer.create(
        first_name: @admission.patient.person.firstName,
        last_name: @admission.patient.person.lastName,
        email: @admission.patient.email,
        payment_method_nonce: nonce_from_the_client)


    collection = gateway.customer.search do |search|
      search.email.is(@admission.patient.email)
    end
    unless collection
      puts true
    end

    if result.success?
      puts result.customer.id
      puts result.customer.payment_methods[0].token
    else
      puts result.errors
    end

    # Use payment method nonce here...

    result = gateway.transaction.sale(
        amount: @admission.invoice.amount,
        payment_method_nonce: nonce_from_the_client,
        options: {
            submit_for_settlement: true
        })

    response = { success: result.success? }
    if result.success?
      puts "success trans: #{result.transaction.id}"
      response[:transaction_id] = result.transaction.id
    elsif result.transaction
      put('Error processing trans: ')
      put("code: #{result.transaction.processor_response_code}")
      put("text: #{result.transaction.processor_response_text}")
    else
      p result.errors
      response[:error] = result.errors.inspect
    end
    render json: response
  end

  private

  def invoice_payment_params
    params.require(:invoice_payment).permit(:payment_method_nonce, :admission_id)
  end

  def set_admission
    # Retrieve the admission
    binding.pry
    @admission = Admission.find(params[:admission_id]) if params[:admission_id]
  end
end
