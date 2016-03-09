class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @item.product
    @item.destroy

    flash[:warning] = "You have successfully remove #{@product.title} from the cart"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])

    if @item.product.quantity >= item_params[:quantity].to_i
      @item.update(item_params)
    else
      flash[:warning] = "Supply in stock is not enough for your order, sorry!"
    end

    redirect_to carts_path
  end

  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end
