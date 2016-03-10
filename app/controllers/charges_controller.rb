class ChargesController < ApplicationController

  before_action :authenticate_user!

  def create

    @order = current_user.orders.find_by_token(params[:order_id])
    @amount = @order.total * 100 # in cents

    customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
    )

    @order.set_payment_with!("credit_card")
    @order.make_payment!
    redirect_to order_path(@order.token), :notice => "Payment is completed"

    rescue Stripe::CardError => e
      flash[:error] = e.message
      render "orders/pay_with_credit_card"

  end

end
