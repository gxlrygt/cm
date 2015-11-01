# Performs a quick search through OB
class StreetSmartValuationsService::Registration

  def initialize(registration_params)
    @registration_params = registration_params
  end

  def perform
    response = HTTParty.post("http://www.streetsmartvaluations.com/scripts/loginrequest.php", body: @registration_params)
    if response.code == 200
      { code: 200, message: "Thank you for your request.  We will be in touch shortly."}
    else
      { code: response.code, message: "Unable to submit your registration information. Please try again or if the problem persists, contact support."}
    end
  end

end