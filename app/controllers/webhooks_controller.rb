class WebhooksController < ApplicationController
  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.stripe[:webhook_secret]
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      render json: { message: e }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render json: { message: e }, status: 400
      return
    end

    if event.type == 'checkout.session.completed'
      puts "Checkout complete, enjoy that coffee~!"
    end

    render json: { message: 'success' }
  end
end
