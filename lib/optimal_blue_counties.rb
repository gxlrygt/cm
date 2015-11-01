# Class that loads counties and caches them
class OptimalBlueCounties
  @@counties = {}

  def self.initialize_all_counties
    ["AZ", "CA", "CO", "TX"].each do |state_code|
      @@counties[state_code] = OptimalBlueService::CountySearch.new(state_code).perform
    end
  end

  def self.counties_for_state(state_code)
    @@counties[state_code] ||= OptimalBlueService::CountySearch.new(state_code).perform
  end

end
