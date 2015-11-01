class ContactFormsController < ApplicationController
  respond_to :json

  def create
    @contact_form = ContactForm.create!(name: params[:name], email: params[:email], company: params[:company], regarding: params[:regarding], message: params[:message])

    respond_with(@contact_form)
  end
end