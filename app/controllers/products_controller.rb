class ProductsController < ApplicationController
  respond_to :html

  def index
    @products = Product.all
    respond_with(@products)
  end

  def show
    @product = Product.find(params[:id])
    respond_with(@product)
  end

end