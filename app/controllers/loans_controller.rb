class LoansController < ApplicationController
  before_action :find_loan, only: [:show, :edit, :update, :destroy, :cover_page]
  respond_to :html

  def index
    @loans = Loan.all
    respond_with(@loans)
  end

  def new
    @loan = Loan.new
    respond_with(@loan)
  end

  def create
    @loan = Loan.new(loan_params)
    @loan.save
    respond_with(@loan)
  end

  def edit
    respond_with(@loan)
  end

  def update
    @loan.update_attributes(loan_params)
    respond_with(@loan)
  end

  def show
    respond_with(@loan)
  end

  def destroy
    @loan.destroy
    respond_with(@loan)
  end

  def cover_page
    respond_to do |format|
      format.pdf do
        send_data(LoanService::PdfExporter.new(@loan.id, "cover_page", "Cover Page").perform, filename: "cover_page.pdf")
      end
    end
  end

  private
    
  def loan_params
    params.require(:loan).permit(:account_executive, :gfe_file, :fee_worksheet, :lender_or_borrower_paid, :underwriting_fee_buyout, :lender_compensation, :broker_first_name, :broker_last_name, :broker_phone, :broker_email, :processor_first_name, :processor_last_name, :processor_phone, :processor_email, :address, :city, :state_id, :zip, :borrower_first_name, :borrower_last_name, :borrower_email, :borrower_mid_fico_score, :coborrower_first_name, :coborrower_last_name, :coborrower_email, :coborrower_mid_fico_score, :property_value, :loan_amount, :disclosed_rate_pct, :ltv, :cltv, :impounds_or_escrows, :loan_type, :transaction_type, :fha_underwriting_type, :term, :property_type, :appraisal_needed, :occupancy, :additional_details)
  end

  def find_loan
    @loan = Loan.find(params[:id])
  end

end
