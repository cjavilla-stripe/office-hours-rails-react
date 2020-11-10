class Api::V1::PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    session = Stripe::Checkout::Session.create(
      mode: 'payment',
      payment_method_types: ['card', 'ideal', 'giropay', 'sepa_debit'],
      success_url: root_url, # Thank you page.
      cancel_url: root_url,
      line_items: [{
        quantity: 1,
        price: 'price_1Hlk2sCZ6qsJgndJ1XrpUiyD',
      }]
    )

    render json: session
  end
end
