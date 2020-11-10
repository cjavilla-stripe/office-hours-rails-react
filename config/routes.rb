Rails.application.routes.draw do
  # GET /
  root 'static_pages#root'

  # POST /api/v1/payments
  namespace :api do
    namespace :v1 do
      resources :payments, only: [:create]
    end
  end

  get '/*path', to: 'static_pages#root'
end
