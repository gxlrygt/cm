class LeadsController < ApplicationController
  def create
    Lead.create!(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], phone: params[:phone])

    respond_to do |format|
      format.json do
        render json: {message: "Lead created"}, status: 200
      end
    end
  end
end