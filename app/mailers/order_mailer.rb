class OrderMailer < ApplicationMailer
  def notify_order_placed(order)
    @order       = order
    @user        = order.user
    @order_items = @order.items
    @order_info  = @order.info

    mail(to: @user.email , subject: "[Craving] Thank you for the order, check the purchasement details #{order.token}")
  end
end
