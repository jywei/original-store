class StripeCharge

  attr_reader :error_message, :response, :email

  def initialize(options={})
    @response = options[:response]
    @error_message = options[:error_message]
    @email = options[:email]
  end

  def self.create(options={})

    Stripe.api_key = Rails.configuration.stripe[:secret_key]
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )


    begin
      response = Stripe::Charge.create(
        customer: customer.id,
        amount: options[:amount],
        currency: "usd",
        card: options[:card],
        description: options[:description]
        )
      new(:response => response)
    rescue Stripe::CardError => e
      new(:error_message => e.message)
    end
  end

  def successful?
    @response.present?
  end

end
