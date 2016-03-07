class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "The product is successfully saved"
      redirect_to admin_products_path
    else
      flash[:error] = "The product is not saved, try again"
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :body, :quantity, :price)
  end
end
