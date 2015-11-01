class SsoController < ApplicationController
  def index
    street_smart_login_response = HTTParty.get("https://streetsmartvaluations.vmpclient.com/SignIn.aspx", verify: false)
    if street_smart_login_response.code == 200
      html_doc = Nokogiri::HTML(street_smart_login_response.parsed_response)
      @street_smart_inputs = html_doc.css("input[type='hidden']")
    end

    commercemtg_partners_login_response = HTTParty.get("https://2306676713.secure-onlineorigination.com/TPOLogin.aspx", verify: false)
    if commercemtg_partners_login_response.code == 200
      html_doc = Nokogiri::HTML(commercemtg_partners_login_response.parsed_response)
      @commercemtg_partners_inputs = html_doc.css("form input[type='hidden']")
    end
  end
end