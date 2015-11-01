# Searches for counties in a state
class OptimalBlueService::CountySearch

  def initialize(state_code)
    @state_code = state_code
  end

  def perform
    raw_xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">
    <soap:Header>
      <AdminManagement xmlns=\"http://OptimalBlue.com/AdminServices\">
          <ServiceAccountUsername>#{ENV['OB_USERNAME']}</ServiceAccountUsername>
          <ServiceAccountPassword>#{ENV['OB_PASSWORD']}</ServiceAccountPassword>
      </AdminManagement>
      <CustomerInfo xmlns=\"http://OptimalBlue.com/AdminServices\">
        <CustomerName>#{ENV['OB_USERNAME']}</CustomerName>
        <Password>#{ENV['OB_PASSWORD']}</Password>
      </CustomerInfo>
    </soap:Header>
    <soap:Body>
      <GetCountyList xmlns=\"http://OptimalBlue.com/AdminServices\">
        <Request>
          <Request xmlns=\"\">
            <StateCode>#{@state_code}</StateCode>
          </Request>
        </Request>
      </GetCountyList>
    </soap:Body>
</soap:Envelope>"

    response = soap_client.call(:get_county_list, xml: raw_xml)
    body = response.body
    if body[:get_county_list_response] && body[:get_county_list_response][:get_county_list_result] && body[:get_county_list_response][:get_county_list_result][:result] && body[:get_county_list_response][:get_county_list_result][:result][:counties] && body[:get_county_list_response][:get_county_list_result][:result][:counties][:county]
      body[:get_county_list_response][:get_county_list_result][:result][:counties][:county]
    else
      Rails.logger.error("Unable to fetch counties for #{@state_code}")
      Rails.logger.error(body)
      []
    end
  end

  private

  def soap_client
    Savon.client(wsdl: 'http://services.optimalblue.com/LoanServices/AdminServices.asmx?wsdl', endpoint: "https://services.optimalblue.com/loanservices/AdminServices.asmx?version=CommerceHomeMortgage.v1", element_form_default: :unqualified)
  end

end