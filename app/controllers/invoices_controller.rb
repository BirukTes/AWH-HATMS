class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  # Authorisation callbacks
  after_action(:verify_authorized)

  # GET /invoices
  # GET /invoices.json
  def index
    authorize(:invoice)
    @invoices = Invoice.all
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    authorize(:invoice)
    @invoice = Invoice.new
    @invoice.invoice_details.build

    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      admission_id_extract = params[:patient_id].split('|')[1]
      @admission = Admission.find(admission_id_extract)
      # @invoice.admission.prescriptions

      # Save the admission to session and use it if re-rendering is required (create errors)
      session[:current_invoicing_admission] = @admission
    elsif params.include?(:rest_patient)
      @admission = nil
    end
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    authorize(:invoice)
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save!
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        # Retrieve the current admission, in case of null failure, staff has to restart
        @admission = session[:current_invoicing_admission]

        format.html { render :new }
        # Todo handle errors as this redirects to the find form
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    authorize(:invoice)
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:date, :dateDue, :paymentRecieved, :patient_id, :amount, :admission_id,
                                    invoice_details_attributes: [:treatment, :quantity, :unitPrice, :tax, :lineTotal, :_destroy])
  end
end
