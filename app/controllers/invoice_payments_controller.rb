class InvoicePaymentsController < ApplicationController

  respond_to(:json, :js, :html)


  def new
    # puts( Rails.application.secrets.braintree_environment,
    # Rails.application.secrets.braintree_merchant_id,
    # Rails.application.secrets.braintree_public_key,
    # Rails.application.secrets.braintree_private_key,)
    gateway = Braintree::Gateway.new(:environment => Rails.application.secrets.braintree_environment.to_s.to_sym,
                                     :merchant_id => Rails.application.secrets.braintree_merchant_id,
                                     :public_key => Rails.application.secrets.braintree_public_key,
                                     :private_key => Rails.application.secrets.braintree_private_key)

    # Get client authorization token,
    # include :customer_id => a_customer_id to identify previous customer
    @client_token = gateway.client_token.generate

    # respond_modal_with(@client_token)
    render layout: 'layouts/modal'

  end

  def create
    gateway = Braintree::Gateway.new(:environment => Rails.application.secrets.braintree_environment.to_s.to_sym,
                                     :merchant_id => Rails.application.secrets.braintree_merchant_id,
                                     :public_key => Rails.application.secrets.braintree_public_key,
                                     :private_key => Rails.application.secrets.braintree_private_key)
    nonce_from_the_client = params[:payment_method_nonce]
# Use payment method nonce here...
#
    result = gateway.transaction.sale(
        amount: "10.00",
        payment_method_nonce: nonce_from_the_client,
        options: {
            submit_for_settlement: true
        }
    )

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
end
