class ContactFormsMailer < ApplicationMailer
  default :from => "Commerce Wholesale <noreply@cm-wholesale.rpgdevelopers.com>"

  # brokers@commercemtg.com
  def notify_brokers(contact_form)
    @contact_form = contact_form
    #mail(to: ["csong@commercemtgwholesale.com", "shabi@commercemtgwholesale.com"], subject: "#{contact_form.name} has submitted a contact form on the wholesale website.")
    mail(to: "brokers@chmwholesale.com", subject: "#{contact_form.name} has submitted a contact form on the wholesale website.")
  end
end
