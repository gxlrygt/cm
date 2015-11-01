# Generate a PDF based on a view
class PdfService::Generator < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize(template, footer_name, locals={})
    super(ActionController::Base.view_paths << "app/views/layouts")
    @template = template
    @locals = locals
    @footer_name = footer_name
  end

  # Generate a pdf from the string output of the template. Uses wicked pdf gem.
  def perform
    html = render(
      layout: "pdf.html.haml",
      template: @template,
      locals: @locals
    )
    
    WickedPdf.new.pdf_from_string(
      html,
      footer:       {right: "Commerce Home Mortgage Wholesale | #{@footer_name} Page [page]", spacing: 2, font_size: 10},
      margin:       {top: 10},
      grayscale:    false,
      lowquality:   false
      #extra: "--checkbox-svg #{File.join(Rails.root, 'app', 'assets', 'images', 'Unselected_Check.svg')} --checkbox-checked-svg #{File.join(Rails.root, 'app', 'assets', 'images', 'Selected_Check.svg')}"
    )
  end
end