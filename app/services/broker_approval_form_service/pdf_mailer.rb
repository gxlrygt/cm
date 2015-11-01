require 'fileutils'


# Creates PDFs, zips them and returns mails it to the email
class BrokerApprovalFormService::PdfMailer

  def initialize(broker_approval_form_id)
    @broker_approval_form_id = broker_approval_form_id
  end

  def perform
    base_directory = File.join(Rails.root, "tmp", "broker_approval_forms", @broker_approval_form_id.to_s)
    broker_approval_form = BrokerApprovalForm.find(@broker_approval_form_id)

    FileUtils::mkdir_p(base_directory)
    FileUtils.rm_rf("#{base_directory}/.", secure: true)

    pdfs = BrokerApprovalForm::PDF_FORMS.keys
    pdfs.each do |pdf_name|
      pdf_data = BrokerApprovalFormService::PdfExporter.new(@broker_approval_form_id, "#{pdf_name}.pdf.erb", BrokerApprovalForm::PDF_FORMS[pdf_name][:footer_name]).perform
      File.open(File.join(base_directory, "#{pdf_name}.pdf"), 'wb') {|file| file.write(pdf_data) }
    end

    zip_output_file = File.join(base_directory, "broker_forms.zip")
    ZipFileService::ZipDirectory.new(base_directory, zip_output_file).perform

    mailer = BrokerFormsMailer.send_pdfs(broker_approval_form)
    mailer.attachments["broker_forms.zip"] = File.read(zip_output_file)
    mailer.deliver

    # Clean up
    FileUtils.rm_rf("#{base_directory}/.", secure: true)
  end

end