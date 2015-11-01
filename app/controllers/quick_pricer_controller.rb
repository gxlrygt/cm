class QuickPricerController < ApplicationController
  before_filter :clean_search_parameters, only: :search

  def index
  end

  def search
    respond_to do |format|
      format.json { render json: OptimalBlueService::QuickSearch.new(QuickPricer.new(params[:quick_pricer])).perform }
    end
  end

  private

  def clean_search_parameters
    if params[:quick_pricer][:product_type].present?
      params[:quick_pricer][:product_type] = params[:quick_pricer][:product_type].collect { |k, v| v }.reject { |v| v.blank? }
    end

    if params[:quick_pricer][:loan_term].present?
      params[:quick_pricer][:loan_term] = params[:quick_pricer][:loan_term].collect { |k, v| v }.reject { |v| v.blank? }
    end

    if params[:quick_pricer][:amortization_type].present?
      params[:quick_pricer][:amortization_type] = params[:quick_pricer][:amortization_type].collect { |k, v| v }.reject { |v| v.blank? }
    end

    if params[:quick_pricer][:arm_fixed_term].present?
      params[:quick_pricer][:arm_fixed_term] = params[:quick_pricer][:arm_fixed_term].collect { |k, v| v }.reject { |v| v.blank? }
    end
  end

end
