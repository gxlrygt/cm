class User < ActiveRecord::Base
  module ROLE
    Admin = "Admin"
    LoanOfficer = "Loan Officer"
    Processor = "Processor"
  end
  ROLES = [ROLE::Admin, ROLE::LoanOfficer, ROLE::Processor]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :external_site_passwords, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :external_site_passwords

  validates :email, :first_name, :last_name, presence: true
  validates_uniqueness_of :email, :case_sensitive => false

  def name
    "#{first_name} #{last_name}"
  end

  after_create :create_external_site_passwords

  def street_smart_valuations_credentials
    external_site_passwords.find_by(external_site: ExternalSitePassword::EXTERNAL_SITE::STREET_SMART)
  end

  private

  def create_external_site_passwords
    ExternalSitePassword::EXTERNAL_SITES.each do |site|
      external_site_passwords.create!(external_site: site)
    end
  end
end