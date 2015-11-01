require 'fileutils'


# Creates PDFs, zips them and returns mails it to the email
class LoanService::CoverPageMailer

  def initialize(loan_id, email)
    @loan_id = loan_id
    @email = email
  end

  def perform
    base_directory = File.join(Rails.root, "tmp", "loans", @loan_id.to_s)
    loan = Loan.find(@loan_id)

    FileUtils::mkdir_p(base_directory)
    FileUtils.rm_rf("#{base_directory}/.", secure: true)

    footer_name = "Approval Requirements"

    # Cover page
    pdf_data = LoanService::PdfExporter.new(@loan_id, "cover_page", footer_name).perform
    File.open(File.join(base_directory, "cover_page.pdf"), 'wb') {|file| file.write(pdf_data) }

    mailer = LoansMailer.send_cover_page(loan, @email)
    mailer.attachments["cover_page.pdf"] = File.read(File.join(base_directory, "cover_page.pdf"))
    mailer.deliver

    # Clean up
    FileUtils.rm_rf("#{base_directory}/.", secure: true)
  end

end