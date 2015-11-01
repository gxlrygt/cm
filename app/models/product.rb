class Product < ActiveRecord::Base
  module ProductTypes
    JUMBO_EXPRESS = "Jumbo Express"
    JUMBO_PLUS = "Jumbo Plus"
  end

  validates :name, :table_html, presence: true
  validates :name, uniqueness: true
end
