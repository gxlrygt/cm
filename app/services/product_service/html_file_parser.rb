# Finds the table HTML from an HTML file exported from Excel
class ProductService::HtmlFileParser
  def initialize(html)
    @html = html
  end

  def perform
    @html = @html.read
    @html.sub!("charset=macintosh", "charset=utf-8")
    html_doc = Nokogiri::HTML(@html)
    html_doc.xpath('//@style').remove
    html_doc.xpath('//@width').remove
    html_doc.xpath('//@height').remove
    html_doc.css("table:first").to_s
  end
end