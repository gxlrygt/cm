class State < ActiveRecord::Base
  validates :name, :code, presence: true

  def self.selectable_states
    where("code IN (?)", ["AZ", "CA", "CO", "TX"])
  end

  def self.california
    find_by(code: "CA")
  end
end
