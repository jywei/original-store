class Admin::ProductsController < AdminController

  def index
    @products = Product.all

    respond_to do |format|
      format.json
      format.html
    end
  end

  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  def edit
    @product = Product.find(params[:id])

    if @product.photo.present?
      @photo = @product.photo
    else
      @photo = @product.build_photo
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      flash[:success] = "The product is successfully updated"
      redirect_to admin_products_path
    else
      flash[:error] = "The product is not saved, try again"
      render :edit
    end
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
    params.require(:product).permit(:title, :body, :quantity, :price, photo_attributes: [:image, :id])
  end
end
