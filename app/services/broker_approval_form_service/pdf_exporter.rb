# Generates a broker approval form PDF.
class BrokerApprovalFormService::PdfExporter

  def initialize(broker_approval_form_id, template, footer_name)
    @broker_approval_form_id = broker_approval_form_id
    @template = template
    @footer_name = footer_name
  end

  def perform
    view_path = "broker_approval_forms/#{@template}"
    pdf = nil

    @broker_approval_form = BrokerApprovalForm.find(@broker_approval_form_id)

    pdf = PdfService::Generator.new(view_path, @footer_name,
      {broker_approval_form: @broker_approval_form, title: "Broker Approval Form"}).perform

    pdf
  end

end