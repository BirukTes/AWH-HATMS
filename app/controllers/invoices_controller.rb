class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :receive_payment, :set_payment_received]
  # Authorisation callbacks
  after_action(:verify_authorized)

  respond_to(:json, :js, :html)

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

    if params.include?(:ward_id) && params.include?(:patient_id) && @patient.eql?(nil)
      admission_id_extract = params[:patient_id].split('|')[1]
      @admission = Admission.find(admission_id_extract)

      # Setup the details, pre-populate, these can be changed in the future for more relevant treatments
      pre_populate_invoice_details

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

  def receive_payment
    # binding.pry
    respond_modal_with(@invoice)
  end

  def set_payment_received
    if params[:invoice][:dateReceived]
      if @invoice.update(dateReceived: params[:invoice][:dateReceived], paymentReceived: true)
        redirect_to(invoices_path(@invoice), notice: 'Payment received.')
      else
        render :receive_payment
      end
    else
      render :receive_payment
      flash[:alert] = 'Please fill the received date field.'
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
    params.require(:invoice).permit(:id, :dateReceived, :dateDue, :paymentReceived, :patient_id, :amount, :admission_id,
                                    invoice_details_attributes: [:id, :treatment, :quantity, :unitPrice, :tax, :lineTotal, :_destroy])
  end

  # Populates invoice details for the invoice in creation
  def pre_populate_invoice_details

    # For nights stay
    days_as_quantity = ((@admission.dischargeDate - @admission.admissionDate).to_int) / 1.day
    @invoice.invoice_details.build(
        treatment: 'Admission-Fee',
        quantity: days_as_quantity,
        unitPrice: '250.00',
        tax: '5.0',
        lineTotal: (250 * days_as_quantity * ((5 / 100) + 1)))

    # For Diagnoses, TODO 1 is only for the older admissions
    number_diagnoses = @admission.diagnoses.count
    @invoice.invoice_details.build(
        treatment: 'Diagnosis-Fee',
        quantity: number_diagnoses,
        unitPrice: '50.00',
        tax: '2.0',
        lineTotal: (50 * number_diagnoses * ((2 / 100) + 1)))

    # For prescriptions
    number_drugs = @admission.diagnoses.map { |diagnoses| diagnoses.prescriptions.map { |prescription| prescription.drugs.count }.sum }.sum
    @invoice.invoice_details.build(
        treatment: 'Drugs-Fee',
        quantity: number_drugs,
        unitPrice: '20.00',
        tax: '4.0',
        lineTotal: (20 * number_drugs * ((4 / 100) + 1)))
  end
end
