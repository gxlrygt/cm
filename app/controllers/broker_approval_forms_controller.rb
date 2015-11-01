class BrokerApprovalFormsController < ApplicationController
  before_action :find_broker_approval_form, only: [:show, :mortgage_broker_agreement, :loan_fraud, :fair_lending_acknowledgement, :company_resolution_doc_3, :company_resolution_doc_4, :fha_sponsorship, :quality_control, :respa, :sales_compensation, :va_sponsorship]
  respond_to :html

  def index
    @broker_approval_forms = BrokerApprovalForm.all
    respond_with(@broker_approval_forms)
  end

  def new
    @broker_approval_form = BrokerApprovalForm.new
    @broker_approval_form.tpo_user_access_requests.build
    respond_with(@broker_approval_form)
  end

  def create
    @broker_approval_form = BrokerApprovalForm.new(broker_approval_form_params)
    @broker_approval_form.save
    respond_with(@broker_approval_form)
  end

  def edit
    @broker_approval_form = BrokerApprovalForm.find(params[:id])
    respond_with(@broker_approval_form)
  end

  def update
    @broker_approval_form = BrokerApprovalForm.find(params[:id])
    @broker_approval_form.update_attributes(broker_approval_form_params)
    respond_with(@broker_approval_form)
  end

  def show
    respond_with(@broker_approval_form)
  end

  def destroy
    @broker_approval_form = BrokerApprovalForm.find(params[:id])
    @broker_approval_form.destroy
    respond_with(@broker_approval_form)
  end

  def mortgage_broker_agreement
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "mortgage_broker_agreement.pdf.erb", BrokerApprovalForm::PDF_FORMS[:mortgage_broker_agreement][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:mortgage_broker_agreement][:filename])
      end
    end
  end

  def loan_fraud
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "loan_fraud.pdf.erb", BrokerApprovalForm::PDF_FORMS[:loan_fraud][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:loan_fraud][:filename])
      end
    end
  end

  def fair_lending_acknowledgement
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "fair_lending_acknowledgement.pdf.erb", BrokerApprovalForm::PDF_FORMS[:fair_lending_acknowledgement][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:fair_lending_acknowledgement][:filename])
      end
    end
  end

  def company_resolution_doc_3
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "company_resolution_doc_3.pdf.erb", BrokerApprovalForm::PDF_FORMS[:company_resolution_doc_3][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:company_resolution_doc_3][:filename])
      end
    end
  end

  def company_resolution_doc_4
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "company_resolution_doc_4.pdf.erb", BrokerApprovalForm::PDF_FORMS[:company_resolution_doc_4][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:company_resolution_doc_4][:filename])
      end
    end
  end

  def fha_sponsorship
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "fha_sponsorship.pdf.erb", BrokerApprovalForm::PDF_FORMS[:fha_sponsorship][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:fha_sponsorship][:filename])
      end
    end
  end

  def quality_control
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "quality_control.pdf.erb", BrokerApprovalForm::PDF_FORMS[:quality_control][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:quality_control][:filename])
      end
    end
  end

  def respa
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "respa.pdf.erb", BrokerApprovalForm::PDF_FORMS[:respa][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:respa][:filename])
      end
    end
  end

  def sales_compensation
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "sales_compensation.pdf.erb", BrokerApprovalForm::PDF_FORMS[:sales_compensation][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:sales_compensation][:filename])
      end
    end
  end

  def va_sponsorship
    respond_to do |format|
      format.pdf do
        send_data(BrokerApprovalFormService::PdfExporter.new(@broker_approval_form.id, "va_sponsorship.pdf.erb", BrokerApprovalForm::PDF_FORMS[:va_sponsorship][:footer_name]).perform, filename: BrokerApprovalForm::PDF_FORMS[:va_sponsorship][:filename])
      end
    end
  end

  private
    
  def broker_approval_form_params
    params.require(:broker_approval_form).permit(:company, :company_type, :dba, :company_president, :broker_of_record, :nmls, :address, :city, :state_id, :zip, :primary_contact, :phone, :title, {loan_type_ids: []}, :how_did_you_find_us, :lender_paid_compensation_percentage, :maximum_compensation, :how_did_you_find_us_other, :how_did_you_find_us_account_executive_name, :email, tpo_user_access_requests_attributes: [ :first_name, :last_name, :email, :role, :nmls_number, :nmls_issued, :nmls_expiration ])
  end

  def find_broker_approval_form
    @broker_approval_form = BrokerApprovalForm.includes(:loan_types).find(params[:id])
  end
end