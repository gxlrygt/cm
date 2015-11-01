class ExternalSitePassword < ActiveRecord::Base
  module EXTERNAL_SITE
    TPO = "TPO"
    STREET_SMART = "Street Smart Valuations"
    OPTIMAL_BLUE = "Optimal Blue"
  end
  EXTERNAL_SITES = [EXTERNAL_SITE::TPO, EXTERNAL_SITE::STREET_SMART, EXTERNAL_SITE::OPTIMAL_BLUE].freeze

  crypt_keeper :password, encryptor: :aes_new, key: ENV['CRYPT_PASSWORD'], salt: ENV['CRYPT_SALT']

  validates :user, :external_site, presence: true
  validates :external_site, inclusion: { in: EXTERNAL_SITES }

  belongs_to :user, inverse_of: :external_site_passwords
end
