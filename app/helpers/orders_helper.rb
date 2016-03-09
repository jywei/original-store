module OrdersHelper

  def render_order_paid_state(order)
    if order.is_paid?
      "paid"
    else
      "not paid"
    end
  end

end
