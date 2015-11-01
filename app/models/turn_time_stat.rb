class TurnTimeStat < ActiveRecord::Base
  DEFAULT_DRAWING_DOCS = "1-2"
  DEFAULT_UNDERWRITING = "2"
  DEFAULT_CONDITIONS = "2"
  DEFAULT_FUNDING = "1-2"
  
  def drawing_docs_time
    drawing_docs.present? ? drawing_docs : DEFAULT_DRAWING_DOCS
  end

  def underwriting_time
    underwriting.present? ? underwriting : DEFAULT_UNDERWRITING
  end

  def conditions_time
    conditions.present? ? conditions : DEFAULT_CONDITIONS
  end

  def funding_time
    funding.present? ? funding : DEFAULT_FUNDING
  end
end