class BrokerCenterController < ApplicationController
  def index
  end

  def quick_pricer
  end

  def appraisals
    street_smart_login_response = HTTParty.get("https://streetsmartvaluations.vmpclient.com/SignIn.aspx", verify: false)
    if street_smart_login_response.code == 200
      html_doc = Nokogiri::HTML(street_smart_login_response.parsed_response)
      @street_smart_inputs = html_doc.css("input[type='hidden']")
    end
  end

  def get_approved
  end

  def resources
  end

  def appraisals_signup_request
    respond_to do |format|
      format.json { render json: StreetSmartValuationsService::Registration.new(params).perform }
    end
  end

end
