class TpoController < ApplicationController
  def attempt_login
    result = false
    url = "https://2306676713.secure-onlineorigination.com/TPOLogin.aspx"

    resp = HTTParty.get(url, verify: false)
    if resp.code == 200
      html_doc = Nokogiri::HTML(resp.parsed_response)
      page_inputs = html_doc.css("form input[type='hidden']")

      post_params = {"loginUserName" => params[:username], "loginPassword" => params[:password], "__EVENTTARGET" => "ctl01$modulesContainerUserCtl$ctl00$loginModuleThemeButton$linkButton", "__EVENTARGUMENT" => "", "ctl01$modulesContainerUserCtl$ctl00$locationTextBox" => "https://2306676713.secure-onlineorigination.com/TPOLogin.aspx", "ctl01$modulesContainerUserCtl$ctl00$labelTextBox" => "ctl01_modulesContainerUserCtl_ctl00_labelErrorForLoginModule1"}
      page_inputs.each do |input|
        next if input.attributes['name'].nil?
        post_params[input.attributes['name'].value] = input.attributes['value'].try(:value) || ''
      end

      response = HTTParty.post(url, body: post_params, options: { headers: { 'Content-Type' => 'application/x-www-form-urlencoded' } })

      result = !(response.body =~ /Welcome,/).nil?
    end

    respond_to do |format|
      format.json do
        render json: {result: result}, status: 200
      end
    end
  end
end
