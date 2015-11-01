class ContactForm < ActiveRecord::Base
  validates :name, :email, presence: true

  after_create :notify_brokers

  private

  def notify_brokers
    ContactFormsMailer.delay.notify_brokers(self)
  end
end