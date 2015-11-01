class BrokerFormsMailer < ApplicationMailer
  default :from => "Commerce Wholesale <noreply@cm-wholesale.rpgdevelopers.com>"

  def send_pdfs(broker_approval_form)
    @broker_approval_form = broker_approval_form
    attachments.inline['logo-all-black.png'] = File.read(File.join(Rails.root, "app", "assets", "images", "logo-all-black.png"))
    mail(to: @broker_approval_form.email, subject: 'Thanks for submitting the broker approval form.')
    #mail(to: "richard.j.young@gmail.com", subject: 'Thanks for submitting the broker approval form.')
  end

  # brokers@commercemtg.com
  def notify_brokers(broker_approval_form)
    @broker_approval_form = broker_approval_form
    mail(to: "brokers@commercemtg.com", bcc: ["Torin Stafford <tstafford@commercemtg.com>", "Richard Young <richard.j.young@gmail.com>"], subject: "#{broker_approval_form.company} has submitted a broker approval form.")
    #mail(to: "richard.j.young@gmail.com", subject: "#{broker_approval_form.company} has submitted a broker approval form.")
  end
end
