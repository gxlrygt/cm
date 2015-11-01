class LoanProgramsController < ApplicationController
  def index
    @jumbo_express_product = Product.find_by(name: Product::ProductTypes::JUMBO_EXPRESS)
    @jumbo_plus_product = Product.find_by(name: Product::ProductTypes::JUMBO_PLUS)
  end

  def conventional
  end

  def arms
  end

  def harp
  end

  def government
  end
end