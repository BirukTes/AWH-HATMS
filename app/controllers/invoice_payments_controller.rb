# Handles payment system, new and create methods
#
# @author Bereketab Gulai
class InvoicePaymentsController < ApplicationController

  before_action(:set_admission, :perform_authorise, only: %i[new create])

  # Initiates Braintree the and gets the payment view
  #
  # GET method
  def new
    begin
      # Get client authorization token,
      # include :customer_id => a_customer_id to identify previous customer
      @client_token = Braintree::ClientToken.generate
        # In worst case this will rescued
    rescue => e
      Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
      Rollbar.report_exception(e)
    end

    respond_modal_with(@client_token)
  end

  # Create this controller, makes transaction to Braintree,
  # update attributes and send confirmation
  #
  # POST method
  def create

    # Get the submitted nonce from params, for testing 'fake-valid-nonce'
    # nonce_from_the_client = 'fake-valid-nonce'
    nonce_from_the_client = params[:payment_method_nonce]

    # Find the patient in case they already created, a lot can be done
    #     Goal for Refactoring:
    #     + Uniquely identify customer/patient if they exist
    #         - This including adding braintree id attribute to Patient Model
    #     + Create new payment method or use their existing
    #
    # collection = gateway.customer.search do |search|
    #   # Email is best way to identify them, there is no date of birth
    #   search.email.is(@admission.patient.email)
    #   # Extra conditions
    #   search.first_name.is(@admission.patient.person.firstName)
    #   search.last_name.is(@admission.patient.person.lastName)
    # end

    # # If there nothing in the collection create the patient/customer
    # unless collection
    #   result = gateway.customer.create(
    #       first_name: @admission.patient.person.firstName,
    #       last_name: @admission.patient.person.lastName,
    #       email: @admission.patient.email,
    #       payment_method_nonce: nonce_from_the_client)
    #
    #   if result.success?
    #     puts result.customer.id
    #     puts result.customer.payment_methods[0].token
    #   else
    #     puts result.errors
    #   end
    # end

    respond_to do |format|
      # Rescue all that happens in this in case of an error
      begin
        # Make transaction to braintree TODO use the method provided in braintree repo instead
        @payment_result = Braintree::Transaction.sale(
            amount: @admission.invoice.amount,
            payment_method_nonce: nonce_from_the_client,
            options: {
                submit_for_settlement: true
            })

        response = { success: @payment_result.success? }


        # Handle the response
        if @payment_result.success?
          puts "success trans: #{@payment_result.transaction.id}"

          response[:transaction_id] = @payment_result.transaction.id

          # Update attributes
          update_invoice_received_attributes

          # Send confirmation
          deliver_confirmation

          # Redirect
          format.html { redirect_to(invoice_path(@admission.invoice),
                                    notice: 'Payment successful. Confirmation email will be sent to the patient.') }
        elsif @payment_result.transaction
          puts('Error processing transaction: ')
          # FIXME ActionView::Template::Error: undefined method `processor_response_text' for nil:NilClass
          puts("code: #{@payment_result.transaction&.processor_response_code}")
          puts("text: #{@payment_result.transaction.processor_response_text}")
          format.js { render(:create, result: @payment_result) }
        else
          puts(@payment_result.errors)
          response[:error] = @payment_result.errors.inspect
          format.js { render(:create, result: @payment_result) }
        end

          # In worst case this will rescued
      rescue StandardError => e
        Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
        Rollbar.report_exception(e)
        puts 'Exception: payment transaction'
        retry
      end
    end
  end

  private

  # Permitted params
  def invoice_payment_params
    params.require(:invoice_payment).permit(:payment_method_nonce, :admission_id)
  end

  # Sets admission
  def set_admission
    # Retrieve the admission
    @admission = Admission.find(params[:admission_id]) if params[:admission_id]
  end

  # Updates invoice received attributes
  def update_invoice_received_attributes
    # Mark receiving of payment
    @admission.invoice.update(paymentReceived: true, dateReceived: Date.today)
  end

  # Schedules confirmation to send
  def deliver_confirmation
    # Handled by delayed job (in the background)
    InvoiceMailer.delay.paid_invoice_confirmation(@admission.invoice)
  end

  # Performs Authorisation
  def perform_authorise
    # Against invoice it os
    authorize(:invoice)
  end
end

# Console Tested code: Working
#
# def create
#   # Get the submitted nonce from params, for testing 'fake-valid-nonce'
#   nonce_from_the_client = 'fake-valid-nonce'
#
#     # Rescue all that happens in this in case of an error
#     begin
#       # Make transaction to braintree
#       @payment_result = Braintree::Transaction.sale(
#           amount: '0.1',
#           payment_method_nonce: nonce_from_the_client,
#           options: {
#               submit_for_settlement: true
#           })
#
#       response = { success: @payment_result.success? }
#
#
#       # Handle the response
#       if @payment_result.success?
#         puts "success trans: #{@payment_result.transaction.id}"
#
#         response[:transaction_id] = @payment_result.transaction.id
#
#         puts 'Update attributes'
#
#         puts 'Send confirmation'
#
#         # Redirect
#         puts 'Payment successful. Confirmation email will be sent to the patient.'
#       elsif @payment_result.transaction
#         puts('Error processing transaction: ')
#         puts("code: #{@payment_result.transaction&.processor_response_code}")
#         puts("text: #{@payment_result.transaction.processor_response_text}")
#       else
#         puts(@payment_result.errors)
#         response[:error] = @payment_result.errors.inspect
#       end
#
#         # In worst case this will rescued
#     rescue StandardError => e
#       Rails.logger.error { "#{e.message} #{e.backtrace.join("\n")}" }
#       Rollbar.report_exception(e)
#       puts 'Exception: payment transaction'
#       retry
#     end
# end
