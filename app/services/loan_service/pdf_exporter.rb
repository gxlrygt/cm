# Generates a submit a loan PDF.
class LoanService::PdfExporter

  def initialize(loan_id, template, footer_name)
    @loan_id = loan_id
    @template = template
    @footer_name = footer_name
  end

  def perform
    view_path = "loans/#{@template}.pdf.haml"
    pdf = nil

    @loan = Loan.find(@loan_id)

    pdf = PdfService::Generator.new(view_path, @footer_name, {loan: @loan }).perform

    pdf
  end

end