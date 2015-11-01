class LoansMailer < ApplicationMailer
  default :from => "Commerce Wholesale <noreply@cm-wholesale.rpgdevelopers.com>"

  def send_cover_page(loan, email)
    @loan = loan
    attachments.inline['logo-all-black.png'] = File.read(File.join(Rails.root, "app", "assets", "images", "logo-all-black.png"))
    mail(to: email, bcc: ["Richard Young <richard.j.young@gmail.com>"], subject: "Thank you! Please complete your loan submission with CHMW")
    #mail(to: "richard.j.young@gmail.com", subject: "Thank you! Please complete your loan submission with CHMW")
  end

  # brokers@commercemtg.com
  def notify_brokers(loan)
    @loan = loan
    mail(to: "brokers@commercemtg.com", bcc: ["Torin Stafford <tstafford@commercemtg.com>", "Richard Young <richard.j.young@gmail.com>"], subject: "#{@loan.broker_name} has submitted a loan")
  end
end
